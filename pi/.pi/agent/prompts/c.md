---
description: Commit current changes with a signed commit (-S)
argument-hint: "[optional commit message]"
---
Commit the current changes with a signed commit.

- Inspect `git diff` and `git diff --staged`; stage by concern, not `git add -A`.
- Message: Conventional Commits `type(scope): description` from the diff, unless I supplied one as `$@`.
- Commit with `git commit -S`; verify `git log -1 --pretty=%G?` is not `N`.
- Abort on signing failure — report the error, don't commit unsigned. Otherwise print the hash, subject, and signature status.