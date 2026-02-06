**LinkedIn Outreach Tool**

Integration Contract & Split Plan

Last updated: February 2026

# **0\. Design Decisions (Resolved)**

These were gaps in the original plan. All have been resolved. Both developers should treat these as final.

### **0.1 Draft Message Storage**

RESOLVED: A draft\_message column has been added to the contacts table. The Gemini-generated draft is written here during enrichment. The user can edit it in the frontend before sending. When they send, the final text is copied into outreach\_attempts.message\_body. The contacts table is the source of truth for unsent drafts.

### **0.2 Strategy Tags Use a Fixed Enum**

RESOLVED: Strategy tags use a PostgreSQL enum: PAIN\_POINT, VALIDATION\_ASK, DIRECT\_PITCH, MUTUAL\_CONNECTION, INDUSTRY\_TREND. Gemini is prompted to return exactly one of these values. If Gemini returns something outside the enum, the Modal enrichment code should default to DIRECT\_PITCH and log a warning. This keeps analytics grouping clean.

### **0.3 Batch Processing Model**

RESOLVED: Modal processes contacts in sequential batches of 10\. One batch \= one Modal function invocation. Within a batch, contacts are processed one at a time with a 2-second delay between each (for You.com rate limits). The frontend polls GET /ingest/status/{job\_id} to show progress. Manual testing will be used to verify batch behavior — no automated test suite required at this stage.

### **0.4 Auth Flow (Frontend Dev: Read This)**

RESOLVED: Supabase Auth handles all authentication. Here is exactly what the frontend developer needs to implement:

* Set up Supabase Auth with email/password provider in the Supabase dashboard.

* Use the Supabase client SDK (@supabase/supabase-js) for signup, login, and session management in React.

* After a user signs up, insert a row into the profiles table with id \= auth.users.id. This can be done via a Supabase database trigger (recommended) or from the frontend after signup.

* On every API call to Modal, include the user\_id (from the Supabase session) in the request body or query params.

* Set up Row Level Security (RLS) on all tables. Policy: users can only SELECT/INSERT/UPDATE rows where user\_id \= auth.uid(). This is critical — without RLS, any user can read any other user's data.

* Modal receives user\_id in API calls and uses the Supabase service role key to read/write data. Modal does NOT handle auth tokens or JWTs from the browser. The service role key bypasses RLS, so Modal can access any row it needs.

* The Supabase service role key must NEVER be exposed to the frontend. It goes in Modal's environment variables only.

### **0.5 Research API**

RESOLVED: You.com is the only research API. There is no second API. All company research goes through You.com's search endpoint.

────────────────────────────────────────────────────────────

# **1\. Database Schemas (Supabase / PostgreSQL)**

All tables below are the single source of truth. Both developers must use these exact column names and types.

## **1.1 profiles**

{  
  "table": "profiles",  
  "columns": {  
    "id": {  
      "type": "uuid",  
      "constraint": "PRIMARY KEY REFERENCES auth.users(id)",  
      "description": "Matches Supabase Auth user ID"  
    },  
    "mission\_statement": {  
      "type": "text",  
      "constraint": "NOT NULL",  
      "description": "User’s north star, e.g. I want to reduce food waste"  
    },  
    "intent\_type": {  
      "type": "enum(VALIDATION, SALES)",  
      "constraint": "NOT NULL",  
      "description": "Learning vs. Selling mode"  
    },  
    "created\_at": {  
      "type": "timestamptz",  
      "default": "now()"  
    }  
  }  
}

## **1.2 contacts**

{  
  "table": "contacts",  
  "columns": {  
    "id": {  
      "type": "uuid",  
      "constraint": "PRIMARY KEY DEFAULT gen\_random\_uuid()"  
    },  
    "user\_id": {  
      "type": "uuid",  
      "constraint": "NOT NULL REFERENCES profiles(id)"  
    },  
    "full\_name": { "type": "text" },  
    "linkedin\_url": { "type": "text" },  
    "raw\_role": {  
      "type": "text",  
      "description": "Uncleaned job title from CSV"  
    },  
    "company\_name": { "type": "text" },  
    "status": {  
      "type": "enum(NEW, RESEARCHING, DRAFT\_READY, SENT, ARCHIVED)",  
      "default": "NEW",  
      "description": "RESEARCHING added for progress tracking during batch processing"  
    },  
    "draft\_message": {  
      "type": "text",  
      "nullable": true,  
      "description": "Gemini-generated draft. Populated during enrichment. Editable by user before sending."  
    },  
    "strategy\_tag": {  
      "type": "enum(PAIN\_POINT, VALIDATION\_ASK, DIRECT\_PITCH, MUTUAL\_CONNECTION, INDUSTRY\_TREND)",  
      "nullable": true,  
      "description": "Set by Gemini during enrichment. Used for analytics grouping."  
    },  
    "created\_at": {  
      "type": "timestamptz",  
      "default": "now()"  
    }  
  }  
}

