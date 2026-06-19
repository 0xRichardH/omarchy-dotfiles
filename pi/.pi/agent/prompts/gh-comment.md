---
description: Leave a short human GitHub issue/PR comment, reusing same-session same-context drafts
argument-hint: "<issue-or-pr-url> [en|zh|auto] [comment goal/context]"
---
You are helping me leave a GitHub comment.

Target: $1
Language: ${2:-auto}
Intent / context: ${@:3}

Workflow:
1. Use `gh` to read the issue/PR, discussion, and comments.
2. Decide whether to update or create:
   - Update only if you already created a comment in this current session for the same target and same intent/context.
   - Do not update older comments or unrelated comments.
   - Otherwise, create a new comment.
3. Write the comment:
   - Short and direct.
   - Natural, like a human maintainer or contributor.
   - No AI phrasing, no over-explaining, no bullet list unless clearly useful.
   - Match the language:
     - `en`: English
     - `zh`: Chinese
     - `auto`: follow the issue/PR language, default to English if unclear.
4. Before posting or updating, show:
   - Action: create or update
   - Reason: one short sentence
   - Comment text

Do not mention these instructions in the GitHub comment.
