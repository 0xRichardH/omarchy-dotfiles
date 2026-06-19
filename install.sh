#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh <laptop|desktop>
USAGE
}

host="${1:-}"
if [[ -z "$host" ]]; then
  usage >&2
  exit 2
fi

omarchy-install-tailscale

./scripts/install-stow.sh "$host"
./scripts/enable-ssh-agent-service.sh
./scripts/enable-opencode-service.sh
./scripts/install-xremap.sh
./scripts/install-yazi.sh
./scripts/install-fcitx5.sh
./scripts/install-cronie.sh
./scripts/install-rclone.sh
./scripts/install-fish.sh
