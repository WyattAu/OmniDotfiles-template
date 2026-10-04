# OmniDotfiles-template

Maximalist **dotfiles** template: chezmoi-first templating, shellcheck +
shfmt + **bats behavioral tests**, CI that applies to a scratch home in
**ubuntu and arch containers** (CachyOS parity) — nix flake + dual
devcontainers. Part of the [WyattAu Omni family](https://github.com/WyattAu?tab=repositories&q=omni-).

## Start here

1. `home/` is the target home: `dot_gitconfig.tmpl` → `~/.gitconfig`, etc.
2. Values live once in `.chezmoidata/defaults.toml`; per-host overrides
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
