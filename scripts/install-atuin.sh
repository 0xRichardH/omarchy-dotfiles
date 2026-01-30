#!/usr/bin/env bash
set -euo pipefail

# Install atuin with blesh-git (ble.sh) for enhanced bash integration
# blesh provides enhanced line editing capabilities required for atuin's full functionality

# Check if blesh-git is already installed
if pacman -Qi blesh-git &> /dev/null || pacman -Q blesh-git &> /dev/null 2>&1; then
  echo "blesh-git is already installed"
else
  # Check if yay is installed
  if ! command -v yay &> /dev/null; then
    echo "Error: yay is required but not installed" >&2
    echo "Please install yay first: https://github.com/Jguer/yay" >&2
    exit 1
  fi

  # Install blesh-git via yay
  echo "Installing blesh-git via yay..."
  yay -S --needed --noconfirm blesh-git
  echo "blesh-git installed successfully!"
fi

# Stow the atuin configuration
echo "Stowing atuin configuration..."
stow --target="$HOME" atuin

echo ""
echo "atuin setup complete!"
echo "Add 'source /usr/share/blesh/ble.sh' to your ~/.bashrc to enable atuin integration"
