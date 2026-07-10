---
description: Start a subagent and load the Hunk skill for a review
---

Start a `reviewer` subagent to review the active Hunk session. Instruct it to run `hunk skill path`, read the returned skill instructions, inspect the active Hunk review, and return findings by severity with file:line references and concrete fixes. Do not modify files or post comments unless I ask.
