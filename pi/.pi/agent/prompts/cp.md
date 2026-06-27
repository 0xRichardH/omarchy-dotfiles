---
description: Commit signed (-S) to a new branch and open a PR from it
argument-hint: "[branch-name] [optional PR description]"
---
Commit the current changes signed onto a NEW branch, push it, and open a PR.

- `$1` = new branch name (derive `feat|fix|chore/<slug>` if omitted); `${@:2}` = optional PR description.
- Record the current branch BEFORE switching — it's the PR base.
- `git checkout -b <branch>`; stage by concern; commit with `git commit -S` and a Conventional Commits message from the diff.
- Verify `git log -1 --pretty=%G?` is not `N` — abort if signing failed (don't push or open a PR).
- `git push -u origin <branch>`; `gh pr create --base <recorded-branch>` with title/body from the commits.
- Print the PR URL and signed commit hash. Confirm the base branch with me if it's ambiguous.