## **1.3 research**

{  
  "table": "research",  
  "columns": {  
    "id": {  
      "type": "uuid",  
      "constraint": "PRIMARY KEY DEFAULT gen\_random\_uuid()"  
    },  
    "contact\_id": {  
      "type": "uuid",  
      "constraint": "NOT NULL REFERENCES contacts(id) UNIQUE"  
    },  
    "news\_summary": {  
      "type": "text",  
      "description": "From You.com: Company just raised Series B"  
    },  
    "pain\_points": {  
      "type": "text",  
      "description": "From You.com: Struggling with scaling ops"  
    },  
    "source\_url": {  
      "type": "text",  
      "description": "Link to source article for trust/verification"  
    },  
    "raw\_response": {  
      "type": "jsonb",  
      "nullable": true,  
      "description": "Full You.com API response for debugging"  
    },  
    "last\_updated": {  
      "type": "timestamptz",  
      "default": "now()"  
    }  
  }  
}

## **1.4 outreach\_attempts**

{  
  "table": "outreach\_attempts",  
  "columns": {  
    "id": {  
      "type": "uuid",  
      "constraint": "PRIMARY KEY DEFAULT gen\_random\_uuid()"  
    },  
    "contact\_id": {  
      "type": "uuid",  
      "constraint": "NOT NULL REFERENCES contacts(id)"  
    },  
    "strategy\_tag": {  
      "type": "enum(PAIN\_POINT, VALIDATION\_ASK, DIRECT\_PITCH, MUTUAL\_CONNECTION, INDUSTRY\_TREND)",  
      "description": "Copied from contacts.strategy\_tag at send time"  
    },  
    "message\_body": {  
      "type": "text",  
      "constraint": "NOT NULL",  
      "description": "The exact text the user sent (may be edited from draft)"  
    },  
    "sent\_at": {  
      "type": "timestamptz",  
      "default": "now()"  
    },  
    "feedback\_due\_at": {  
      "type": "timestamptz",  
      "description": "sent\_at \+ 3 days. Simplifies the feedback queue query."  
    },  
    "feedback\_status": {  
      "type": "enum(PENDING, COMPLETED)",  
      "default": "PENDING"  
    },  
    "outcome": {  
      "type": "enum(REPLIED, GHOSTED, BOUNCED)",  
      "nullable": true  
    }  
  }  
}

## **1.5 enrichment\_jobs (New Table)**

Tracks batch processing status so the frontend can show progress.

{  
  "table": "enrichment\_jobs",  
  "columns": {  
    "id": {  
      "type": "uuid",  
      "constraint": "PRIMARY KEY DEFAULT gen\_random\_uuid()"  
    },  
    "user\_id": {  
      "type": "uuid",  
      "constraint": "NOT NULL REFERENCES profiles(id)"  
    },  
    "total\_contacts": { "type": "integer" },  
    "processed\_count": {  
      "type": "integer",  
      "default": 0  
    },  
    "failed\_count": {  
      "type": "integer",  
      "default": 0  
    },  
    "status": {  
      "type": "enum(RUNNING, COMPLETED, FAILED)",  
      "default": "RUNNING"  
    },  
    "created\_at": {  
      "type": "timestamptz",  
      "default": "now()"  
    },  
    "completed\_at": {  
      "type": "timestamptz",  
      "nullable": true  
    }  
  }  
}

────────────────────────────────────────────────────────────

# **2\. API Endpoints (Modal / FastAPI)**

Base URL to be determined after Modal deployment. All endpoints accept and return JSON. All require user\_id either in the body or as a query param. Modal validates user\_id exists in profiles via Supabase service role.

## **2.1 POST /ingest/upload**

**Owner:** You (Modal)

Request: multipart/form-data  
  \- file: Connections.csv  
  \- user\_id: uuid

Response 200:  
{  
  "contacts\_created": 47,  
  "contacts\_skipped": 3,  
  "job\_id": "uuid",  
  "message": "47 contacts queued for enrichment"  
}  
Logic: Parse CSV, filter rows with empty company\_name, bulk insert into contacts (status: NEW), create enrichment\_jobs row, trigger enrich\_batch.

## **2.2 Background: enrich\_batch**

**Owner:** You (Modal)

