#!/bin/sh
set -eu

SCRIPT_DIR="$(dirname "$0")"

echo "Installing Opencode Superpowers..."
"$SCRIPT_DIR/install-opencode-superpowers.sh"

echo "Installing Opencode Wakatime..."
"$SCRIPT_DIR/install-opencode-wakatime.sh"

echo "All plugins installed."
