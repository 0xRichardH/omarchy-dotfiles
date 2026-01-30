#!/usr/bin/env bash
set -e

# Install omarchy-fish package
sudo pacman -S omarchy-fish

# Setup bash to auto-launch fish
omarchy-setup-fish
