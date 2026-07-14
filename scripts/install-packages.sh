#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/install-packages.sh [options]

Install packages declared in packages/official.txt and packages/aur.txt.

Options:
  --non-interactive   Also pass --noconfirm for AUR packages and upgrades
  --upgrade           Run yay -Syu after installing declared packages
  --audit             Show packages only on the system or only in the lists
  -h, --help          Show this help
USAGE
}

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
official_list="$repo_root/packages/official.txt"
aur_list="$repo_root/packages/aur.txt"

non_interactive=0
do_upgrade=0
do_audit=0

while (($#)); do
  case "$1" in
    --non-interactive)
      non_interactive=1
      ;;
    --upgrade)
      do_upgrade=1
      ;;
    --audit)
      do_audit=1
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

validate_package_lists() {
  local file
  for file in "$official_list" "$aur_list"; do
    if [[ ! -r "$file" ]]; then
      echo "Error: package list not found or unreadable: $file" >&2
      exit 1
    fi
  done
}

read_package_list() {
  sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' "$1"
}

load_package_list() {
  local file="$1"
  local target_name="$2"
  local output
  local -n target="$target_name"

  if ! output="$(read_package_list "$file")"; then
    echo "Error: failed to read package list: $file" >&2
    exit 1
  fi

  target=()
  if [[ -n "$output" ]]; then
    mapfile -t target <<< "$output"
  fi
}

require_arch() {
  if [[ ! -f /etc/arch-release ]]; then
    echo "Error: this script expects Arch Linux" >&2
    exit 1
  fi
}

require_yay() {
  if ! command -v yay >/dev/null 2>&1; then
    echo "Error: yay is required but not installed" >&2
    echo "Install yay first: https://github.com/Jguer/yay" >&2
    exit 1
  fi
}

yay_install_official() {
  local -a packages=("$@")

  if ((${#packages[@]})); then
    yay -S --needed --noconfirm "${packages[@]}"
  fi
}

yay_install_aur() {
  local -a packages=("$@")
  local -a args=(-S --needed)

  if ((${#packages[@]} == 0)); then
    return 0
  fi

  if ((non_interactive)); then
    args+=(--noconfirm)
  fi

  yay "${args[@]}" "${packages[@]}"
}

audit_packages() {
  local declared_output
  local installed_output
  local -a declared=()
  local -a installed=()
  local -a only_lists=()
  local -a only_system=()

  if ! declared_output="$({
    read_package_list "$official_list"
    read_package_list "$aur_list"
  } | sort -u)"; then
    echo "Error: failed to read package manifests" >&2
    exit 1
  fi

  if ! installed_output="$(pacman -Qqe | sort -u)"; then
    echo "Error: failed to query installed packages" >&2
    exit 1
  fi

  if [[ -n "$declared_output" ]]; then
    mapfile -t declared <<< "$declared_output"
  fi
  if [[ -n "$installed_output" ]]; then
    mapfile -t installed <<< "$installed_output"
  fi

  mapfile -t only_lists < <(comm -23 <(printf '%s\n' "${declared[@]}") <(printf '%s\n' "${installed[@]}"))
  mapfile -t only_system < <(comm -13 <(printf '%s\n' "${declared[@]}") <(printf '%s\n' "${installed[@]}"))

  echo "Declared packages missing from the system:"
  if ((${#only_lists[@]})); then
    printf '  %s\n' "${only_lists[@]}"
  else
    echo "  (none)"
  fi

  echo
  echo "Explicitly installed packages not in the manifests:"
  echo "  (informational only; not auto-removed)"
  if ((${#only_system[@]})); then
    printf '  %s\n' "${only_system[@]}"
  else
    echo "  (none)"
  fi
}

main() {
  require_arch
  validate_package_lists

  if ((do_audit)); then
    audit_packages
    return 0
  fi

  require_yay

  local -a official=()
  local -a aur=()
  load_package_list "$official_list" official
  load_package_list "$aur_list" aur

  if ((${#official[@]})); then
    echo "Installing official packages (${#official[@]})..."
    yay_install_official "${official[@]}"
  else
    echo "No official packages declared."
  fi

  if ((${#aur[@]})); then
    echo "Installing AUR packages (${#aur[@]})..."
    yay_install_aur "${aur[@]}"
  else
    echo "No AUR packages declared."
  fi

  if ((do_upgrade)); then
    echo "Running full system upgrade..."
    if ((non_interactive)); then
      yay -Syu --noconfirm
    else
      yay -Syu
    fi
  fi

  echo
  echo "Package install complete."
  echo "Declared lists:"
  echo "  $official_list"
  echo "  $aur_list"
}

main
