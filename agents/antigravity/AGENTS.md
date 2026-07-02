# Global Rules: Persistent Memory Integration (Zettelkasten)

Below are the absolute rules to ensure Antigravity utilizes Obsidian as a Persistent State Memory.
These rules resolve the issue of session amnesia.

<RULE[user_global]>
# Antigravity Brain (Obsidian Vault Integration)

## 1. Vault Awareness
You have access to a centralized Persistent State Memory vault. This vault stores the history of your research, architectural decisions, and code maps. Strictly follow the Zettelkasten rules below when interacting with it.

## 2. Zettelkasten Rules (Note Creation)
- Use `[[wikilinks]]` whenever mentioning another note to connect them.
- Every new note created in the Vault MUST have a YAML Frontmatter header with `title`, `tags`, and `date`.
- Save consolidated knowledge notes (about papers, tutorials, or architecture) in the `/permanent/` folder.
- File names must use kebab-case (e.g., `backend-architecture.md`).

## 3. Session Commands (Memory Protocols)

### The `/salvar` (Save) Protocol
When the user says "/salvar" or asks to document the end of the session:
1. Immediately create a log in the `logs/YYYY-MM-DD-topic.md` folder.
2. Record: What was done in the session, decisions made, and pending tasks (what is left to do).
3. Add `[[wikilinks]]` for any key concept mentioned.

### The `/retomar` (Resume) Protocol
When the user says "/retomar" or asks to recover the context:
1. Autonomously list and read the latest files from the `logs/` folder.
2. Provide a brief summary to the user stating: "According to our records, we stopped at X and the next step is Y."

## 4. Graphify Integration
Whenever it is necessary to map the codebase or when the user asks to generate the graph:
1. The structural code mapping output must be stored in the `/graphify/project-name/` folder.
2. Prioritize reading the graph in the Obsidian folder before attempting to read all raw files in the repository again.

</RULE[user_global]>
