#!/bin/sh

# Install remap
yay -S --noconfirm --needed xremap-x11-bin

# Restow the package
stow --target="$HOME" xremap


# Enable the service
systemctl --user daemon-reload
systemctl --user enable --now xremap.service



## Enable uinput for xremap
# Prepare the virtual input device that xremap relies on. Refer to the kernel documentation for [`uinput`](https://www.kernel.org/doc/html/latest/input/uinput.html) to understand the module, and note that the [Arch Wiki discourages `uaccess`](https://wiki.archlinux.org/title/Udev#Accessing_devices) for input devices in favor of group-based rules.
#
# Load `uinput` and keep it persistent across reboots:

lsmod | grep uinput || echo uinput | sudo tee /etc/modules-load.d/uinput.conf
sudo modprobe uinput

# Apply udev rules that grant `input` group access:

sudo tee /etc/udev/rules.d/90-xremap-input.rules >/dev/null <<'EOF'
KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
KERNEL=="event*", NAME="input/%k", MODE="0660", GROUP="input"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger

# Add yourself to the `input` group, then log out and back in (or reboot) so the membership applies:

sudo usermod -aG input "$USER"
