# Dotfiles Branch Unification Plan

## Goal

Unify the `master` and `laptop` branches into one branch while preserving machine-specific config differences.

## Branch mapping

- `master` becomes `hosts-desktop` where files differ by machine.
- `laptop` becomes `hosts-laptop` where files differ by machine.

## Stow model

- Keep shared packages as top-level Stow packages.
- Add top-level host overlay packages:
  - `hosts-desktop`
  - `hosts-laptop`
- Use `stow --no-folding` so shared and host packages can both populate the same target directories.
- Do not implement host-priority overrides.
- Fail preflight when shared packages and the selected host package contain the same target path.

## Script design

Create one script:

```text
scripts/stow-machine.sh
```

Supported usage:

```bash
./scripts/stow-machine.sh laptop
./scripts/stow-machine.sh desktop
./scripts/stow-machine.sh --simulate laptop
./scripts/stow-machine.sh --simulate desktop
```

The script should:

1. Use a hardcoded shared package list.
2. Validate that `hosts-<name>` exists.
3. Check duplicate target paths between shared packages and the selected host package.
4. Run `stow --target="$HOME" --no-folding --restow`.
5. Apply changes by default.
6. Avoid delete or unstow modes for now.

Implemented shared package list:

```bash
shared_packages=(
  agents
  atuin
  bash
  bw
  fish
  ghostty
  git
  herdr
  hypr
  mise
  nvim
  opencode
  pi
  sesh
  ssh
  starship
  tmux
  xremap
  yazi
  zed
)
```

`alacritty` is no longer shared because its only tracked file moved to host overlays. `ssh` and `starship` are shared packages and are included in the script.

## File decisions

