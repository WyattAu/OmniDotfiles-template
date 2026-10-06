#!/usr/bin/env bash
# Reproducible-build check (loop 3): build twice from a clean state with a pinned
# epoch and compare artifact hashes.
#
# MODE=gate - "gate" for toolchains that are deterministic (a mismatch is a
# real finding), "report" for toolchains that embed timestamps by design (a
# mismatch is printed and explained, never blocks). See the ADR.
set -euo pipefail
cd "$(dirname "$0")/.."
MODE=gate
EPOCH="${SOURCE_DATE_EPOCH:-$(git log -1 --pretty=%ct 2>/dev/null || echo 0)}"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

compare() {
    if [ "$1" = "$2" ]; then
        echo "reproducible: OK ($1)"
        return 0
    fi
    echo "reproducible: MISMATCH" >&2
    echo "  run A: $1" >&2
    echo "  run B: $2" >&2
    if [ "$MODE" = "gate" ]; then
        echo "  this toolchain is expected to be deterministic - fix the build" >&2
        exit 1
    fi
    echo "  reported only: " >&2
    exit 0
}

# chezmoi rendering is deterministic by construction, so this is the one place
# where a mismatch is always a template bug.
render() {
    mkdir -p "$WORK/$1"
    printf 'sourceDir = "%s"\n' "$PWD/home" >"$WORK/omni-config.toml"
    # HOME points at the scratch dir so chezmoi's run_once scripts stay hermetic,
    # and stdout is redirected to stderr: a run_once script's chatter would
    # otherwise land in the captured manifest (and only on the first run, which
    # makes the diff look like a phantom mismatch).
    HOME="$WORK/$1" chezmoi apply --destination "$WORK/$1" \
        --config "$WORK/omni-config.toml" >&2
    find "$WORK/$1" -type f -print0 | sort -z | xargs -0 sha256sum | awk '{print $1, $2}' |
        sed "s|$WORK/$1/||"
}
a="$(render a)"
b="$(render b)"
compare "$a" "$b"
