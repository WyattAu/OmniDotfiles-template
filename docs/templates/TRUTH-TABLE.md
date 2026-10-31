# TRUTH-TABLE template (SPEC-CORE §3)

Paste into the repo contract file (`AGENTS.md` when present, else
`README.md`). Heading text is exact; the gate (`doc-lint.sh`) greps it and
stats every path.

## Where the truth lives

| Concern | File |
|---|---|
| Numeric semantics (normative) | docs/SPEC.md |
| Operations/sprints | docs/ROADMAP.md |

Rules:

1. One normative home per concern; two rows naming the same concern fail
   the gate.
2. The `File` column holds exactly one backticked path per row; the path
   must exist (use a directory path for grouped artifacts, example:
   `docs/adr/`).
3. Reference shape: `TRUTH-TABLE.md` in this directory; estate repos
   adopted under SC-7 keep their instance in the contract file.
