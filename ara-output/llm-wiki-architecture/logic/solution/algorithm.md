# LLM-Wiki Operations

## 1. Ingest Operation ($Op_{ingest}$)
When a new raw source $S_{new}$ is added:
1. LLM reads $S_{new}$.
2. LLM extracts key takeaways and discusses with human (optional).
3. LLM writes a summary page $P_{new}$ in the wiki.
4. LLM updates `index.md` with a link and one-line summary of $P_{new}$.
5. LLM searches for and updates relevant existing entity/concept pages $P_{1...k}$.
6. LLM appends an entry to `log.md`.

## 2. Query Operation ($Op_{query}$)
When a human asks question $Q$:
1. LLM reads `index.md` to identify relevant pages $P_{1...k}$.
2. LLM reads $P_{1...k}$.
3. LLM synthesizes an answer $A$.
4. (Optional) If $A$ contains novel synthesis or connections, LLM files $A$ back into the wiki as $P_{novel}$.

## 3. Lint Operation ($Op_{lint}$)
Periodically:
1. LLM scans the wiki.
2. Identifies contradictions, stale claims, and orphan pages.
3. Fixes issues autonomously or suggests actions to the human.
