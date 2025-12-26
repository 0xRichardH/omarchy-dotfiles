#!/bin/sh
set -eu

# Install or update the Superpowers plugin for OpenCode.
config_dir="$HOME/.config/opencode"
superpowers_dir="$config_dir/superpowers"
plugin_dir="$config_dir/plugin"
plugin_src="$superpowers_dir/.opencode/plugin/superpowers.js"
plugin_dest="$plugin_dir/superpowers.js"

mkdir -p "$config_dir"

if [ -d "$superpowers_dir/.git" ]; then
  git -C "$superpowers_dir" pull --ff-only
else
  if [ -e "$superpowers_dir" ]; then
    echo "Error: $superpowers_dir exists but is not a git repo." >&2
    echo "Remove it or convert it to a git clone before continuing." >&2
    exit 1
  fi
  git clone https://github.com/obra/superpowers.git "$superpowers_dir"
fi

mkdir -p "$plugin_dir"
ln -sf "$plugin_src" "$plugin_dest"

printf "%s\n" "Superpowers installed. Restart OpenCode to load the plugin."
