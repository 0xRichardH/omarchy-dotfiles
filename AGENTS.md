# Repository Guidelines

## Project Structure & Module Organization
Each top-level directory is a GNU Stow package for a specific tool. Key paths:
- `alacritty/.config/alacritty/alacritty.toml` for terminal defaults.
- `hypr/.config/hypr/*.conf` split by concern (bindings, input, monitors, etc.).
- `nvim/.config/nvim` contains the LazyVim-based setup plus custom Lua modules in `lua/`.
- `git/.config/git` centralizes Git templates and ignores.
- `bw/.bin/bw_add_sshkeys` houses the Bitwarden helper script.
Symlink everything into `$HOME` with `stow <package>`; avoid editing the live dotfiles in place.

## Build, Test, and Development Commands
- `stow --target=$HOME <package>`: restows a single package after edits.
- `stow --target=$HOME --restow hypr`: refreshes an updated package without manual cleanup.
- `stow --target=$HOME --simulate nvim`: dry-run to preview symlink changes.
- `nvim --headless "+checkhealth" +qa`: quick sanity check for the Neovim setup.
- `hyprctl reload`: apply Hyprland config changes after restowing.
Place new scripts under `bw/.bin` and mark them executable.

## Coding Style & Naming Conventions
Lua files follow `stylua.toml` (spaces, width 2, max column 120). Keep module names snake_case and group related functions under `lua/plugins/` or `lua/config/`. Hyprland fragments use lowercase `*.conf` names that match their domain. YAML stays two-space indented. TOML tables are lowercase with dashed keys when needed. Configs should remain ASCII unless upstream requires otherwise.

## Testing Guidelines
Use `stow --simulate` before touching the real home directory. For Neovim plugins, run `nvim --headless "+Lazy sync" +qa` to ensure dependencies resolve. Re-source Hyprland with `hyprctl reload` and watch the logs (`journalctl --user -u hyprland`) for errors. When updating shell or Git scripts, run them against a non-production profile first.

## Commit & Pull Request Guidelines
Follow Conventional Commit syntax seen in history (`feat(git): add git config`). Include a scope when changing a single package. Keep bodies short but note migration steps (e.g., “restow hypr”). PRs should list affected packages, manual validation steps, and any screenshots for visual tweaks. Link related issues or discussions when available.

## Security & Secrets
Do not commit tokens, SSH material, or Bitwarden exports. The `bw_add_sshkeys` script expects secrets to stay in the vault—update instructions, not credentials. Review diffs for accidental absolute paths before submitting.
