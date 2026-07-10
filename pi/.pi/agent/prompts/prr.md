---
description: Start a subagent to review a GitHub PR by number or URL
argument-hint: "<PR-number-or-URL>"
---
Start a `reviewer` subagent to review GitHub PR $1.

1. Resolve $1 to a PR number (strip URL). Collect PR metadata and review context: `gh pr view <n> --json title,body,baseRefName,headRefName,headRefOid,reviews,comments`. Fetch `origin/master` and inspect the worktree.
2. **Local path:** use the current checkout only when every condition holds: the PR base is `master`; the current branch is the PR head branch; it tracks `origin/<head>`; `HEAD`, `origin/<head>`, and the PR head SHA match; and the worktree is clean. Collect `git diff origin/master...HEAD` and `git log origin/master..HEAD --oneline`.
3. **Remote path:** otherwise fetch the PR head into a temporary remote-tracking ref: `git fetch origin +pull/<n>/head:refs/remotes/origin/pr-<n>`. Collect `git diff origin/master...origin/pr-<n>` and `git log origin/master..origin/pr-<n> --oneline`.
4. Delegate to a `reviewer` subagent with the PR metadata + diff, instructed to review two axes — **Standards** (repo conventions: AGENTS.md / CONTRIBUTING / lint) and **Spec** (does the diff do what the PR claims) — and report findings by severity (blocker / major / minor / nit) with file:line refs and concrete fixes. No preamble.
5. Return the review. Don't post to GitHub unless I ask.
