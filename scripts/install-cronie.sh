#!/usr/bin/env bash
set -euo pipefail

# Install cronie (cron implementation for Arch Linux)
sudo pacman -S --noconfirm cronie

# Enable and start the cronie service
sudo systemctl enable cronie.service
sudo systemctl start cronie.service

# Verify cronie is running
if systemctl is-active --quiet cronie.service; then
  echo "cronie service is running"
else
  echo "Warning: cronie service failed to start" >&2
  exit 1
fi

echo ""
echo "cronie installed and enabled successfully!"
echo "You can now use crontab to schedule tasks:"
echo "  crontab -e  - Edit your crontab"
echo "  crontab -l  - List your cron jobs"
