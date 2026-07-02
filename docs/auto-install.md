# Instalação via Prompt (Automação Autônoma)

Em vez de baixar pastas e copiar arquivos manualmente, você pode simplesmente pedir para o seu agente de IA preferido instalar o workflow para você. Escolha a sua IA (Antigravity ou Claude Code) e a sua trilha (Core Pack ou Full Pack), copie o bloco de texto inteiro e cole no terminal.

---

## Antigravity

### Opção A: Core Pack (Acadêmico)
Copie e cole este prompt no Antigravity:

```text
Atue como um engenheiro de configuração de sistema (System Setup Engineer).
Por favor, instale o meu ecossistema de pesquisa acadêmica executando os seguintes passos autônomos:

1. Instale o plugin ponytail rodando: `agy plugin install https://github.com/DietrichGebert/ponytail`
2. Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` para `/tmp/ai-research-skills`.
3. Crie a pasta `~/.gemini/config/skills/` se ela não existir.
4. Copie as pastas `ml-paper-writing`, `academic-plotting` e o diretório inteiro `22-agent-native-research-artifact` para a minha pasta de skills local. Renomeie as subpastas da `22-*` para `ara-compiler`, `ara-research-manager` e `ara-rigor-reviewer`.
5. Clone `https://github.com/google/antigravity-awesome-skills.git` para `/tmp/awesome-skills`.
6. Copie as skills `deep-research`, `papers-skill` e `latex-paper-conversion` para a minha pasta de skills local.
7. Ao terminar, apague os diretórios `/tmp/ai-research-skills` e `/tmp/awesome-skills` e me dê um resumo rápido de que tudo está instalado.
```

### Opção B: Full Pack (Engenharia + Acadêmico)
Copie e cole este prompt no Antigravity:

```text
Atue como um engenheiro de configuração de sistema. 
Por favor, instale o catálogo completo do Awesome Skills no meu ambiente:

1. Instale o plugin ponytail rodando: `agy plugin install https://github.com/DietrichGebert/ponytail`
2. Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` para `/tmp/ai-research-skills`.
3. Copie TODAS as skills de dentro das subpastas da Orchestra Research para a minha pasta `~/.gemini/config/skills/`.
4. Clone `https://github.com/google/antigravity-awesome-skills.git` para `/tmp/awesome-skills`.
5. Copie literalmente o conteúdo inteiro da pasta `skills/` do repositório clonado do Google para dentro do meu `~/.gemini/config/skills/`.
6. Ao terminar, limpe a pasta `/tmp/` e me confirme o fim da operação.
```

---

## Claude Code CLI

Se você utiliza o **Claude Code CLI** oficial da Anthropic, use este prompt:

```text
Você é o meu assistente Claude Code. Eu preciso que você configure o nosso ambiente de pesquisa acadêmica instalando um conjunto específico de skills e regras.

Passo 1: Descubra onde fica o seu diretório global de skills (por padrão o Claude CLI tem pastas de configurações onde suporta customizações) ou onde podemos guardar scripts bash úteis para você usar. Crie essa pasta.
Passo 2: Clone o repositório temporariamente: `git clone https://github.com/DietrichGebert/ponytail /tmp/ponytail-plugin` e implemente as regras do Ponytail nas suas instruções globais de não fazer over-engineering.
Passo 3: Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` para `/tmp/ai-research-skills` e mova as ferramentas acadêmicas (`ml-paper-writing`, ecossistema `ARA`) para o nosso ambiente.
Passo 4: Limpe a pasta `/tmp/`.
Passo 5: Leia os arquivos README que acabamos de baixar para entender a taxonomia de "Agent-Native Research Artifacts".
Me confirme quando acabar.
```
