---
description: Commit current changes with signed commit(s) (-S)
argument-hint: "[optional commit message]"
---
Create signed, atomic commit(s) from the current changes.

1. Inspect `git status --short`, `git diff`, and `git diff --staged`. Stop with a no-changes report when the worktree and index are clean.
2. Form an atomic commit plan. Keep changes together when they deliver one outcome, including its tests, documentation, and configuration. Create separate commits only for concerns that remain meaningful, valid, and safely revertible on their own. Ask for guidance when no defensible grouping is clear.
3. For each planned commit, stage its exact paths or hunks without broad staging commands. Review `git diff --staged` and proceed only when it matches that commit's complete concern.
4. Use Conventional Commits `type(scope): description`. With one planned commit, use `$@` as its message when supplied. With multiple commits, use `$@` as intent and derive a message from each staged diff.
5. Create each commit with `git commit -S` and verify it immediately with `git log -1 --pretty=%G?`. A signing failure ends the run without an unsigned replacement.
6. Report every new commit's hash, subject, and signature status.
