# Package manifests

Declared Arch packages for this machine. Stow manages config files; these lists
manage packages installed with pacman/yay.

| File | Contents |
| --- | --- |
| `official.txt` | Packages from configured Arch repositories |
| `aur.txt` | Packages from the AUR |

## Install

```bash
./scripts/install-packages.sh
```

Official repository packages install with `--noconfirm`. AUR packages remain
interactive so PKGBUILD changes can be reviewed.

Useful flags:

```bash
./scripts/install-packages.sh --non-interactive   # also suppress AUR/upgrade prompts
./scripts/install-packages.sh --upgrade           # also run yay -Syu
./scripts/install-packages.sh --audit             # compare lists to installed packages
```

For a fully unattended machine bootstrap, opt in explicitly:

```bash
./install.sh laptop --non-interactive
./install.sh desktop --non-interactive
```

## Editing

1. Add a package name to the appropriate list.
2. Run `./scripts/install-packages.sh`.
3. Commit the list change.

Keep package **names** only. Do not pin versions in these files on a rolling
Arch system. Do not commit AUR build directories or package archives.

## Scope

These lists are intentional, not a dump of every package on the machine. Host-
specific or one-off packages can stay outside the manifests until they become
part of the shared setup.
