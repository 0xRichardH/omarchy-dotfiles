# Dotfiles

Opinionated configuration bundles for development and daily use, managed with GNU Stow.

## Quick Start

1. Clone this repository into `~/dotfiles`.
2. Preview the shared packages plus the host overlay:
   ```bash
   ./scripts/stow-machine.sh --simulate laptop
   ./scripts/stow-machine.sh --simulate desktop
   ```
3. Apply the correct host overlay:
   ```bash
   ./scripts/stow-machine.sh laptop
   ./scripts/stow-machine.sh desktop
   ```
4. Capture new OpenCode skills with `agents/.bin/sync-agents-skills` whenever you install or edit anything under `~/.agents`.
5. Refresh user services with `systemctl --user daemon-reload`, then enable xremap with `systemctl --user enable --now xremap.service`.
6. Tail recent xremap logs with `journalctl --user -u xremap.service -b -n 200 --no-pager` to confirm it started cleanly.

## Host overlays

Most packages are shared. Machine-specific files live in host overlay packages:

- `hosts-laptop`
- `hosts-desktop`

The host packages provide files such as terminal font size, Hyprland monitor setup, Hyprland keybindings, autostart behavior, and xremap device rules. Shared packages and host overlays must not contain the same target path. `scripts/stow-machine.sh` checks for duplicate targets before running Stow.

Use `--no-folding` through the helper script so files from shared packages and host overlays can coexist in the same target directories.

If a live machine still has an old folded symlink such as `~/.config/xremap -> ~/dotfiles/xremap/.config/xremap`, remove the folded symlink after confirming it points into this repo, create the real directory if needed, and rerun the simulate command.

## Install

Run the installer with a host name:

```bash
./install.sh laptop
./install.sh desktop
```

## Enable ssh-agent service

Load user services so the bundled unit is picked up, then enable it for automatic startups:

```bash
systemctl --user daemon-reload
systemctl --user enable --now ssh-agent.service
```

## Enable uinput for xremap

Prepare the virtual input device that xremap relies on. Refer to the kernel documentation for [`uinput`](https://www.kernel.org/doc/html/latest/input/uinput.html) to understand the module, and note that the [Arch Wiki discourages `uaccess`](https://wiki.archlinux.org/title/Udev#Accessing_devices) for input devices in favor of group-based rules.

Load `uinput` and keep it persistent across reboots:

```bash
lsmod | grep uinput || echo uinput | sudo tee /etc/modules-load.d/uinput.conf
sudo modprobe uinput
```

Apply udev rules that grant `input` group access:

```bash
sudo tee /etc/udev/rules.d/90-xremap-input.rules >/dev/null <<'EOF'
KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
KERNEL=="event*", NAME="input/%k", MODE="0660", GROUP="input"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger
```

Add yourself to the `input` group, then log out and back in or reboot so the membership applies:

```bash
sudo usermod -aG input "$USER"
```

## Packages

- `agents`: Mirrors `~/.agents` skill definitions, lock metadata, and helper templates used by OpenCode agents.
- `atuin`: Shell history configuration.
- `bash`: Shell configuration with custom scripts for Docker, fonts, and tmux.
- `bw`: Helper scripts for Bitwarden, such as `bw_add_sshkeys`.
- `fish`: Fish shell configuration.
- `ghostty`: Ghostty terminal emulator configuration.
- `git`: Shared Git config, ignore patterns, commit message template, and custom commands.
- `herdr`: Herdr configuration.
- `hypr`: Shared Hyprland compositor settings. Host overlays provide machine-specific monitor, binding, and autostart files.
- `mise`: Tool version configuration.
- `nvim`: LazyVim-based Neovim configuration with language support for Rust, Ruby, TypeScript, and Python.
- `opencode`: OpenCode editor configuration and agent guidelines.
- `pi`: Pi agent configuration.
- `sesh`: tmux session templates consumed by the `t` helper and popup picker.
- `ssh`: SSH client configuration and service for managing ssh-agent.
- `starship`: Cross-shell prompt configuration.
- `tmux`: Multiplexer configuration, including the `prefix` + `T` popup bound to `bash/.bin/t`.
- `xremap`: Shared xremap service. Host overlays provide machine-specific key remapping rules.
- `yazi`: Terminal file manager configuration.
- `zed`: Zed editor configuration.
- `hosts-laptop`: Laptop-specific overlay.
- `hosts-desktop`: Desktop-specific overlay.

## Contributing

Follow the workflow, style rules, and validation steps outlined in [`AGENTS.md`](AGENTS.md).
