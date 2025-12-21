#!/usr/bin/env bash
set -euo pipefail

# Install rclone
sudo pacman -S --noconfirm rclone

# Config rclone + Google Drive
if rclone listremotes | grep -q "gdrive:"; then
  echo "rclone gdrive remote already configured, skipping config"
else
  echo "Please configure rclone with Google Drive:"
  echo "  n  -> new remote"
  echo "  name: gdrive"
  echo "  storage: drive"
  echo "  scope: drive (full access) or drive.file (safer, file-level)"
  echo "  auto config: yes → browser auth"
  echo ""
  read -p "Press Enter to start rclone config (or Ctrl+C to skip)..."
  rclone config
fi

# Create Notes directory and initialize git repo
mkdir -p ~/Notes/gdrive-notes/
cd ~/Notes/gdrive-notes/
if [[ ! -d .git ]]; then
  git init
  git config user.name "$(git config --global user.name || echo 'Your Name')"
  git config user.email "$(git config --global user.email || echo 'your.email@example.com')"
  echo "Initialized git repository in ~/Notes/gdrive-notes/"
fi

# Run initial sync if not already initialized
BISYNC_CACHE="$HOME/.cache/rclone/bisync"
BISYNC_PATH1="$BISYNC_CACHE/home_richard_Notes_gdrive-notes..gdrive_0xdev_Notes.path1.lst"

if command -v gdrive-sync &> /dev/null; then
  if [[ -f "$BISYNC_PATH1" ]]; then
    echo "Bisync already initialized, skipping initial sync"
  else
    echo "Running initial sync..."
    gdrive-sync sync
    echo "Initial sync completed!"
  fi
else
  echo "Warning: gdrive-sync command not found. Please ensure bash/.bin is in your PATH."
fi

# Create cron job for periodic sync
if ! command -v crontab &> /dev/null; then
  echo "Warning: crontab not found. Please run ./scripts/install-cronie.sh first"
  echo "Skipping cron job creation..."
else
  CRON_CMD="*/15 * * * * $HOME/.bin/gdrive-sync sync >> $HOME/.local/share/rclone-sync-cron.log 2>&1"
  CRON_TEMP=$(mktemp)

  # Get existing crontab (ignore error if no crontab exists)
  crontab -l > "$CRON_TEMP" 2>/dev/null || true

  # Check if cron job already exists
  if grep -q "gdrive-sync sync" "$CRON_TEMP"; then
    echo "Cron job for gdrive-sync already exists"
  else
    echo "$CRON_CMD" >> "$CRON_TEMP"
    crontab "$CRON_TEMP"
    echo "Cron job created: sync every 15 minutes"
    echo "Logs will be written to ~/.local/share/rclone-sync-cron.log"
  fi

  rm "$CRON_TEMP"
fi

echo ""
echo "Setup complete!"
echo "You can manually run:"
echo "  gdrive-sync sync   - Bidirectional sync"
echo "  gdrive-sync commit - Auto-commit changes with AI-generated message"
echo "  gdrive-sync push   - Push local to remote"
echo "  gdrive-sync pull   - Pull remote to local"
