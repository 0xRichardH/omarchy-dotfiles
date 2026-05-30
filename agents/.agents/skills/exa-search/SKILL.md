---
name: exa-search
description: "Load when the user needs web search, code examples, company intel, people lookup, or current information. Use for queries like 'search for', 'look up', 'find', 'what's the latest on', 'research company', 'code examples for'. Does not require a browser."
---

# Exa Search

Neural search via Exa MCP for web content, code, companies, and people.

## Setup

Requires `EXA_API_KEY` environment variable (get one at [exa.ai](https://exa.ai)).

Config is in `mcporter.json` at the skill directory. Verify with:
```bash
npx mcporter list exa --config "${SKILL_DIR}/mcporter.json" --schema
```

## Tools

All commands use `--config "${SKILL_DIR}/mcporter.json" --output json`.

### web_search_exa

General web search. Use for most queries.

```bash
npx mcporter call exa.web_search_exa query="natural language query" numResults:5 --config "${SKILL_DIR}/mcporter.json" --output json
```

**Query style:** Describe the ideal page, not keywords. `"blog post comparing React and Vue performance"` not `"React vs Vue"`.

Use `category:people` or `category:company` prefix for LinkedIn/company searches.

### web_search_advanced_exa

Use when you need filters: domains, dates, categories, or content options.

Key filters:
- `includeDomains` / `excludeDomains` — domain filtering
- `startPublishedDate` / `endPublishedDate` — ISO date (`YYYY-MM-DD`)
- `category` — `"company"`, `"research paper"`, `"news"`, `"pdf"`, `"github"`, `"people"`, etc.
- `enableHighlights` / `enableSummary` — richer content extraction

### get_code_context_exa

Use for code examples, API docs, and programming solutions.

```bash
npx mcporter call exa.get_code_context_exa query="React useState hook examples" numResults:5 --config "${SKILL_DIR}/mcporter.json" --output json
```

**Query style:** Be specific. `"Python requests library POST with JSON body"` not `"python http"`.

## Tool Selection

| Need | Tool |
|------|------|
| Quick answer | `web_search_exa` with `numResults:3-5` |
| Code/API docs | `get_code_context_exa` |
| Domain/date filters | `web_search_advanced_exa` |
| Company research | `web_search_advanced_exa` with `category:"company"` |
| People search | `web_search_advanced_exa` with `category:"people"` |
| Research papers | `web_search_advanced_exa` with `category:"research paper"` |

## Gotchas

- `EXA_API_KEY` is required — the server returns 401 without it
- Use natural language queries, not keyword-style — Exa is semantic search
- `numResults` max is 100 for `web_search_exa`, 20 for `get_code_context_exa`
- `includeDomains` takes a JSON array string: `'["github.com","react.dev"]'`
- Results include highlights by default; use `enableSummary` for AI summaries
