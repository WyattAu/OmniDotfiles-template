#!/usr/bin/env bash
# Perf budget gate: measure, emit bench/current.tsv, compare to the committed
# baseline with the shared comparator. `make bench-update` re-baselines
# deliberately - it is the only way a baseline moves.
set -euo pipefail
cd "$(dirname "$0")/.."
BASELINE=bench/baseline.tsv
CURRENT=bench/current.tsv
THRESHOLD_PCT="${OMNI_BENCH_THRESHOLD_PCT:-25}"
UPDATE=()
[ "${1:-}" = "--update" ] && UPDATE=(--update)
mkdir -p bench

# The user-facing latency of dotfiles is shell startup, so that is what we
# budget: apply chezmoi to a scratch home (same flow as the bats suite) and
# time a real interactive login shell.
now_ms() {
    python3 -c 'import time; print(int(time.time() * 1000))'
}

scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT
dest="$scratch/dest"
mkdir -p "$dest"
printf 'sourceDir = "%s"\n' "$PWD/home" >"$scratch/omni-config.toml"
chezmoi apply --destination "$dest" --config "$scratch/omni-config.toml"

start="$(now_ms)"
env HOME="$dest" TERM=dumb bash -i -c 'exit' >/dev/null 2>&1 || true
end="$(now_ms)"

printf 'shell-startup-ms\t%s\tms\tinfo\n' "$((end - start))" >"$CURRENT"

python3 scripts/compare-bench.py "$BASELINE" "$CURRENT" \
    --threshold-pct "$THRESHOLD_PCT" "${UPDATE[@]+"${UPDATE[@]}"}"
