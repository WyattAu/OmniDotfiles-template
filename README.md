# OmniDotfiles-template

Maximalist **dotfiles** template: chezmoi-first templating, shellcheck +
shfmt + **bats behavioral tests**, CI that applies to a scratch home in
**ubuntu and arch containers** (CachyOS parity) — nix flake + dual
devcontainers. Part of the [WyattAu Omni family](https://github.com/WyattAu?tab=repositories&q=omni-).

## Start here

1. `home/` is the target home: `dot_gitconfig.tmpl` → `~/.gitconfig`, etc.
2. Values live once in `home/.chezmoidata/defaults.toml`; per-host overrides
   stay local (`.chezmoihostname.toml.*`).
3. Door: nix+direnv / devcontainer(image|nix) — `./scripts/bootstrap.sh`.
4. `make ci` — lint + bats, plus CI's arch-container leg.

## Make targets

| Target | Gate |
|---|---|
| `make lint` | shellcheck + shfmt -d |
| `make fmt` | shfmt -w |
| `make test` | bats — applies to a scratch home, asserts behavior |
| `make apply-dry` | what would change on this host |
| `make contract` / `make ci` | contract / contract+lint+test |

## Estate pointers

Pairs with the ansible roles in cachyos_sys_dotfiles (packages/monitoring)
— this template owns files, ansible owns packages and services.

## License

Apache-2.0 — commercial use expressly permitted.


## Performance budgets

Performance is a gate, not a hope. `make bench` measures, writes
`bench/current.tsv`, and compares it against the committed
`bench/baseline.tsv`; anything more than the threshold worse fails. The
comparator (`scripts/compare-bench.py`) is identical across the whole Omni
estate, so the policy is auditable in one place.

| Verb | What it does |
|---|---|
| `make bench` | measure + compare (advisory job in CI: `perf`) |
| `make bench-update` | deliberately re-baseline; the only way a baseline moves |

The first run on a fresh clone records the baseline instead of failing, so the
gate is meaningful from the second run onwards. Override the budget per run
with `OMNI_BENCH_THRESHOLD_PCT=15 make bench`. Rationale and per-template
metrics: `docs/adr/0004-performance-budget-gate.md`.


## Determinism

`make repro` builds twice from a clean state with a pinned `SOURCE_DATE_EPOCH`
and compares artifact hashes. Toolchains that are deterministic gate the build;
toolchains that embed timestamps or build ids by design report the difference
and explain why, rather than pretending to be reproducible. Rationale and the
per-toolchain split: `docs/adr/0005-determinism-verification.md`.
