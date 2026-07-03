# ADR 002: Implement a Central index.md with Auto-Update Rules

## Context
Finding relevant context in a growing wiki requires either vector search (expensive/complex) or reading all files (token heavy). 

## Decision
We are implementing a mandatory `/wiki/index.md` file that acts as a central catalog. Every page in the wiki must be listed here with a one-line summary and tags. The agent rules (`AGENTS.md`) have been updated with "The Index Protocol" requiring the agent to update this file on every edit, and to read this file *first* when answering queries.

## Consequences
- **Positive:** Massive token savings. The agent reads a ~200 line index instead of 15 separate files to find context.
- **Positive:** No need for complex vector databases or RAG pipelines for knowledge retrieval.
- **Negative:** The LLM must be disciplined enough to update the index consistently (enforced via agent rules).
