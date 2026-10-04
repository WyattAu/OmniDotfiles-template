#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
exec shfmt -w -i 4 home tests scripts
