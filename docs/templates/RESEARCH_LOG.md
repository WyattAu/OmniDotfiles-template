# RESEARCH_LOG template

One table per research campaign; append-only once frozen (SPEC-CORE §5).
Each row is one iteration: paper read, disposition, and the deltas it
produced. Reference shape: estate research repos keep this ledger at
`docs/RESEARCH_LOG.md` with the same columns.

| Iter | Date | Source (DOI/URL) | Disposition | Spec delta | Proof delta | Novelty claim |
|---|---|---|---|---|---|---|
| 1 | YYYY-MM-DD | <doi or url> | adopt/observe/reject | <SPEC §N change or none> | <lemma/theorem change or none> | <claim or none> |

Dispositions:

- **adopt**: the finding changes a normative artifact (spec, proof, or
  reference implementation) in this repo; the delta columns must be filled.
- **observe**: relevant to the wedge but no artifact changes; record why.
- **reject**: considered and declined; record the rejection reason so the
  same paper is not re-litigated.

Freeze discipline: when a campaign closes, stamp the log
`FROZEN (<date>)` and score all pre-registered predictions at gates only
(estate ROADMAP prediction discipline), never mid-sprint.