Not a public endpoint. Triggered internally by /ingest/upload. Processes contacts in batches of 10\.

For each contact in batch:  
  1\. Set contact.status \= RESEARCHING  
  2\. Call You.com: search("{company\_name} recent news problems")  
  3\. Insert into research table  
  4\. Call Gemini with:  
     \- user mission\_statement  
     \- user intent\_type  
     \- research summary  
     \- contact raw\_role  
     Prompt Gemini to return JSON:  
     {  
       "draft\_message": "string",  
       "strategy\_tag": "PAIN\_POINT | VALIDATION\_ASK | ..."  
     }  
  5\. Update contact:  
     \- draft\_message \= gemini.draft\_message  
     \- strategy\_tag \= gemini.strategy\_tag  
     \- status \= DRAFT\_READY  
  6\. Increment enrichment\_jobs.processed\_count

Rate limiting: 2 second delay between contacts.  
On failure: log error, increment failed\_count, continue to next.

## **2.3 GET /ingest/status/{job\_id}**

**Owner:** You (Modal)

Response 200:  
{  
  "job\_id": "uuid",  
  "status": "RUNNING",  
  "total\_contacts": 47,  
  "processed\_count": 14,  
  "failed\_count": 1  
}  
Frontend polls this every 3-5 seconds to update the progress bar.

## **2.4 GET /feed/drafts**

**Owner:** You (Modal) provides endpoint. Frontend (your friend) consumes it.

Query params: user\_id, limit (default 20), offset (default 0\)

Response 200:  
{  
  "drafts": \[  
    {  
      "contact\_id": "uuid",  
      "full\_name": "Jane Doe",  
      "raw\_role": "VP Ops @ Acme",  
      "company\_name": "Acme Corp",  
      "linkedin\_url": "https://linkedin.com/in/janedoe",  
      "draft\_message": "Hi Jane, I noticed Acme...",  
      "strategy\_tag": "PAIN\_POINT",  
      "research": {  
        "news\_summary": "Acme raised Series B last month",  
        "pain\_points": "Scaling operations challenges",  
        "source\_url": "https://techcrunch.com/..."  
      }  
    }  
  \],  
  "total": 47,  
  "has\_more": true  
}  
SQL: SELECT contacts.\*, research.\* FROM contacts JOIN research ON contacts.id \= research.contact\_id WHERE contacts.user\_id \= $1 AND contacts.status \= 'DRAFT\_READY' LIMIT $2 OFFSET $3

## **2.5 POST /action/send**

**Owner:** You (Modal)

Request body:  
{  
  "contact\_id": "uuid",  
  "message\_body": "The actual text user sent (may be edited)",  
  "strategy\_tag": "PAIN\_POINT"  
}

Response 200:  
{  
  "outreach\_id": "uuid",  
  "feedback\_due\_at": "2026-02-09T..."  
}  
Logic: Update contacts.status \= SENT. Insert into outreach\_attempts with feedback\_due\_at \= now() \+ 3 days.

## **2.6 GET /feedback/queue**

**Owner:** You (Modal)

Query params: user\_id

Response 200:  
{  
  "pending": \[  
    {  
      "outreach\_id": "uuid",  
      "full\_name": "Jane Doe",  
      "company\_name": "Acme Corp",  
      "strategy\_tag": "PAIN\_POINT",  
      "sent\_at": "2026-02-03T...",  
      "message\_preview": "Hi Jane, I noticed..."  
    }  
  \]  
}  
SQL: SELECT outreach\_attempts.\*, contacts.full\_name, contacts.company\_name FROM outreach\_attempts JOIN contacts ON ... WHERE feedback\_due\_at \<= now() AND feedback\_status \= 'PENDING'

## **2.7 POST /feedback/swipe**

**Owner:** You (Modal)

Request body:  
{  
  "outreach\_id": "uuid",  
  "outcome": "REPLIED"  
}

Response 200: { "ok": true }

## **2.8 GET /analytics/dashboard**

**Owner:** You (Modal)

Query params: user\_id

Response 200:  
{  
  "total\_sent": 47,  
  "total\_completed": 30,  
  "total\_replied": 6,  
  "global\_reply\_rate": 0.20,  
  "by\_strategy": \[  
    {  
      "strategy\_tag": "PAIN\_POINT",  
      "sent": 15,  
      "replied": 4,  
      "reply\_rate": 0.267  
    },  
    {  
      "strategy\_tag": "VALIDATION\_ASK",  
      "sent": 12,  
      "replied": 2,  
      "reply\_rate": 0.167  
    }  
  \]  
}

────────────────────────────────────────────────────────────

# **3\. Work Split**

