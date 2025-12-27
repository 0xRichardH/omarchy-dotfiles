#!/bin/sh
set -eu

# Check for npm
if ! command -v npm >/dev/null 2>&1; then
    echo "Error: npm is required but not found." >&2
    exit 1
fi

echo "Installing opencode-wakatime package..."
npm install -g opencode-wakatime

echo "Registering wakatime plugin..."
opencode-wakatime --install

echo "Opencode Wakatime installed successfully."
