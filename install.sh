#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh <laptop|desktop> [--non-interactive]
USAGE
}

host="${1:-}"
mode="${2:-}"
if [[ -z "$host" ]] || [[ "$host" != "laptop" && "$host" != "desktop" ]]; then
  usage >&2
  exit 2
fi
if [[ -n "$mode" && "$mode" != "--non-interactive" ]] || (($# > 2)); then
  usage >&2
  exit 2
fi

package_args=()
if [[ "$mode" == "--non-interactive" ]]; then
  package_args+=(--non-interactive)
fi

omarchy-install-tailscale

./scripts/install-packages.sh "${package_args[@]}"
./scripts/install-stow.sh "$host"
./scripts/enable-ssh-agent-service.sh
./scripts/enable-opencode-service.sh
./scripts/install-xremap.sh
./scripts/install-yazi.sh
./scripts/install-fcitx5.sh
./scripts/install-cronie.sh
./scripts/install-rclone.sh
./scripts/install-fish.sh
