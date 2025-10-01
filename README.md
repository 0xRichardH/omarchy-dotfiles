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
5. Refresh user services with `systemctl --user daemon-reload`, then enable xremap with `systemctl --user enable --now xremap.service`.
6. Tail recent xremap logs with `journalctl --user -u xremap.service -b -n 200 --no-pager` to confirm it started cleanly.

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

Add yourself to the `input` group, then log out and back in (or reboot) so the membership applies:

```bash
sudo usermod -aG input "$USER"
```

## Packages

-   `alacritty`: Fast, cross-platform, OpenGL terminal emulator configuration.
-   `bash`: Shell configuration with custom scripts for Docker, fonts, and tmux.
-   `bw`: Helper scripts for Bitwarden, such as `bw_add_sshkeys`.
-   `git`: Shared Git config, ignore patterns, and commit message template.
-   `hypr`: Hyprland compositor with custom bindings and settings.
-   `nvim`: LazyVim-based Neovim configuration with UI enhancements and AI completions.
-   `ssh`: SSH client configuration and service for managing ssh-agent.
-   `starship`: Cross-shell prompt configuration.
-   `xremap`: Key remapping tool configuration.
-   `yazi`: Terminal file manager configuration.

## Contributing
Follow the workflow, style rules, and validation steps outlined in [`AGENTS.md`](AGENTS.md).
