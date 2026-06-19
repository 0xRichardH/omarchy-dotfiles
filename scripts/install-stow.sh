#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/install-stow.sh <laptop|desktop>

Install GNU Stow, then stow shared packages plus the selected host overlay.
USAGE
}

host="${1:-}"
if [[ -z "$host" ]]; then
  usage >&2
  exit 2
fi

sudo pacman -S --noconfirm --needed stow

"$(dirname "$0")/stow-machine.sh" "$host"
