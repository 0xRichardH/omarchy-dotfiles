---
name: opencode-conversation-recall
description: Find and inspect past OpenCode conversations stored in the local SQLite database. Use when the user asks to recall, search, find, or review a previous conversation, or asks "what did we talk about", "find that conversation where...", "show me past sessions", or any request to look up prior chat history.
---

# Conversation Recall

Query the OpenCode SQLite database to find and display past conversations.

## Database Access

Run queries via the `opencode db` CLI:

```bash
# Run a query (tsv is default and most token-efficient)
opencode db "SELECT ..."

# Get the database file path
opencode db path
```

## Schema

### `session` table (conversations)

| Column | Type | Description |
|--------|------|-------------|
| id | text PK | Session ID (e.g. `ses_...`) |
| project_id | text | Project this session belongs to |
| directory | text | Working directory |
| title | text | Conversation title |
| time_created | integer | Creation timestamp (ms epoch) |
| time_updated | integer | Last update timestamp (ms epoch) |

### `message` table

| Column | Type | Description |
|--------|------|-------------|
| id | text PK | Message ID |
| session_id | text FK | References session.id |
| data | text | JSON: `{role, time: {created, completed}, ...}` |

### `part` table (message content)

| Column | Type | Description |
|--------|------|-------------|
| id | text PK | Part ID |
| message_id | text FK | References message.id |
| session_id | text | Session ID |
| data | text | JSON: `{type, text, ...}` |
| time_created | integer | Timestamp (ms epoch) |

Only parts with `json_extract(data, '$.type') = 'text'` contain conversation text. The text content is in `json_extract(data, '$.text')`.

## Workflow

### 1. Search for conversations

When the user asks to find a conversation, search the `part` table for matching text and group by session:

```sql
SELECT
  p.session_id,
  s.title,
  s.directory,
  datetime(s.time_created / 1000, 'unixepoch', 'localtime') as created,
  COUNT(DISTINCT p.message_id) as matching_messages
FROM part p
JOIN session s ON s.id = p.session_id
WHERE json_extract(p.data, '$.type') = 'text'
  AND json_extract(p.data, '$.text') LIKE '%SEARCH_TERM%'
GROUP BY p.session_id
ORDER BY s.time_updated DESC
LIMIT 10
```

### 2. List recent conversations

```sql
SELECT
  s.id,
  s.title,
  s.directory,
  datetime(s.time_created / 1000, 'unixepoch', 'localtime') as created,
  datetime(s.time_updated / 1000, 'unixepoch', 'localtime') as updated
FROM session s
ORDER BY s.time_updated DESC
LIMIT 20
```

### 3. Read a specific conversation

Once a session is identified, retrieve the full conversation text in order:

```sql
SELECT
  json_extract(m.data, '$.role') as role,
  json_extract(p.data, '$.text') as text
FROM part p
JOIN message m ON m.id = p.message_id
WHERE p.session_id = 'SESSION_ID'
  AND json_extract(p.data, '$.type') = 'text'
ORDER BY json_extract(m.data, '$.time.created') ASC
```

## Guidelines

- Default to `--format tsv` (the default) to minimize token usage. Use `--format json` only when structured parsing is strictly required.
- When searching, use `LIKE '%term%'` with `COLLATE NOCASE` for case-insensitive matching.
- Summarize conversations rather than dumping raw text unless the user asks for full content.
- If multiple sessions match, present a numbered list with title, date, and directory so the user can pick one.
- Timestamps are millisecond epoch; convert with `datetime(ts / 1000, 'unixepoch', 'localtime')`.