## **3.1 Your Work (Modal \+ Third-Party APIs)**

Everything that runs on Modal and talks to external APIs.

* Modal project setup, deployment, environment variables (SUPABASE\_URL, SUPABASE\_SERVICE\_KEY, YOUCOM\_API\_KEY, GEMINI\_API\_KEY)

* POST /ingest/upload — CSV parsing, Supabase inserts, triggering enrichment

* enrich\_batch — You.com calls, Gemini calls, writing results back to Supabase

* GET /ingest/status/{job\_id} — reading enrichment\_jobs table

* GET /feed/drafts — reading contacts \+ research from Supabase

* POST /action/send — updating contacts, inserting outreach\_attempts

* GET /feedback/queue — querying outreach\_attempts

* POST /feedback/swipe — updating outreach\_attempts

* GET /analytics/dashboard — aggregation queries

* Gemini prompt engineering (system prompt that enforces strategy\_tag enum and JSON output)

* Rate limiting and error handling for You.com and Gemini

## **3.2 Your Friend's Work (Frontend \+ Supabase)**

Everything that runs in the browser and Supabase setup.

* Supabase project setup — create database, run SQL migrations from schemas above

* Supabase Auth — email/password signup and login

* Row Level Security (RLS) policies on all tables so users can only see their own data

* React app via Lovable, deployed on Render

* Screen 1 (Onboarding): mission statement input, intent type selector, writes to profiles

* Screen 2 (Upload): drag-and-drop CSV, calls POST /ingest/upload, polls GET /ingest/status/{job\_id}

* Screen 3 (Lab): fetches GET /feed/drafts, displays cards, editable draft text area, Copy & Open LinkedIn button that calls POST /action/send

* Screen 4 (Loop): fetches GET /feedback/queue, swipe UI, calls POST /feedback/swipe

* Screen 5 (Analytics): fetches GET /analytics/dashboard, renders charts

* CORS handling — Render frontend origin must be allowed in Modal CORS config

────────────────────────────────────────────────────────────

# **4\. Integration Checkpoints**

To avoid building in isolation and discovering mismatches at the end, sync at these points.

### **Checkpoint 1: Schema Lock**

Both agree on the exact SQL. Your friend runs migrations. You verify you can read/write from Modal with the service role key. Test: insert a row from Modal, read it from the frontend.

### **Checkpoint 2: Upload Flow**

You deploy /ingest/upload and /ingest/status. Your friend wires up the upload UI. Test: upload a 10-row CSV, watch the progress bar, verify contacts appear in Supabase.

### **Checkpoint 3: Feed \+ Send**

You deploy /feed/drafts and /action/send. Your friend builds the Lab screen. Test: drafts appear, user can edit, Copy & Open works, outreach\_attempts row is created.

### **Checkpoint 4: Feedback \+ Analytics**

Final integration. Test: swipe a few, verify analytics numbers are correct.

────────────────────────────────────────────────────────────

# **5\. Shared Configuration**

## **5.1 Environment Variables**

| Variable | Owner | Where |
| :---- | :---- | :---- |
| SUPABASE\_URL | Friend | Both (Modal \+ Frontend) |
| SUPABASE\_ANON\_KEY | Friend | Frontend only |
| SUPABASE\_SERVICE\_KEY | Friend | Modal only (never expose to browser) |
| YOUCOM\_API\_KEY | You | Modal only |
| GEMINI\_API\_KEY | You | Modal only |
| MODAL\_BASE\_URL | You | Frontend (to call API) |

## **5.2 CORS**

Modal FastAPI must allow the Render frontend origin. Set this in your Modal app's CORS middleware. Your friend gives you the Render URL once deployed.

## **5.3 Enums (Create in Supabase)**

Your friend should create these PostgreSQL enums before creating tables:

CREATE TYPE intent\_type AS ENUM ('VALIDATION', 'SALES');  
CREATE TYPE contact\_status AS ENUM ('NEW', 'RESEARCHING', 'DRAFT\_READY', 'SENT', 'ARCHIVED');  
CREATE TYPE strategy\_tag AS ENUM ('PAIN\_POINT', 'VALIDATION\_ASK', 'DIRECT\_PITCH', 'MUTUAL\_CONNECTION', 'INDUSTRY\_TREND');  
CREATE TYPE feedback\_status AS ENUM ('PENDING', 'COMPLETED');  
CREATE TYPE outcome\_type AS ENUM ('REPLIED', 'GHOSTED', 'BOUNCED');  
CREATE TYPE job\_status AS ENUM ('RUNNING', 'COMPLETED', 'FAILED');

