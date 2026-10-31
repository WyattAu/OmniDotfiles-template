# <kit>: <one-line function> (SPEC)

> **Status: DRAFT**
<!-- Lifecycle (SPEC-CORE §5): DRAFT -> REVIEW -> CURRENT -> FROZEN (date)
     -> SUPERSEDED by <path>. FROZEN lines must carry an ISO date;
     SUPERSEDED lines must carry a successor path (gate-enforced). -->

**Layer:** <L0..L3> · **REQs:** N (<PREFIX>-001…NNN) · **Oracle:**
<path | No-oracle: <reason>> · **Date:** YYYY-MM-DD

| Field | Value |
|---|---|
| Estate deps | <crates/kit repos this depends on> |
| External deps | <external libraries; none mandatory> |
| Consumers | <repos that pin or compose this> |

## §1 Scope

In scope: <items>. Out of scope: <items, with pointers to the owning spec>.

## §2 Semantics

Normative statements only; every statement cites its enforcement point
(SC-3): a theorem name, a golden-vector set, a gate name, or a test name.
Section numbers are load-bearing: gates and proofs cite `§N`.

## §3 Requirements

| REQ | Statement | Verified by |
|---|---|---|
| REQ-<PREFIX>-001 | <one-sentence, testable> | <theorem\|test\|gate> |

Implementation public items carry doc-comment tags citing their REQ
(SPEC-CORE §4): `/// [REQ-<PREFIX>-001] <restatement>`.

## §4 Test vectors

Golden vectors are committed under <path>; regeneration is deterministic
and `git diff` clean (`make golden && git diff`). Vectors follow the
estate test-vector conventions (categories: nominal, boundary, adversarial,
regression, random).

## §5 Delta log

| Date | Version | Change | Reason |
|---|---|---|---|
| YYYY-MM-DD | v1 | seed | <iteration/research reference> |

Corrections are logged here and in the header note, never erased (SC-5).
