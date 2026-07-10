---
description: Start a subagent to review current changes (uncommitted or recent commits)
argument-hint: "[base-ref or HEAD~N, default HEAD~1]"
---
Start a `reviewer` subagent to review my current changes. Extra instructions: ${@:2}

1. If `$1` is supplied, review that explicit range: `git diff $1..HEAD` and `git log $1..HEAD --oneline`.
2. Otherwise, if the worktree has changes, review them: `git diff HEAD`; use `git status --short` to identify untracked files and read their contents directly.
3. Otherwise, if an upstream exists, review unpushed commits: `git diff @{u}..HEAD` and `git log @{u}..HEAD --oneline`.
4. If the selected scope is empty, stop and report that there is nothing to review.
5. Delegate the selected diff and commit list to a `reviewer` subagent. Review **Standards** (repo conventions: AGENTS.md / CONTRIBUTING / lint) and **Spec** (whether changes fulfill the supplied instructions or commit messages). Report blocker / major / minor / nit findings with file:line references and concrete fixes. Return the review only; do not commit, push, or post.
