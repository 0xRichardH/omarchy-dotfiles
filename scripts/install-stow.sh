#!/bin/sh

# Install stow
sudo pacman -S --noconfirm --needed stow

# Restow the packages

stow --target="$HOME" --adopt nvim
stow --target="$HOME" --adopt hypr
stow --target="$HOME" --adopt git
stow --target="$HOME" --adopt bash
stow --target="$HOME" --adopt bw
stow --target="$HOME" --adopt ssh
stow --target="$HOME" --adopt fish
stow --target="$HOME" --adopt atuin
