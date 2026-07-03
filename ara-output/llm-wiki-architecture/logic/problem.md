# Problem Specification

## Observations

### O1: The RAG Amnesia
- **Statement**: In traditional Retrieval-Augmented Generation (RAG), the LLM rediscovers knowledge from scratch on every question.
- **Evidence**: Karpathy gist, §The core idea.
- **Implication**: Complex questions requiring synthesis of multiple documents force the LLM to piece together fragments every time, preventing knowledge compounding.

### O2: The Maintenance Burden
- **Statement**: The tedious part of maintaining a knowledge base is not reading or thinking, but bookkeeping (updating cross-references, keeping summaries current, noting contradictions).
- **Evidence**: Karpathy gist, §Why this works.
- **Implication**: Humans abandon wikis because the maintenance burden grows faster than the value.

## Gaps

### G1: Lack of Persistent Accumulation
- **Statement**: Existing systems retrieve from raw documents but do not build up a structured, interlinked collection of persistent knowledge.
- **Caused by**: O1
- **Existing attempts**: Semantic search, vector databases, NotebookLM.
- **Why they fail**: They fetch fragments but do not synthesize or resolve contradictions ahead of query time.

## Key Insight
- **Insight**: Instead of retrieving from raw documents at query time, the LLM should incrementally build and maintain a persistent wiki (a structured, interlinked collection of markdown files) that sits between the human and the raw sources.
- **Derived from**: O1, O2
- **Enables**: Zero-cost maintenance of a compounding knowledge base where cross-references, contradictions, and synthesis are pre-compiled and kept current.

## Assumptions
- A1: LLMs have sufficient context and instruction-following capability to correctly update 10-15 markdown files consistently during an ingest operation.
- A2: A schema document (e.g., AGENTS.md) is sufficient to constrain the LLM into a disciplined wiki maintainer rather than a generic chatbot.
