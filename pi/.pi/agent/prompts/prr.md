---
description: Start a subagent to review a GitHub PR by number or URL
argument-hint: "<PR-number-or-URL>"
---
Start a `reviewer` subagent to review GitHub PR $1.

1. Resolve $1 to a PR number (strip URL). Gather context: `gh pr view <n>`, `gh pr diff <n>`, `gh pr view <n> --json reviews,comments`, and `git log <base>..<head> --oneline` (fetch the head ref first if needed: `git fetch origin <head>` or `gh pr checkout <n>`).
2. Delegate to a `reviewer` subagent with the PR metadata + diff, instructed to review two axes — **Standards** (repo conventions: AGENTS.md / CONTRIBUTING / lint) and **Spec** (does the diff do what the PR claims) — and report findings by severity (blocker / major / minor / nit) with file:line refs and concrete fixes. No preamble.
3. Return the review. Don't post to GitHub unless I ask.