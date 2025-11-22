#!/bin/sh

# Install yazi
sudo pacman -S --noconfirm yazi

# Restow the packages

stow --target="$HOME" yazi
