---
description: Commit signed (-S) to a new branch and open a PR from it
argument-hint: "[branch-name] [optional PR description]"
---
Create signed, atomic commit(s) on a new branch, push it, and open a PR.

1. Interpret `$1` as the branch name, deriving `feat|fix|chore/<slug>` when omitted, and `${@:2}` as the optional PR description. Record the current branch as the PR base; ask when its upstream or base is ambiguous.
2. Inspect `git status --short`, `git diff`, and `git diff --staged`. Stop with a no-changes report when the worktree and index are clean. Confirm that the new branch is absent locally and on `origin`.
3. Form an atomic commit plan. Keep changes together when they deliver one outcome, including its tests, documentation, and configuration. Create separate commits only for concerns that remain meaningful, valid, and safely revertible on their own. Ask for guidance when no defensible grouping is clear.
4. Create the branch with `git checkout -b <branch>`. For each planned commit, stage its exact paths or hunks without broad staging commands. Review `git diff --staged` and proceed only when it matches that commit's complete concern.
5. Use Conventional Commits `type(scope): description`, derived from each staged diff. Create each commit with `git commit -S` and verify it immediately with `git log -1 --pretty=%G?`. A signing failure ends the run without an unsigned replacement, push, or PR.
6. Push with `git push --no-verify -u origin <branch>`. Create the PR with `gh pr create --base <recorded-branch>`, using the commits for its title and body unless `${@:2}` supplies the body.
7. Report the PR URL and every new commit's hash, subject, and signature status.
