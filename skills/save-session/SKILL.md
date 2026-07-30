---
name: save-session
description: "Triggered when the user types /save or asks to save the session. Generates a session log and saves it to the Obsidian Vault."
---
# Skill: save-session

Sempre que a skill for invocada, o Agente executará mandatoriamente os seguintes passos:

**Fase 1: Recuperação de Contexto (Token Budget)**
Verifique primeiro se existe o arquivo de trace da sessão em:
`<appDataDir>/brain/<conversation-id>/scratch/session-trace.md`

- **Se o arquivo existir e tiver conteúdo:** Use-o como fonte primária da timeline. Ele contém as anotações que você mesmo fez durante a sessão. NÃO leia o `transcript.jsonl` — isso é redundante e desperdiça tokens.
- **Se o arquivo NÃO existir ou estiver vazio (sessão nova ou crash):** Faça a recuperação de emergência:
  - **Se você for o Antigravity:** Utilize a ferramenta `grep_search` no `transcript.jsonl` (localizado em `<appDataDir>/brain/<conversation-id>/.system_generated/logs/`). Busque por `"type":"USER_INPUT"` para reconstruir a timeline.
  - **Se você for o Claude Code:** Varra os logs em `.claude/` ou peça ao usuário para rodar `/compact`.

**Fase 2: Geração do Zettelkasten**
Formate um documento `markdown` com as informações extraídas:
   - Adicione Frontmatter YAML (`title`, `tags`, `date`).
   - Registre o que foi feito detalhadamente, incluindo as tags de observação: `#decision`, `#change`, `#bugfix`, `#discovery`, `#feature`, `#file`.
   - Registre as decisões tomadas.
   - Registre as pendências (próximos passos).
   - Use `[[wikilinks]]` para ligar conceitos.
3. Utilize sua capacidade de escrever arquivos para gerar uma nota `YYYY-MM-DD-assunto.md` dentro do caminho exato: `/Users/joaopms/Documents/AntigravityBrain/logs/`.
4. Atualize `/wiki/changelog.md` com uma entrada do tipo `session`.
5. Atualize `/wiki/index.md` se novas páginas wiki foram criadas durante a sessão.
6. **Delete o arquivo de trace** `<appDataDir>/brain/<conversation-id>/scratch/session-trace.md`. O log permanente foi gerado; o trace é memória temporária e deve ser removido agora.
7. Confirme para o usuário que o log foi salvo no Obsidian.