| Path | Decision | Notes |
| --- | --- | --- |
| `.engram/chunks/38e30c18.jsonl.gz` | Delete / ignore | Runtime memory data. |
| `.engram/manifest.json` | Delete / ignore | Runtime memory metadata. |
| `.opencode/package-lock.json` | Delete / ignore | Root metadata, not a Stow package. |
| `agents/.agents/.skill-lock.json` | Reconcile shared | Combine `master` and `laptop`. |
| `agents/.agents/skills/agent-skill-builder/` | Keep `master` shared | Deleted on `laptop`. |
| `agents/.agents/skills/exa-search/` | Keep `master` shared | Deleted on `laptop`. |
| `agents/.agents/skills/jj-history-investigation/` | Delete / ignore | Delete all jj-related skills. |
| `agents/.agents/skills/onevcat-jj/` | Delete / ignore | Delete all jj-related skills. |
| `agents/.agents/skills/using-jj-workspaces/` | Delete / ignore | Delete all jj-related skills. |
| `agents/.agents/skills/mcporter/` | Keep `master` shared | Deleted on `laptop`. |
| `agents/.agents/skills/omarchy` | Keep `master` shared | Deleted on `laptop`. |
| `agents/.agents/skills/teach/` | Keep `master` shared | Deleted on `laptop`. |
| `alacritty/.config/alacritty/alacritty.toml` | Move both to host overlays | Only font size differs: desktop uses `16`, laptop uses `10`. |
| `bash/.bashrc` | Reconcile shared | Add `export PATH="$HOME/.local/bin:$PATH"`. |
| `fish/.config/fish/alias.fish` | Keep `master` shared | Only alias order differs. |
| `fish/.config/fish/config.fish` | Reconcile shared | Add `fish_add_path "$HOME/.local/bin"` and guard OpenClaw completion with `test -f`. |
| `ghostty/.config/ghostty/config` | Keep `laptop` shared | Use `alt+[` for tmux copy mode. |
| `git/.bin/engram-git-import` | Keep `laptop` shared | New shared helper. |
| `git/.bin/engram-git-sync` | Keep `laptop` shared | New shared helper. |
| `git/.config/git/config` | Keep `laptop` shared | Adds delta and submodule options. |
| `git/.config/git/gitconfig.local` | Keep `laptop` shared | Removes the `~/befreed/` include. |
| `herdr/.config/herdr/config.toml` | Keep `laptop` shared | Adds `agent_panel_scope = "all"`. |
| `hypr/.config/hypr/autostart.conf` | Move both to host overlays | Laptop autostarts Ghostty on workspace 1 and browser on workspace 2; desktop does not. |
| `hypr/.config/hypr/bindings.conf` | Move both to host overlays | Laptop adds monitor/display bindings, including an `eDP-1`-specific external monitor mode. |
| `hypr/.config/hypr/hyprland.conf` | Keep `laptop` shared | Adds Omarchy default `looknfeel.conf` source and custom `windows.conf` source. |
| `hypr/.config/hypr/input.conf` | Keep `laptop` shared | Uses `repeat_delay = 600` and includes `foot` in terminal touchpad scroll rule. |
| `hypr/.config/hypr/looknfeel.conf` | Keep `master` shared | Master vendors a full Omarchy-like look-and-feel config; user chose it over the laptop override template. |
| `hypr/.config/hypr/monitors.conf` | Move both to host overlays | Desktop uses `GDK_SCALE,1.75` and scale `1.6`; laptop uses `GDK_SCALE,2` and `auto` scale. |
| `hypr/.config/hypr/windows.conf` | Keep `laptop` shared | Adds Slack workspace 3 rule and satisfies the shared `hyprland.conf` source. |
| `nvim/.config/nvim/lazy-lock.json` | Keep `laptop` shared | Generated plugin lockfile; update later after unification. |
| `nvim/.config/nvim/lua/config/options.lua` | Keep `master` shared | Preserves `GoToCommand`, `GoToFile`, and `Grep` commands used by terminal shortcuts. |
| `opencode/.config/opencode/AGENTS.md` | Keep `master` shared | Preserves the `No backward compatibility` design rule. |
| `opencode/.config/opencode/opencode.jsonc` | Reconcile shared | Keep useful shared settings, prefer laptop's `glm-5.1`, and decide plugin/Linear/LSP intentionally. |
| `opencode/.config/opencode/package-lock.json` | Delete / ignore | Generated npm lockfile without a tracked `package.json`; includes local path metadata. |
| `opencode/.config/opencode/plugin/peekoo-opencode-companion.js` | Delete / ignore | Use laptop opencode plugin set. |
| `opencode/.config/opencode/plugin/wakatime.js` | Delete / ignore | Use laptop opencode plugin set. |
| `opencode/.config/opencode/plugins/engram.ts` | Keep `laptop` shared | Use laptop opencode plugin set. |
| `opencode/.config/opencode/plugins/herdr-agent-state.js` | Keep `laptop` shared | Use laptop opencode plugin set. |
| `opencode/.config/opencode/plugins/rtk.ts` | Delete / ignore | Use laptop opencode plugin set. |
| `opencode/.config/opencode/tui.json` | Keep `laptop` shared | Adds `opencode-subagent-statusline` plugin while preserving theme, diff style, and keybinds. |
| `pi/.pi/agent/prompts/coding.md` | Keep `laptop` shared | New prompt. |
| `pi/.pi/agent/prompts/gh-comment.md` | Keep `laptop` shared | New prompt. |
| `pi/.pi/agent/settings.json` | Keep `laptop` shared | Uses laptop enabled model list, adds `pi-subagents`, and sets `steeringMode` to `one-at-a-time`. |
| `scripts/enable-ssh-agent-service.sh` | Keep `master` shared | Still referenced by `install.sh`; enables user `ssh-agent.service`. |
| `scripts/install-atuin.sh` | Keep `master` shared | Atuin is used and the repo contains an `atuin` Stow package. |
| `ssh/.config/systemd/user/ssh-agent.service` | Keep `master` shared | Service used by `scripts/enable-ssh-agent-service.sh`. |
| `tmux/.config/tmux/tmux.conf` | Keep `laptop` shared | Adds `set -g extended-keys-format csi-u`. |
| `xremap/.config/xremap/config.yml` | Move both to host overlays | Laptop version has device-specific built-in keyboard and HHKB rules. |
| `yazi/.config/yazi/theme.toml` | Keep `laptop` shared | Uses `mime` rules instead of older `url` rules for fallback and directories. |
| `zed/.config/zed/keymap.json` | Keep `master` shared | Zed config deleted on laptop but should remain in unified branch. |
| `zed/.config/zed/settings.json` | Keep `master` shared | Zed config deleted on laptop but should remain in unified branch. |

## Review status

All 61 paths from `git diff --name-status master..laptop` are classified. Some are classified by directory-level decisions.

Implemented work:

- Reconciled `agents/.agents/.skill-lock.json` into one shared lockfile.
- Reconciled `bash/.bashrc` with a generic `$HOME/.local/bin` PATH entry.
- Reconciled `fish/.config/fish/config.fish` with `fish_add_path "$HOME/.local/bin"` and guarded OpenClaw completion.
- Reconciled `opencode/.config/opencode/opencode.jsonc`, keeping the master plugin/LSP/Linear settings and updating `glm-5` to laptop's `glm-5.1`.
- Moved selected machine-specific files into `hosts-desktop` and `hosts-laptop`.
- Created `scripts/stow-machine.sh` with duplicate-target preflight.
- Updated `scripts/install-stow.sh` and `install.sh` to require a host name and call the host-aware Stow script.
- Updated `README.md` with host overlay usage, install commands, and migration notes.
- Validated `scripts/stow-machine.sh --simulate laptop` and `--simulate desktop` against a clean temporary home directory.
- Confirmed live-home simulation currently hits the documented folded-symlink migration issue at `~/.config/xremap`.

Manual follow-up:

- Existing machines may have old folded Stow symlinks, such as `~/.config/xremap -> ~/dotfiles/xremap/.config/xremap`. If `scripts/stow-machine.sh --simulate <host>` fails on a live home directory with `unstow_contents() called with invalid target`, remove the old folded symlink after confirming it points into this repo, create the real directory, and rerun the script.
