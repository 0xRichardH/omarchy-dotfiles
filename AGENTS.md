# Repository Guidelines

## Project Structure & Module Organization
Each top-level directory is a GNU Stow package for a specific tool. Key paths:
- `alacritty/.config/alacritty/alacritty.toml` for terminal defaults.
- `agents/.agents` tracks OpenCode skill definitions, templates, and lock metadata.
- `hypr/.config/hypr/*.lua` contains shared Hyprland settings; host overlays own machine-specific Lua files such as bindings, autostart, and monitors.
- `nvim/.config/nvim` contains LazyVim-based setup plus custom Lua modules in `lua/config/` and `lua/plugins/`.
- `git/.config/git` centralizes Git templates and ignores; `git/.bin` holds custom git commands.
- `bash/.bin` and `bw/.bin` house utility scripts.
- `tmux/.config/tmux/tmux.conf` manages multiplexer defaults and key bindings.
- `sesh/.config/sesh/sesh.toml` defines reusable tmux session templates.
- `packages/` declares intentional Arch/AUR package names (`official.txt`, `aur.txt`); install with `scripts/install-packages.sh`.
Symlink everything into `$HOME` with `stow <package>`; avoid editing live dotfiles in place. Stow manages configs; package manifests manage system packages.

## Build, Test, and Development Commands
- **Apply changes**: `stow --target=$HOME --restow <package>` (e.g., `hypr`, `nvim`, `git`)
- **Install declared packages**: `./scripts/install-packages.sh` (add `--audit` to compare manifests vs installed packages)
- **Agents package**: run `stow --target=$HOME --simulate agents` before `--restow` to confirm it will update `~/.agents` as expected.
- **Sync new skills**: execute `agents/.bin/sync-agents-skills` (wraps `stow --adopt`) after installing or modifying a skill so the repo stays current.
- **Dry-run test**: `stow --target=$HOME --simulate <package>` to preview symlink changes
- **Neovim health check**: `nvim --headless "+checkhealth" +qa`
- **Neovim sync plugins**: `nvim --headless "+Lazy sync" +qa`
- **Reload Hyprland**: `hyprctl reload` after config changes
- **Check Hyprland logs**: `journalctl --user -u hyprland`
- **Format Lua files**: Use stylua with config at `nvim/.config/nvim/stylua.toml`

## Coding Style & Naming Conventions
- **Lua**: Follow `stylua.toml` (2 spaces, max column 120). Use snake_case for modules/functions. Group plugins under `lua/plugins/`, config under `lua/config/`. No comments unless documenting complex logic.
- **Shell scripts**: Use `#!/usr/bin/env bash` shebang. Place in `<package>/.bin/` and mark executable (`chmod +x`). Follow existing patterns (see `bash/.bin/tat`, `git/.bin/commit`).
- **Hyprland**: Lowercase `*.lua` files named by domain (bindings.lua, monitors.lua, etc.). Keep service-specific files such as `hypridle.conf`, `hyprlock.conf`, and `hyprsunset.conf` in their native format.
- **TOML/YAML**: 2-space indent. TOML uses lowercase with dashed keys. Keep configs ASCII-only unless required.
- **Formatting**: Nvim uses tabstop=2, softtabstop=2, shiftwidth=2, expandtab=true.

## Testing Guidelines
Always use `stow --simulate` before applying changes. For Neovim, run `nvim --headless "+Lazy sync" +qa` to verify plugins. Reload Hyprland with `hyprctl reload` and check logs. Test shell scripts in a non-production environment first.

## Commit & Pull Request Guidelines
Follow Conventional Commits: `type(scope): description`. Types: feat, fix, docs, style, refactor, test, chore, revert. Scope should be the package name (git, nvim, hypr, etc.). Keep bodies short but note migration steps. Example: `feat(git): add custom merge-branch command`.

### Skip ephemeral Pi model selection
Do **not** commit `pi/.pi/agent/settings.json` when its diff only changes `defaultModel` and/or `defaultProvider`. Those fields track the currently selected model and churn constantly. Commit the file only when other keys change (thinking level, telemetry, packages, etc.).

## Security & Secrets
Never commit tokens, SSH keys, or Bitwarden exports. The `bw_add_sshkeys` script expects secrets in vault. Review diffs for accidental absolute paths or credentials before committing.
