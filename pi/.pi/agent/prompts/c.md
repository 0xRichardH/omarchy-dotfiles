---
description: Commit current changes with signed commit(s) (-S)
argument-hint: "[optional commit message]"
---
Commit the current changes as one or more signed logical commits.

1. Inspect `git status --short`, `git diff`, and `git diff --staged`. If there are no changes, stop and report that nothing was committed.
2. Stage by concern, never with `git add -A`. Split independent concerns into separate commits.
3. Use Conventional Commits `type(scope): description`, derived from each staged diff. If `$@` is supplied, use it only when making one commit; if the changes require multiple commits, ask for per-commit messages.
4. Commit each staged concern with `git commit -S`, then immediately verify it with `git log -1 --pretty=%G?`. On signing failure, stop and report the error without creating an unsigned commit.
5. Print every new commit's hash, subject, and signature status.
