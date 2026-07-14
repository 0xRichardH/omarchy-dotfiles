# Declarative Arch package management

This repository uses GNU Stow for files in the home directory. Packages are a
separate concern: keep the desired package names in version-controlled lists
and use `yay` as the transaction tool. This gives reproducible intent without
pretending that an Arch rolling-release system can be pinned by a plain text
list.

## Source-backed facts

- `pacman -Qqe` lists explicitly installed packages. ArchWiki recommends
  saving this output as a package list for backup or reinstalling a machine;
  `pacman -Qqem` lists explicitly installed foreign packages, which includes
  AUR packages. [ArchWiki: Pacman/Tips and tricks, “List of installed
  packages”](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages)
- `pacman -S --needed - < pkglist.txt` installs a saved list without
  reinstalling packages that are already current. [ArchWiki: Pacman/Tips and
  tricks, “Install packages from a list”](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Install_packages_from_a_list)
- `--needed` means pacman does not reinstall targets that are already
  up-to-date. [pacman(8), sync options](https://man.archlinux.org/man/pacman.8.en#SYNC_OPTIONS_(APPLY_TO_-S))
- A full upgrade is required on Arch: do not run `pacman -Sy` as a partial
  upgrade; use `pacman -Syu`. The ArchWiki explicitly says this also matters
  when locally built/AUR packages are installed. [ArchWiki: System
  maintenance, “Partial upgrades are unsupported”](https://wiki.archlinux.org/title/System_maintenance#Partial_upgrades_are_unsupported)
- `yay` is a pacman wrapper with AUR support and passes pacman/makepkg options
  after resolving packages. With no operation, `yay` performs `yay -Syu`;
  `yay -S` can handle repository and AUR targets. [yay manual](https://github.com/Jguer/yay/blob/next/doc/yay.8)
- The yay README documents `yay -Syu --devel` for development packages and
  `yay -Y --gendb` as a one-time migration step for `*-git` packages installed
  without yay. [yay README](https://github.com/Jguer/yay/blob/next/README.md#first-use)
- AUR entries are PKGBUILD build descriptions, not an official binary
  repository. Users should acquire the build files, inspect them, build with
  `makepkg`, and install with pacman; AUR PKGBUILDs are unofficial and must be
  treated as untrusted input. [ArchWiki: Arch User Repository](https://wiki.archlinux.org/title/Arch_User_Repository#Installing_and_upgrading_packages)
  [ArchWiki: Arch User Repository warning](https://wiki.archlinux.org/title/Arch_User_Repository#Getting_started)
- ArchWiki warns that pacman wrappers abstract package-manager behavior and
  may introduce unsafe or unexpected behavior. It lists yay as a batch-capable
  pacman wrapper, so keep yay interactive for normal workstation use and review
  AUR diffs before building. [ArchWiki: AUR helpers](https://wiki.archlinux.org/title/AUR_helpers#Pacman_wrappers)
- A `PKGBUILD` is a Bash build script consumed by `makepkg`; it is appropriate
  when this repository owns a package recipe, not as a replacement for a list
  of third-party package names. [ArchWiki: PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD)

## Recommended repository layout

Use a dedicated top-level `packages/` directory rather than putting package
names inside a Stow package:

```text
packages/
  official.txt       # one official repository package name per line
  aur.txt            # one AUR package name per line
  README.md          # ownership and update instructions (optional)
scripts/
  install-packages.sh
```

Keep lists as package **names**, not versions. Arch packages and AUR packages
are continuously rebuilt and upgraded; recording versions in these lists would
create stale pins and partial-upgrade risk. Put comments and blank lines in
lists for grouping, but make the installer strip them before passing names to
`yay`.

Maintain two lists even though yay can install both classes together:

- `official.txt` makes the trusted repository set easy to audit and lets the
  bootstrap path use pacman before yay exists.
- `aur.txt` makes foreign/unofficial software visible and reviewable. Every AUR
  entry should have a reason and should be periodically checked for an official
  replacement.

Do not commit downloaded AUR build directories or built package archives.
Those are generated state; keep them in yay's cache/build directory outside the
repository. Commit a `PKGBUILD` only for a package maintained by this project
(for example, a local package or a package this project publishes to the AUR),
with its supporting sources and `.SRCINFO` policy documented separately.

## Installer behavior

A practical `scripts/install-packages.sh` should:

1. Require Arch Linux and verify the lists exist.
2. Install `git`, `base-devel`, and `yay`'s bootstrap prerequisites with pacman
   if needed. The yay project documents cloning `yay` or `yay-bin` from the AUR,
   reviewing the checkout, then running `makepkg -si`; do not silently execute
   an unreviewed bootstrap script. [yay README: installation](https://github.com/Jguer/yay/blob/next/README.md#installation)
3. Install both lists with `yay -S --needed` (or separate invocations for
   clearer logging). `--needed` makes reruns idempotent for already-current
   packages. This personal workstation bootstrap uses `--noconfirm` for trusted
   official repository packages while keeping AUR packages interactive by
   default.
4. Offer an opt-in full upgrade with `yay -Syu`; never refresh package databases
   without completing a full upgrade.
5. Leave prompts enabled by default so AUR PKGBUILD changes and package
   replacement decisions can be reviewed. Offer an explicit, documented
   `--non-interactive` mode only for a controlled machine/bootstrap context.

A shell sketch (the actual repository script should add argument parsing and
error handling) is:

```bash
mapfile -t official < <(sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' packages/official.txt)
mapfile -t aur < <(sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' packages/aur.txt)

((${#official[@]})) && yay -S --needed --noconfirm "${official[@]}"
((${#aur[@]})) && yay -S --needed "${aur[@]}"

if ((do_upgrade)); then
  yay -Syu
fi
```

For a first install where yay is not available, install official packages
with `sudo pacman -S --needed - < packages/official.txt` after filtering
comments, then bootstrap yay and install `aur.txt`. Avoid `--noconfirm` in the
normal path: unattended AUR builds weaken the review step and can conceal
conflicts or maintainer changes.

## Drift, removals, and maintenance

A desired-package list is additive unless the script deliberately implements
removal. Do not automatically remove every installed package absent from the
lists: dependencies, host-specific packages, firmware, recovery tools, and
manual exceptions may be intentional. If strict convergence is wanted, use a
separate opt-in audit/removal command that compares the lists against
`pacman -Qqe`, prints the proposed removals, and requires confirmation.

Useful audits:

```bash
pacman -Qqe                 # all explicitly installed packages
pacman -Qqen                # explicitly installed official/native packages
pacman -Qqem                # explicitly installed foreign/AUR packages
pacman -Qdtq                # dependency orphans; review before removing
```

After upgrades, check Arch News and resolve `.pacnew`/`.pacsave` notices. AUR
packages remain the user's responsibility to update, and locally built
packages may need rebuilding after dependency soname changes. [ArchWiki:
System maintenance](https://wiki.archlinux.org/title/System_maintenance#Upgrading_the_system)

For `*-git` packages, run `yay -Y --gendb` once if they predate yay; thereafter
use `yay -Syu --devel` when development-package updates are intentionally part
of the workflow. Keep VCS packages exceptional because they increase rebuild
and maintenance cost.

## Why not chezmoi or a committed PKGBUILD for everything?

- **Plain lists + a script** fit this repo's existing Stow/bootstrap model,
  remain readable, and let pacman/yay resolve current dependencies.
- **A `PKGBUILD`** is the right artifact for building one owned package; it is
  not a declarative inventory of unrelated official/AUR dependencies.
- **chezmoi-like managers** can template files and run hooks, but add another
  state-management layer when this repository already has Stow and shell
  scripts. They are only justified if cross-platform templating, secrets, or
  lifecycle hooks become a primary requirement.
- **Snapshots or exact package archives** provide stronger reproducibility but
  require an Arch package repository/cache and a deliberate update policy;
  they are substantially more operational work than a rolling package-name
  inventory.

The recommended default for `/home/richard/dotfiles` is therefore:
`packages/official.txt` + `packages/aur.txt` + one reviewed
`scripts/install-packages.sh`, with optional owned-package subdirectories for
project-specific PKGBUILDs.
