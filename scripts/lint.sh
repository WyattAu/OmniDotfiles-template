#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Shellcheck only files that declare shell syntax (shebang or shellcheck
# directive) — chezmoi support files (.chezmoiignore, .chezmoidata) are not
# shell. Templates carry directives shellcheck cannot parse; bats + CI
# cover behavior.
for f in $(find home -type f ! -name '*.tmpl'); do
    head -1 "$f" | grep -qE '#!|shellcheck shell=' && shellcheck "$f"
done
exec shfmt -d -i 4 home tests scripts
