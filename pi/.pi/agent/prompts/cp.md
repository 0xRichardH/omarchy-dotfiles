---
description: Commit signed (-S) to a new branch and open a PR from it
argument-hint: "[branch-name] [optional PR description]"
---
Commit the current changes as one or more signed logical commits onto a new branch, push it, and open a PR.

1. Interpret `$1` as the new branch name (derive `feat|fix|chore/<slug>` if omitted) and `${@:2}` as the optional PR description. Record the current branch as the PR base. If it has no upstream or is ambiguous, ask before continuing.
2. Inspect `git status --short`, `git diff`, and `git diff --staged`. Stop if there are no changes. Confirm that the new branch does not already exist locally or on `origin`.
3. Create the branch: `git checkout -b <branch>`. Stage by concern, never with `git add -A`, and split independent concerns into separate commits.
4. Use Conventional Commits `type(scope): description`, derived from each staged diff. Commit each concern with `git commit -S`, then immediately verify it with `git log -1 --pretty=%G?`. On signing failure, stop without an unsigned commit, push, or PR.
5. Push with `git push --no-verify -u origin <branch>`. Create the PR with `gh pr create --base <recorded-branch>`, using the commits for its title and body unless `${@:2}` supplies the body. Print the PR URL and every signed commit hash.
