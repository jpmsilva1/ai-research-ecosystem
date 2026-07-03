# Architecture

The LLM-Wiki system architecture consists of three distinct layers:

1. **Raw Sources**
   - **Purpose**: A curated collection of source documents (articles, papers, images, data files).
   - **Inputs**: User curates these.
   - **Outputs**: Immutable text read by the LLM.
   - **Key design choices**: Kept strictly immutable. This is the ultimate ground truth.

2. **The Wiki**
   - **Purpose**: A directory of LLM-generated markdown files (summaries, entity pages, concept pages, etc.).
   - **Inputs**: LLM writes to it, reads from it. Human reads it.
   - **Outputs**: The structured knowledge base.
   - **Key design choices**: The LLM owns this layer entirely. It creates pages, updates them, maintains cross-references, and keeps consistency.

3. **The Schema**
   - **Purpose**: A configuration document that dictates LLM behavior.
   - **Inputs**: Co-evolved by the Human and LLM.
   - **Outputs**: Instructions loaded into the LLM's system prompt or base context.
   - **Key design choices**: It is what turns a generic chatbot into a disciplined wiki maintainer (e.g., AGENTS.md, .cursorrules).
