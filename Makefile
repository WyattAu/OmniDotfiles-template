# Thin wrapper over scripts/ — the same verbs in every Omni template.
.PHONY: bench bench-update test lint fmt apply-dry contract ci

test:
	./scripts/test.sh

lint:
	./scripts/lint.sh

fmt:
	./scripts/fmt.sh

apply-dry:
	./scripts/apply-dry-run.sh

contract:
	./scripts/check-contract.sh

## What CI gates before merge (mirror of .github/workflows/ci.yml):
ci: contract lint test

bench:
	./scripts/bench-budget.sh

bench-update:
	./scripts/bench-budget.sh --update

