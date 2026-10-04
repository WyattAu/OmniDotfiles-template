#!/usr/bin/env bash
# What would change on THIS host? (the daily-driver check)
set -euo pipefail
cd "$(dirname "$0")/.."
exec chezmoi apply --dry-run --verbose
