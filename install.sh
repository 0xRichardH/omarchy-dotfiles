#!/bin/sh

omarchy-install-tailscale

./scripts/install-stow.sh
./scripts/enable-ssh-agent-service.sh
./scripts/enable-opencode-service.sh
./scripts/install-xremap.sh
./scripts/install-yazi.sh
./scripts/install-fcitx5.sh
./scripts/install-cronie.sh
./scripts/install-rclone.sh
./scripts/install-fish.sh
