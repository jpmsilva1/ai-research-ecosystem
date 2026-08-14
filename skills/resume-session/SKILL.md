---
name: resume-session
description: "Triggered when the user types /resume or asks to resume. Reads the previous session logs from the Obsidian Vault to restore context."
---
# Skill: resume-session

Whenever this skill is invoked, the Agent must mandatorily execute the following steps:

1. Read the file `{{VAULT_PATH}}/wiki/changelog.md` (only the last 10 entries). Identify the most recent `session`-type entry and extract the log filename referenced in it.
2. Read the file `{{VAULT_PATH}}/wiki/index.md` to understand the current state of knowledge in the vault.
3. Read ONLY the log file identified in step 1. Do not load multiple logs unless requested by the user.
4. Prepare and display an executive summary for the user, stating:
   - What we were working on before.
   - What pending items were left by the previous session.
   - Ask: **"Would you like me to load additional context from previous sessions?"**
5. Only load additional logs if the user explicitly confirms. Each extra log costs ~500-2,000 tokens -- always ask before spending them.
