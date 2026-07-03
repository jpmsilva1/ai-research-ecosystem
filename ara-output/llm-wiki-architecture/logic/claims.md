## C01: Persistent LLM-Wikis eliminate redundant synthesis at query time
- **Statement**: An LLM-maintained wiki pre-compiles synthesis and cross-references during ingestion, meaning queries against the wiki do not require re-deriving knowledge from raw sources.
- **Status**: hypothesis
- **Falsification criteria**: If querying a pre-compiled wiki requires the same amount of LLM context tokens and reasoning steps as querying raw RAG documents.
- **Proof**: [E01]
- **Evidence basis**: Karpathy states "The cross-references are already there. The contradictions have already been flagged... The knowledge is compiled once and then kept current, not re-derived on every query."
- **Interpretation**: Moving computation to ingest time rather than query time.
- **Dependencies**: none
- **Tags**: RAG, compilation, efficiency

## C02: LLMs can maintain wikis at near-zero marginal cost
- **Statement**: Using an LLM to perform bookkeeping (cross-referencing, updating summaries, logging) prevents wiki abandonment because LLMs do not experience maintenance fatigue.
- **Status**: supported
- **Falsification criteria**: If LLM hallucinations or context limit errors cause wiki drift that requires extensive human intervention.
- **Proof**: [E02]
- **Evidence basis**: Karpathy notes: "LLMs don't get bored, don't forget to update a cross-reference, and can touch 15 files in one pass."
- **Interpretation**: Automation of the structural maintenance problem outlined by Vannevar Bush's Memex.
- **Dependencies**: C01
- **Tags**: maintenance, memex, automation
