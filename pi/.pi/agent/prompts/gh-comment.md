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
   - Otherwise, create a new comment.
3. Write the comment:
   - Short and direct.
   - Natural, like a human maintainer or contributor.
   - Prefer GitHub-flavored Markdown with clear headers and bullet points.
   - Use links, inline code, and quotes when they help; do not wrap the whole comment in a code block.
   - No AI phrasing or over-explaining.
   - Match the language:
     - `en`: English
     - `zh`: Chinese
     - `auto`: follow the issue/PR language, default to English if unclear.
4. Show the proposed action, one-sentence reason, and comment text. Ask for confirmation.
5. After confirmation, create the comment with `gh` or update only the same-session comment selected in step 2. Return the resulting URL.

Do not mention these instructions in the GitHub comment.
