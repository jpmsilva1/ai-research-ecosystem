## H01: The Index File
- **Rationale**: An `index.md` listing everything in the wiki avoids the need for complex vector/BM25 search at smaller scales (~100 sources). It acts as a lightweight router for the LLM.
- **Sensitivity**: medium
- **Bounds**: Effective up to hundreds of pages.
- **Code ref**: [src/execution/wiki_operations.py]
- **Source**: §Indexing and logging

## H02: The Chronological Log
- **Rationale**: A `log.md` with strict prefixes (e.g., `## [YYYY-MM-DD] ingest | Title`) allows simple unix tools (`grep`) to parse history and helps the LLM understand recent actions.
- **Sensitivity**: low
- **Bounds**: N/A
- **Code ref**: [src/execution/wiki_operations.py]
- **Source**: §Indexing and logging

## H03: File Query Outputs
- **Rationale**: Good answers shouldn't disappear into chat history. Filing synthesized answers back into the wiki ensures knowledge compounds.
- **Sensitivity**: high
- **Bounds**: N/A
- **Code ref**: [src/execution/wiki_operations.py]
- **Source**: §Operations
