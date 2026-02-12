"""PRMSOE – Modal + FastAPI backend for AI-driven LinkedIn outreach."""

from __future__ import annotations

import csv
import io
import json
import logging
import os
import threading
import time
from datetime import datetime, timedelta, timezone
from enum import Enum

import modal
from fastapi import FastAPI, File, Form, HTTPException, Query, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from psycopg.rows import dict_row
from psycopg_pool import ConnectionPool

# Load .env in local dev mode (set by __main__ or manually)
if os.environ.get("LOCAL_DEV", "").lower() in ("1", "true"):
    try:
        from dotenv import load_dotenv
        load_dotenv()
    except ImportError:
        pass

LOCAL_DEV = os.environ.get("LOCAL_DEV", "").lower() in ("1", "true")

# ---------------------------------------------------------------------------
# Section 2: Modal App + Image
# ---------------------------------------------------------------------------

image = modal.Image.debian_slim(python_version="3.12").pip_install(
    "fastapi[standard]",
    "psycopg[binary]",
    "psycopg-pool",
    "google-genai",
    "python-multipart",
)

app = modal.App(name="prmsoe", image=image)

logger = logging.getLogger("prmsoe")
logging.basicConfig(level=logging.INFO)

# ---------------------------------------------------------------------------
# Section 3: Enums (mirror Postgres enums)
# ---------------------------------------------------------------------------


class ContactStatus(str, Enum):
    NEW = "NEW"
    RESEARCHING = "RESEARCHING"
    DRAFT_READY = "DRAFT_READY"
    SENT = "SENT"
    ARCHIVED = "ARCHIVED"


class StrategyTag(str, Enum):
    PAIN_POINT = "PAIN_POINT"
    VALIDATION_ASK = "VALIDATION_ASK"
    DIRECT_PITCH = "DIRECT_PITCH"
    MUTUAL_CONNECTION = "MUTUAL_CONNECTION"
    INDUSTRY_TREND = "INDUSTRY_TREND"


class FeedbackStatus(str, Enum):
    PENDING = "PENDING"
    COMPLETED = "COMPLETED"


class OutcomeType(str, Enum):
    REPLIED = "REPLIED"
    GHOSTED = "GHOSTED"
    BOUNCED = "BOUNCED"


class JobStatus(str, Enum):
    RUNNING = "RUNNING"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"


VALID_STRATEGY_TAGS = {t.value for t in StrategyTag}

# ---------------------------------------------------------------------------
# Section 4: Pydantic request/response models
# ---------------------------------------------------------------------------


class SendRequest(BaseModel):
    contact_id: str
    message_body: str
    strategy_tag: str


class SwipeRequest(BaseModel):
    outreach_id: str
    outcome: str


# ---------------------------------------------------------------------------
# Section 5: Helpers
# ---------------------------------------------------------------------------


_DB_POOL: ConnectionPool | None = None


def get_db_pool() -> ConnectionPool:
    global _DB_POOL
    if _DB_POOL is None:
        _DB_POOL = ConnectionPool(
            os.environ["DATABASE_URL"],
            max_size=5,
            kwargs={"row_factory": dict_row},
        )
    return _DB_POOL


def db_fetch_one(query: str, params: tuple | None = None) -> dict | None:
    pool = get_db_pool()
    with pool.connection() as conn:
        with conn.cursor() as cur:
            cur.execute(query, params)
            return cur.fetchone()


def db_fetch_all(query: str, params: tuple | None = None) -> list[dict]:
    pool = get_db_pool()
    with pool.connection() as conn:
        with conn.cursor() as cur:
            cur.execute(query, params)
            return list(cur.fetchall())


def db_execute(query: str, params: tuple | None = None) -> None:
    pool = get_db_pool()
    with pool.connection() as conn:
        with conn.cursor() as cur:
            cur.execute(query, params)
            conn.commit()


def db_execute_returning(query: str, params: tuple | None = None) -> list[dict]:
    pool = get_db_pool()
    with pool.connection() as conn:
        with conn.cursor() as cur:
            cur.execute(query, params)
            rows = list(cur.fetchall())
            conn.commit()
            return rows


