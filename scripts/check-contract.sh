#!/usr/bin/env bash
# Omni Core Contract checks (THREAT-MODEL T4/T5) — same shape in every Omni.
set -euo pipefail
cd "$(dirname "$0")/.."
fail=0

for wf in .github/workflows/*.yml .forgejo/workflows/*.yml; do
    grep -q 'permissions:' "$wf" || {
        echo "FAIL: $wf missing explicit permissions block"
        fail=1
    }
done

while read -r script; do
    [ -x "$script" ] || {
        echo "FAIL: Makefile references missing script $script"
        fail=1
    }
done < <(grep -oP '(?<=^	)(scripts/[a-z-]+\.sh)' Makefile | sort -u)

# secrets in templates are a CI-only catch: gitleaks runs in CI too
grep -rn 'API_KEY\|SECRET\|TOKEN' home --include='*.tmpl' | grep -v '{{' && {
    echo "FAIL: possible hardcoded secret in template (REQ-T-100)"
    fail=1
} || true

[ "$fail" -eq 0 ] && echo "contract: OK"
exit "$fail"
