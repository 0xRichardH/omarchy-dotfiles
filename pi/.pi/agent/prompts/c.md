---
description: Commit current changes with signed commit(s) (-S)
argument-hint: "[optional commit message]"
---
Commit the current changes as one or more signed logical commits.

- Inspect `git diff` and `git diff --staged`; stage by concern, not `git add -A`.
- If changes span multiple independent concerns, split them into multiple commits.
- Message: Conventional Commits `type(scope): description` per commit, based on that commit's staged diff, unless I supplied one as `$@`.
- Commit each staged concern with `git commit -S`; verify every new commit with `git log -1 --pretty=%G?` immediately after committing.
- Abort on signing failure — report the error, don't commit unsigned. Otherwise print each hash, subject, and signature status.