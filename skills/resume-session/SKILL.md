---
name: resume-session
description: "Triggered when the user types /resume or asks to resume. Reads the previous session logs from the Obsidian Vault to restore context."
---
# Skill: resume-session

Sempre que a skill for invocada, o Agente executará mandatoriamente os seguintes passos:

1. Leia o arquivo `{{VAULT_PATH}}/wiki/changelog.md` (apenas as últimas 10 entradas). Identifique a entrada mais recente do tipo `session` e extraia o nome do arquivo de log referenciado nela.
2. Leia o arquivo `{{VAULT_PATH}}/wiki/index.md` para entender o estado atual do conhecimento no vault.
3. Leia SOMENTE o arquivo de log identificado no passo 1. Não carregue múltiplos logs sem ser solicitado pelo usuário.
4. Elabore e exiba um Resumo Executivo para o usuário, informando:
   - O que estávamos fazendo antes.
   - Quais eram as pendências deixadas pela sessão anterior.
   - Pergunte: **"Deseja que eu carregue contexto adicional de sessões anteriores?"**
5. Somente carregue logs adicionais se o usuário confirmar explicitamente. Cada log extra custa ~500-2.000 tokens — sempre pergunte antes de gastar.
