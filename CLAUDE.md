# PRMSOE Fast API

Modal + FastAPI backend for AI-driven LinkedIn outreach tool (market validation engine).

## Architecture

- **Runtime**: Modal (serverless Python)
- **Framework**: FastAPI (mounted on Modal)
- **Database**: Neon Postgres (service access)
- **AI Drafts**: Google Gemini (`gemini-2.0-flash`)

## Dev Commands

```bash
uv pip install -e .          # Install deps
modal setup                   # Authenticate Modal CLI (first time)
modal serve app.py            # Local dev server with hot reload
modal deploy app.py           # Deploy to production
```

## Environment Variables

Set in Modal dashboard → Settings → Secrets (secret group: `prmsoe-secrets`):

- `DATABASE_URL` — Neon Postgres connection string
- `GEMINI_API_KEY` — Google AI Studio API key

## Key Files

- `app.py` — Modal app + FastAPI endpoints
- `pyproject.toml` — Dependencies

## Master Plan

See: `This is the Final Master Plan for your AI-Driven Market Validation Engine.md`
