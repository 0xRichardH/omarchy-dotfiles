#!/bin/sh
set -eu

SCRIPT_DIR="$(dirname "$0")"

echo "Installing Opencode Wakatime..."
"$SCRIPT_DIR/install-opencode-wakatime.sh"

echo "All plugins installed."
