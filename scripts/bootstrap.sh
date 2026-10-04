#!/usr/bin/env bash
# Non-nix fallback. Canonical env: flake.nix.
set -euo pipefail
cat <<'MSG'
Manual toolchain (no nix):
  1. chezmoi, shellcheck, shfmt, bats (package manager)
  2. make ci
Prefer zero setup? Open the repo in a devcontainer, or `nix develop`.
MSG