def insert_contacts(rows: list[dict]) -> list[str]:
    if not rows:
        return []

    columns = (
        "user_id",
        "full_name",
        "company_name",
        "raw_role",
        "linkedin_url",
        "status",
    )
    values_sql = ",".join(["(%s, %s, %s, %s, %s, %s)"] * len(rows))
    query = (
        "INSERT INTO contacts "
        f"({', '.join(columns)}) "
        f"VALUES {values_sql} "
        "RETURNING id"
    )
    params: list[str] = []
    for row in rows:
        params.extend([
            row["user_id"],
            row["full_name"],
            row["company_name"],
            row["raw_role"],
            row["linkedin_url"],
            row["status"],
        ])
    inserted = db_execute_returning(query, tuple(params))
    return [row["id"] for row in inserted]


def generate_draft(
    mission_statement: str,
    intent_type: str,
    research_summary: str,
    raw_role: str,
    company_name: str,
    full_name: str,
) -> dict:
    """Call Gemini to generate a draft message + strategy tag."""
    from google import genai

    client = genai.Client(api_key=os.environ["GEMINI_API_KEY"])

    prompt = f"""You are a LinkedIn outreach assistant. Generate a personalized connection message.

USER CONTEXT:
- Mission: {mission_statement}
- Intent: {intent_type}

CONTACT:
- Name: {full_name}
- Role: {raw_role}
- Company: {company_name}

CONTEXT:
{research_summary}

INSTRUCTIONS:
1. Write a LinkedIn message under 300 characters. Be conversational, specific, and reference the context.
2. Choose exactly ONE strategy tag from: PAIN_POINT, VALIDATION_ASK, DIRECT_PITCH, MUTUAL_CONNECTION, INDUSTRY_TREND
3. Return ONLY valid JSON (no markdown, no code fences):
{{"draft_message": "your message here", "strategy_tag": "TAG_HERE"}}"""

    response = client.models.generate_content(
        model="gemini-2.0-flash",
        contents=prompt,
        config={
            "response_mime_type": "application/json",
        },
    )

    try:
        result = json.loads(response.text)
        draft = result.get("draft_message", "")
        tag = result.get("strategy_tag", "DIRECT_PITCH")

        if tag not in VALID_STRATEGY_TAGS:
            logger.warning(f"Gemini returned invalid strategy_tag: {tag}, defaulting to DIRECT_PITCH")
            tag = "DIRECT_PITCH"

        return {"draft_message": draft[:300], "strategy_tag": tag}
    except (json.JSONDecodeError, AttributeError, KeyError) as e:
        logger.warning(f"Gemini response parse failure: {e}")
        return {
            "draft_message": f"Hi {full_name}, I'd love to connect and learn more about your work at {company_name}.",
            "strategy_tag": "DIRECT_PITCH",
        }


# ---------------------------------------------------------------------------
# Section 6: FastAPI app + CORS
# ---------------------------------------------------------------------------

web_app = FastAPI(title="PRMSOE API")

web_app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ---------------------------------------------------------------------------
# Section 7: Endpoint handlers
# ---------------------------------------------------------------------------


