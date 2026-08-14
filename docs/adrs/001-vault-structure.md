# ADR 001: Adopt the LLM-Wiki Vault Structure

## Context
Our Obsidian Vault previously contained only `/logs/` and `/graphify/`. While this solved the immediate problem of session amnesia, it lacked a structured way to compound knowledge. Following the compilation of Karpathy's LLM-Wiki concept into an ARA, we identified the need for a more structured knowledge base.

## Decision
We are adopting a structured architecture for the vault. `/logs/` already existed
and is retained; this decision adds `/raw/` and `/wiki/` alongside it:
1. `/raw/`: Immutable source documents (ground truth).
2. `/wiki/`: LLM-maintained markdown files (`index.md`, `changelog.md`, `entities/`, `concepts/`, `synthesis/`).
3. `/graphify/`: AST project maps (read-only for the agent).
4. `/logs/`: Chronological session logs (pre-existing, unchanged by this decision).

## Consequences
- **Positive:** Clear ownership boundaries. The agent knows exactly what it can edit and what it must not touch.
- **Positive:** Knowledge now compounds structurally rather than being buried in chronological session logs.
- **Negative:** Existing users with flat `permanent/` or `logs/` folders will need to migrate their notes to the new `/wiki/` subdirectories.
