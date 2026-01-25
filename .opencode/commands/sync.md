---
description: Commit changes and cherry-pick between laptop and master
---

Current Git Status:
!`git status`

Current Git Diff:
!`git diff`

Based on the status and diff above, please perform the following:

1. Commit all changes using a descriptive commit message following the project's conventional commit style.
2. Determine the current branch.
3. If the current branch is `laptop`:
   - Cherry-pick the newly created commit to the `master` branch.
   - Push both `laptop` and `master` branches to the remote.
4. If the current branch is `master`:
   - Cherry-pick the newly created commit to the `laptop` branch.
   - Push both `master` and `laptop` branches to the remote.