@web_app.post("/ingest/upload")
async def ingest_upload(
    file: UploadFile = File(...),
    user_id: str = Form(...),
):
    """Parse LinkedIn CSV, insert contacts, kick off enrichment."""
    # Validate user exists
    profile = db_fetch_one(
        "SELECT id, mission_statement, intent_type FROM profiles WHERE id = %s",
        (user_id,),
    )
    if not profile:
        raise HTTPException(status_code=404, detail="User profile not found")

    # Read and decode CSV
    raw_bytes = await file.read()
    text = raw_bytes.decode("utf-8-sig")
    lines = text.splitlines()

    # Find the header row (LinkedIn CSVs have preamble lines)
    header_idx = None
    for i, line in enumerate(lines):
        if "First Name" in line:
            header_idx = i
            break

    if header_idx is None:
        raise HTTPException(status_code=400, detail="CSV missing expected header row with 'First Name'")

    csv_text = "\n".join(lines[header_idx:])
    reader = csv.DictReader(io.StringIO(csv_text))

    contacts_to_insert: list[dict] = []
    skipped = 0

    for row in reader:
        company = (row.get("Company") or "").strip()
        if not company:
            skipped += 1
            continue

        first = (row.get("First Name") or "").strip()
        last = (row.get("Last Name") or "").strip()
        full_name = f"{first} {last}".strip()

        contacts_to_insert.append({
            "user_id": user_id,
            "full_name": full_name,
            "company_name": company,
            "raw_role": (row.get("Position") or "").strip(),
            "linkedin_url": (row.get("URL") or "").strip(),
            "status": ContactStatus.NEW.value,
        })

    if len(contacts_to_insert) > 500:
        raise HTTPException(status_code=400, detail="CSV exceeds 500 contact limit")

    if not contacts_to_insert:
        # Empty CSV — create completed job immediately
        job_rows = db_execute_returning(
            """
            INSERT INTO enrichment_jobs (
                user_id,
                total_contacts,
                processed_count,
                failed_count,
                status,
                completed_at
            )
            VALUES (%s, %s, %s, %s, %s, %s)
            RETURNING id
            """,
            (
                user_id,
                0,
                0,
                0,
                JobStatus.COMPLETED.value,
                datetime.now(timezone.utc),
            ),
        )
        return {
            "contacts_created": 0,
            "contacts_skipped": skipped,
            "job_id": job_rows[0]["id"],
            "message": "No valid contacts found in CSV",
        }

    # Bulk insert contacts
    contact_ids = insert_contacts(contacts_to_insert)

    # Create enrichment job
    job_rows = db_execute_returning(
        """
        INSERT INTO enrichment_jobs (
            user_id,
            total_contacts,
            processed_count,
            failed_count,
            status
        )
        VALUES (%s, %s, %s, %s, %s)
        RETURNING id
        """,
        (
            user_id,
            len(contact_ids),
            0,
            0,
            JobStatus.RUNNING.value,
        ),
    )
    job_id = job_rows[0]["id"]

    # Spawn background enrichment
    if LOCAL_DEV:
        threading.Thread(
            target=enrich_batch.local,
            kwargs={"job_id": job_id, "contact_ids": contact_ids},
            daemon=True,
        ).start()
    else:
        enrich_batch.spawn(job_id=job_id, contact_ids=contact_ids)

    return {
        "contacts_created": len(contact_ids),
        "contacts_skipped": skipped,
        "job_id": job_id,
        "message": f"{len(contact_ids)} contacts queued for enrichment",
    }


@web_app.get("/ingest/status/{job_id}")
async def ingest_status(job_id: str, user_id: str = Query(...)):
    """Return enrichment job progress."""
    row = db_fetch_one(
        "SELECT * FROM enrichment_jobs WHERE id = %s AND user_id = %s",
        (job_id, user_id),
    )
    if not row:
        raise HTTPException(status_code=404, detail="Job not found")
    return {
        "job_id": row["id"],
        "status": row["status"],
        "total_contacts": row["total_contacts"],
        "processed_count": row["processed_count"],
        "failed_count": row["failed_count"],
    }


@web_app.get("/contacts/list")
async def contacts_list(
    user_id: str = Query(...),
    limit: int = Query(default=10, le=100),
    offset: int = Query(default=0, ge=0),
):
    """Return paginated contacts for a user (any status)."""
    total_row = db_fetch_one(
        "SELECT COUNT(*) AS total FROM contacts WHERE user_id = %s",
        (user_id,),
    )
    total = int(total_row["total"]) if total_row else 0

    contacts = db_fetch_all(
        """
        SELECT id, full_name, raw_role, company_name, linkedin_url, status, created_at
        FROM contacts
        WHERE user_id = %s
        ORDER BY created_at DESC
        LIMIT %s OFFSET %s
        """,
        (user_id, limit, offset),
    )

    return {
        "contacts": contacts,
        "total": total,
        "has_more": (offset + limit) < total,
    }


