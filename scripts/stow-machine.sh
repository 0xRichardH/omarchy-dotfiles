#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/stow-machine.sh [--simulate] <laptop|desktop>

Stow shared dotfile packages plus the selected host overlay package.
USAGE
}

simulate=false
host=""

while (($#)); do
  case "$1" in
    --simulate|-n)
      simulate=true
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    --*)
      echo "unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      if [[ -n "$host" ]]; then
        echo "unexpected argument: $1" >&2
        usage >&2
        exit 2
      fi
      host="$1"
      shift
      ;;
  esac
done

if [[ -z "$host" ]]; then
  usage >&2
  exit 2
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

host_package="hosts-$host"
if [[ ! -d "$host_package" ]]; then
  echo "host package does not exist: $host_package" >&2
  exit 1
fi

shared_packages=(
  agents
  atuin
  bash
  bw
  fish
  ghostty
  git
  herdr
  hypr
  mise
  nvim
  opencode
  pi
  sesh
  ssh
  starship
  tmux
  xremap
  yazi
  zed
)

missing_packages=()
for package in "${shared_packages[@]}"; do
  [[ -d "$package" ]] || missing_packages+=("$package")
done

if ((${#missing_packages[@]})); then
  echo "shared package directories are missing:" >&2
  printf '  %s\n' "${missing_packages[@]}" >&2
  exit 1
fi

find_package_targets() {
  local package="$1"
  find "$package" -type f -o -type l | while IFS= read -r path; do
    printf '%s\t%s\n' "${path#"$package/"}" "$package"
  done
}

duplicates="$(
  {
    for package in "${shared_packages[@]}" "$host_package"; do
      find_package_targets "$package"
    done
  } | sort | awk -F '\t' '
    current == "" { current = $1; owners = $2; count = 1; next }
    $1 == current { owners = owners ", " $2; count++; next }
    count > 1 { print current "\t" owners }
    { current = $1; owners = $2; count = 1 }
    END { if (count > 1) print current "\t" owners }
  '
)"

if [[ -n "$duplicates" ]]; then
  echo "duplicate stow targets found for $host_package:" >&2
  while IFS=$'\t' read -r target owners; do
    [[ -n "$target" ]] || continue
    echo "  $target" >&2
    echo "    owned by: $owners" >&2
  done <<< "$duplicates"
  echo "Move host-specific files out of shared packages, or remove duplicate host files." >&2
  exit 1
fi

stow_args=(--target="$HOME" --no-folding --restow)
if [[ "$simulate" == true ]]; then
  stow_args+=(--simulate --verbose)
fi
stow_args+=("${shared_packages[@]}" "$host_package")

printf 'Running: stow'
printf ' %q' "${stow_args[@]}"
printf '\n'
exec stow "${stow_args[@]}"
