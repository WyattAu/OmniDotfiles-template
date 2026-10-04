#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
# shellcheck non-template scripts; templates carry chezmoi directives that
# shellcheck cannot parse (bats + CI cover behavior).
find home -type f ! -name '*.tmpl' -print0 | xargs -0 -r shellcheck
exec shfmt -d -i 4 home tests scripts
