# 0001 — chezmoi-first, containers for OS parity

Date: 2026-10-04

## Status

Accepted

## Context

The estate's dotfiles run on CachyOS (Arch), WSL, and Windows. Raw stow
repos drift per host; ansible solves packages, not file templating.

## Decision

chezmoi is the file-templating engine (single source of truth in
`.chezmoidata`, per-host templates); CI applies to a scratch destination in
**both** ubuntu and arch containers so template logic is proven on both
package universes. Ansible remains available for package/role management in
the estate's existing dotfiles — this template owns the files layer.

## Consequences

- `make ci` proves rendering, lint, and behavior without any host.
- Host-specific overrides stay uncommitted (`.chezmoihostname.toml.*`).