@web_app.get("/feed/drafts")
async def feed_drafts(
    user_id: str = Query(...),
    limit: int = Query(default=20, le=100),
    offset: int = Query(default=0, ge=0),
):
    """Return contacts with DRAFT_READY status and their research."""
    total_row = db_fetch_one(
        """
        SELECT COUNT(*) AS total
        FROM contacts
        WHERE user_id = %s AND status = %s
        """,
        (user_id, ContactStatus.DRAFT_READY.value),
    )
    total = int(total_row["total"]) if total_row else 0

    contacts = db_fetch_all(
        """
        SELECT *
        FROM contacts
        WHERE user_id = %s AND status = %s
        ORDER BY created_at DESC
        LIMIT %s OFFSET %s
        """,
        (user_id, ContactStatus.DRAFT_READY.value, limit, offset),
    )

    drafts = []
    if contacts:
        contact_ids = [c["id"] for c in contacts]
        research = db_fetch_all(
            "SELECT * FROM research WHERE contact_id = ANY(%s)",
            (contact_ids,),
        )
        research_map = {r["contact_id"]: r for r in research}

        for c in contacts:
            r = research_map.get(c["id"], {})
            drafts.append({
                "contact_id": c["id"],
                "full_name": c["full_name"],
                "raw_role": c["raw_role"],
                "company_name": c["company_name"],
                "linkedin_url": c["linkedin_url"],
                "draft_message": c["draft_message"],
                "strategy_tag": c["strategy_tag"],
                "research": {
                    "news_summary": r.get("news_summary", ""),
                    "pain_points": r.get("pain_points", ""),
                    "source_url": r.get("source_url", ""),
                },
            })

    return {
        "drafts": drafts,
        "total": total,
        "has_more": (offset + limit) < total,
    }


@web_app.post("/action/send")
async def action_send(req: SendRequest):
    """Mark contact as sent and create outreach attempt."""
    # Verify contact exists
    contact = db_fetch_one(
        "SELECT id, status FROM contacts WHERE id = %s",
        (req.contact_id,),
    )
    if not contact:
        raise HTTPException(status_code=404, detail="Contact not found")

    now = datetime.now(timezone.utc)
    feedback_due = now + timedelta(days=3)

    # Update contact status
    db_execute(
        "UPDATE contacts SET status = %s WHERE id = %s",
        (ContactStatus.SENT.value, req.contact_id),
    )

    # Insert outreach attempt
    outreach_rows = db_execute_returning(
        """
        INSERT INTO outreach_attempts (
            contact_id,
            strategy_tag,
            message_body,
            sent_at,
            feedback_due_at,
            feedback_status
        )
        VALUES (%s, %s, %s, %s, %s, %s)
        RETURNING id
        """,
        (
            req.contact_id,
            req.strategy_tag,
            req.message_body,
            now,
            feedback_due,
            FeedbackStatus.PENDING.value,
        ),
    )

    return {
        "outreach_id": outreach_rows[0]["id"],
        "feedback_due_at": feedback_due.isoformat(),
    }


@web_app.get("/feedback/queue")
async def feedback_queue(user_id: str = Query(...)):
    """Return outreach attempts where feedback is due."""
    # Get user's contact IDs
    contacts = db_fetch_all(
        "SELECT id FROM contacts WHERE user_id = %s",
        (user_id,),
    )
    if not contacts:
        return {"pending": []}

    contact_ids = [c["id"] for c in contacts]
    now = datetime.now(timezone.utc)

    # Get pending outreach attempts where feedback is due
    attempts = db_fetch_all(
        """
        SELECT *
        FROM outreach_attempts
        WHERE contact_id = ANY(%s)
          AND feedback_due_at <= %s
          AND feedback_status = %s
        """,
        (contact_ids, now, FeedbackStatus.PENDING.value),
    )

    if not attempts:
        return {"pending": []}

    # Build contact lookup for names
    due_contact_ids = list({a["contact_id"] for a in attempts})
    contact_info = db_fetch_all(
        "SELECT id, full_name, company_name FROM contacts WHERE id = ANY(%s)",
        (due_contact_ids,),
    )
    contact_map = {c["id"]: c for c in contact_info}

    pending = []
    for a in attempts:
        c = contact_map.get(a["contact_id"], {})
        pending.append({
            "outreach_id": a["id"],
            "full_name": c.get("full_name", ""),
            "company_name": c.get("company_name", ""),
            "strategy_tag": a["strategy_tag"],
            "sent_at": a["sent_at"],
            "message_preview": (a.get("message_body") or "")[:80],
        })

    return {"pending": pending}


