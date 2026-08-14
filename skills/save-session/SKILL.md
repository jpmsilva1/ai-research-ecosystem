---
name: save-session
description: "Triggered when the user types /save or asks to save the session. Generates a session log and saves it to the Obsidian Vault."
---
# Skill: save-session

Whenever this skill is invoked, the Agent must mandatorily execute the following steps:

**Phase 1: Context Recovery (Token Budget)**
First check whether the session trace file exists at:
`<appDataDir>/brain/<conversation-id>/scratch/session-trace.md`

- **If the file exists and has content:** Use it as the primary timeline source. It contains the notes you took yourself during the session. Do NOT read `transcript.jsonl` -- that is redundant and wastes tokens.
- **If the file does NOT exist or is empty (new session or crash):** Perform emergency recovery:
  - **If you are Antigravity:** Use the `grep_search` tool on `transcript.jsonl` (located at `<appDataDir>/brain/<conversation-id>/.system_generated/logs/`). Search for `"type":"USER_INPUT"` to reconstruct the timeline.
  - **If you are Claude Code:** Scan the logs in `.claude/` or ask the user to run `/compact`.

**Phase 2: Zettelkasten Generation**
Format a `markdown` document with the extracted information:
   - Add YAML frontmatter (`title`, `tags`, `date`).
   - Record what was done in detail, including the observation tags: `#decision`, `#change`, `#bugfix`, `#discovery`, `#feature`, `#file`.
   - Record the decisions made.
   - Record the pending items (next steps).
   - Use `[[wikilinks]]` to connect concepts.
3. Use your file-writing capability to generate a note `YYYY-MM-DD-topic.md` at the exact path: `{{VAULT_PATH}}/logs/`.
4. Update `{{VAULT_PATH}}/wiki/changelog.md` with a `session` entry.
5. Update `{{VAULT_PATH}}/wiki/index.md` if new wiki pages were created during the session.
6. **Delete the trace file** `<appDataDir>/brain/<conversation-id>/scratch/session-trace.md`. The permanent log has been generated; the trace is temporary memory and should now be removed.
7. Confirm to the user that the log was saved to Obsidian.
