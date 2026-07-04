---
description: Commit signed (-S) to a new branch and open a PR from it
argument-hint: "[branch-name] [optional PR description]"
---
Commit the current changes as one or more signed logical commits onto a NEW branch, push it, and open a PR.

- `$1` = new branch name (derive `feat|fix|chore/<slug>` if omitted); `${@:2}` = optional PR description.
- Record the current branch BEFORE switching — it's the PR base.
- `git checkout -b <branch>`; stage by concern, not `git add -A`.
- If changes span multiple independent concerns, split them into multiple commits.
- Message: Conventional Commits `type(scope): description` per commit, based on that commit's staged diff.
- Commit each staged concern with `git commit -S`; verify every new commit with `git log -1 --pretty=%G?` immediately after committing.
- Abort on signing failure — report the error, don't commit unsigned, push, or open a PR.
- `git push --no-verify -u origin <branch>`; `gh pr create --base <recorded-branch>` with title/body from the commits.
- Print the PR URL and each signed commit hash. Confirm the base branch with me if it's ambiguous.