@web_app.post("/feedback/swipe")
async def feedback_swipe(req: SwipeRequest):
    """Record feedback outcome for an outreach attempt."""
    # Validate outcome
    if req.outcome not in {t.value for t in OutcomeType}:
        raise HTTPException(status_code=400, detail=f"Invalid outcome: {req.outcome}")

    result = db_fetch_one(
        "SELECT id FROM outreach_attempts WHERE id = %s",
        (req.outreach_id,),
    )
    if not result:
        raise HTTPException(status_code=404, detail="Outreach attempt not found")

    db_execute(
        """
        UPDATE outreach_attempts
        SET outcome = %s,
            feedback_status = %s
        WHERE id = %s
        """,
        (req.outcome, FeedbackStatus.COMPLETED.value, req.outreach_id),
    )

    return {"ok": True}


@web_app.get("/analytics/dashboard")
async def analytics_dashboard(user_id: str = Query(...)):
    """Aggregate outreach metrics for user."""
    # Get user's contact IDs
    contacts = db_fetch_all(
        "SELECT id FROM contacts WHERE user_id = %s",
        (user_id,),
    )
    if not contacts:
        return {
            "total_sent": 0,
            "total_completed": 0,
            "total_replied": 0,
            "global_reply_rate": 0.0,
            "by_strategy": [],
        }

    contact_ids = [c["id"] for c in contacts]

    # Build contact lookup for replied message details
    contact_info = db_fetch_all(
        "SELECT id, full_name, company_name FROM contacts WHERE id = ANY(%s)",
        (contact_ids,),
    )
    contact_map = {c["id"]: c for c in contact_info}

    rows = db_fetch_all(
        "SELECT * FROM outreach_attempts WHERE contact_id = ANY(%s)",
        (contact_ids,),
    )

    total_sent = len(rows)
    total_completed = sum(1 for r in rows if r.get("feedback_status") == FeedbackStatus.COMPLETED.value)
    total_replied = sum(1 for r in rows if r.get("outcome") == OutcomeType.REPLIED.value)
    global_reply_rate = round(total_replied / total_completed, 3) if total_completed > 0 else 0.0

    # Group by strategy
    strategy_buckets: dict[str, dict] = {}
    for r in rows:
        tag = r.get("strategy_tag", "UNKNOWN")
        bucket = strategy_buckets.setdefault(tag, {"sent": 0, "replied": 0, "replied_messages": []})
        bucket["sent"] += 1
        if r.get("outcome") == OutcomeType.REPLIED.value:
            bucket["replied"] += 1
            c = contact_map.get(r["contact_id"], {})
            bucket["replied_messages"].append({
                "full_name": c.get("full_name", ""),
                "company_name": c.get("company_name", ""),
                "message_body": r.get("message_body", ""),
                "sent_at": r.get("sent_at", ""),
            })

    by_strategy = []
    for tag, b in sorted(strategy_buckets.items()):
        by_strategy.append({
            "strategy_tag": tag,
            "sent": b["sent"],
            "replied": b["replied"],
            "reply_rate": round(b["replied"] / b["sent"], 3) if b["sent"] > 0 else 0.0,
            "replied_messages": b["replied_messages"],
        })

    return {
        "total_sent": total_sent,
        "total_completed": total_completed,
        "total_replied": total_replied,
        "global_reply_rate": global_reply_rate,
        "by_strategy": by_strategy,
    }


# ---------------------------------------------------------------------------
# Section 8: enrich_batch (background Modal function)
# ---------------------------------------------------------------------------


