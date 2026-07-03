## LLM-Wiki
- **Notation**: $W$
- **Definition**: A structured, interlinked collection of markdown files generated and maintained by an LLM that sits between the user and raw source documents.
- **Boundary conditions**: Applies to persistent, compounding knowledge bases. Does not apply to ephemeral, one-shot QA sessions.
- **Related concepts**: Zettelkasten, Memex, RAG.

## The Schema
- **Notation**: $S$
- **Definition**: A configuration document (e.g., AGENTS.md or .cursorrules) that dictates the structure, conventions, and workflows the LLM must follow to act as a disciplined wiki maintainer.
- **Boundary conditions**: Must be accessible to the LLM agent within its system prompt or base context.
- **Related concepts**: System Prompt, Agent Rules.

## Ingest Operation
- **Notation**: $Op_{ingest}$
- **Definition**: The workflow where the LLM reads a raw source, summarizes it, updates the index, modifies relevant entity/concept pages, and appends to the log.
- **Boundary conditions**: Operates on immutable raw sources.
- **Related concepts**: Compilation, Indexing.

## Query Operation
- **Notation**: $Op_{query}$
- **Definition**: The workflow where the LLM searches the index, synthesizes an answer, and optionally files that synthesized answer back into the wiki as a new page.
- **Boundary conditions**: Should ideally query the compiled wiki rather than raw sources to minimize token overhead.
- **Related concepts**: Retrieval, Synthesis.

## Lint Operation
- **Notation**: $Op_{lint}$
- **Definition**: A periodic health-check where the LLM scans the wiki for contradictions, stale claims, orphan pages, or missing cross-references.
- **Boundary conditions**: Requires the LLM to process the structure of the wiki, not just the content.
- **Related concepts**: Garbage Collection, Validation.
