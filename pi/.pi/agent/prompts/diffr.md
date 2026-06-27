---
description: Start a subagent to review current changes (uncommitted or recent commits)
argument-hint: "[base-ref or HEAD~N, default HEAD~1]"
---
Start a `reviewer` subagent to review my current changes. Extra instructions: $@

Scope (use the first non-empty):
1. Uncommitted: `git diff HEAD` (staged + unstaged) plus `git status --short` for untracked files (`git add -N` them, or read their content directly).
2. Commits since `${1:-HEAD~1}`: `git diff ${1:-HEAD~1}..HEAD` and `git log ${1:-HEAD~1}..HEAD --oneline`.
3. Unpushed: `git diff @{u}..HEAD`.

If all empty, stop — nothing to review. Otherwise delegate to a `reviewer` subagent with the diff + commit list, instructed to review two axes — **Standards** (repo conventions: AGENTS.md / CONTRIBUTING / lint) and **Spec** (do the changes do what the commit messages claim) — and report by severity (blocker / major / minor / nit) with file:line refs and concrete fixes. No preamble. Return the review; don't commit, push, or post.