@app.function(
    secrets=[modal.Secret.from_name("prmsoe-secrets")],
    timeout=3600,
)
def enrich_batch(job_id: str, contact_ids: list[str]):
    """Process contacts sequentially: draft via Gemini using role/company context."""
    # Fetch user profile for mission/intent context
    job = db_fetch_one(
        "SELECT user_id FROM enrichment_jobs WHERE id = %s",
        (job_id,),
    )
    if not job:
        logger.error(f"Job {job_id} not found")
        return
    user_id = job["user_id"]

    profile = db_fetch_one(
        "SELECT mission_statement, intent_type FROM profiles WHERE id = %s",
        (user_id,),
    )
    mission = profile["mission_statement"] if profile else ""
    intent = profile["intent_type"] if profile else "VALIDATION"

    for i, contact_id in enumerate(contact_ids):
        try:
            # Set status to RESEARCHING
            db_execute(
                "UPDATE contacts SET status = %s WHERE id = %s",
                (ContactStatus.RESEARCHING.value, contact_id),
            )

            # Fetch contact details
            contact = db_fetch_one(
                "SELECT full_name, company_name, raw_role FROM contacts WHERE id = %s",
                (contact_id,),
            )
            if not contact:
                logger.warning(f"Contact {contact_id} not found, skipping")
                db_execute(
                    "UPDATE enrichment_jobs SET failed_count = failed_count + 1 WHERE id = %s",
                    (job_id,),
                )
                continue

            company = contact["company_name"]
            full_name = contact["full_name"]
            raw_role = contact["raw_role"]

            # Generate draft via Gemini (role + company context)
            research_text = f"Role: {raw_role}\nCompany: {company}"
            draft_result = generate_draft(
                mission_statement=mission,
                intent_type=intent,
                research_summary=research_text,
                raw_role=raw_role,
                company_name=company,
                full_name=full_name,
            )

            # Update contact with draft
            db_execute(
                """
                UPDATE contacts
                SET draft_message = %s,
                    strategy_tag = %s,
                    status = %s
                WHERE id = %s
                """,
                (
                    draft_result["draft_message"],
                    draft_result["strategy_tag"],
                    ContactStatus.DRAFT_READY.value,
                    contact_id,
                ),
            )

            # Increment processed count
            db_execute(
                "UPDATE enrichment_jobs SET processed_count = processed_count + 1 WHERE id = %s",
                (job_id,),
            )

            logger.info(f"Enriched contact {i + 1}/{len(contact_ids)}: {full_name} @ {company}")

        except Exception as e:
            logger.error(f"Failed to enrich contact {contact_id}: {e}")
            try:
                db_execute(
                    "UPDATE enrichment_jobs SET failed_count = failed_count + 1 WHERE id = %s",
                    (job_id,),
                )
            except Exception as inner_e:
                logger.error(f"Failed to update failed_count: {inner_e}")

        # Rate limit delay (skip after last contact)
        if i < len(contact_ids) - 1:
            time.sleep(2)

    # Mark job completed
    db_execute(
        """
        UPDATE enrichment_jobs
        SET status = %s,
            completed_at = %s
        WHERE id = %s
        """,
        (JobStatus.COMPLETED.value, datetime.now(timezone.utc), job_id),
    )

    logger.info(f"Job {job_id} completed")


# ---------------------------------------------------------------------------
# Section 9: ASGI entrypoint
# ---------------------------------------------------------------------------


@app.function(
    secrets=[modal.Secret.from_name("prmsoe-secrets")],
)
@modal.asgi_app()
def fastapi_app():
    return web_app


# ---------------------------------------------------------------------------
# Local dev: python app.py → uvicorn on :8000 with Swagger at /docs
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    import uvicorn

    os.environ["LOCAL_DEV"] = "true"
    # Re-trigger dotenv load now that LOCAL_DEV is set
    from dotenv import load_dotenv
    load_dotenv()
    uvicorn.run("app:web_app", host="0.0.0.0", port=8000, reload=True)
