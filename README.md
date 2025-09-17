# Dotfiles

Opinionated configuration bundles for development and daily use, managed with GNU Stow.

## Quick Start
1. Clone this repository into `~/dotfiles`.
2. Restow the package you need, for example:
   ```bash
   stow --target="$HOME" nvim
   stow --target="$HOME" hypr
   ```
3. Use `stow --target="$HOME" --restow <package>` after you make changes.
4. Run `stow --target="$HOME" --simulate <package>` to preview symlink updates before applying them.

## Packages
- `alacritty`: terminal configuration.
- `hypr`: Hyprland compositor files split by focus area.
- `nvim`: LazyVim-based Neovim configuration and custom Lua modules.
- `git`: shared Git config, ignore patterns, and commit message template.
- `bw`: helper scripts such as `bw_add_sshkeys` for Bitwarden vault access.
- `ssh`, `xremap`: additional workstation tooling.

## Contributing
Follow the workflow, style rules, and validation steps outlined in [`AGENTS.md`](AGENTS.md).
