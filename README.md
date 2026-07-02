# AI Research Workflow: Memória Persistente para LLMs

**Resolvendo o problema de Amnésia em Inteligências Artificiais e Agentes Autônomos.**

Este ecossistema permite que o Antigravity e o Claude Code ganhem uma "Segunda Mente" baseada no Obsidian. O agente LLM para de esquecer as decisões do seu projeto e se apoia num motor estrutural Zettelkasten para leitura e escrita, diminuindo brutalmente o gasto de tokens e a exaustão em re-explicar contexto.

## 🧠 Como Funciona a Arquitetura
1. **O Cofre (Obsidian Vault)**: Um diretório puramente baseado em arquivos Markdown onde as informações são mantidas a longo prazo (`/permanent`), logs cronológicos são diários (`/logs`) e grafos do seu projeto são montados (`/graphify`).
2. **O LLM (Agente)**: Lê e escreve nestes arquivos de forma autônoma toda vez que você der os comandos (ex: `/salvar`, `/retomar`).
3. **As Skills**: Habilidades (prompts e ferramentas predefinidas) acopladas ao LLM para focar puramente em método científico rigoroso ou engenharia avançada.

---

## 🚀 Guia de Setup Rápido (Google Antigravity)

Oferecemos duas trilhas de instalação dependendo do seu nível de necessidade.

### Opção A: Core Pack Acadêmico
Traz as ~10 habilidades metodológicas vitais para mestrandos, doutorandos e pesquisadores (Escrita de Artigos, Desconstrução de Papers em Grafos e Revisão de Literatura profunda).

**Instalação Automática via LLM:**
Copie o bloco de prompt correspondente no arquivo `auto-install-prompts.md` e cole no seu Antigravity. A IA instalará tudo sozinha.

**Instalação Manual (Linux/Mac):**
```bash
agy plugin install https://github.com/DietrichGebert/ponytail
git clone https://github.com/Orchestra-Research/AI-Research-SKILLs.git /tmp/ai-research-skills
git clone https://github.com/google/antigravity-awesome-skills.git /tmp/awesome-skills
mkdir -p ~/.gemini/config/skills
cp -r /tmp/ai-research-skills/20-ml-paper-writing/ml-paper-writing ~/.gemini/config/skills/
cp -r /tmp/ai-research-skills/20-ml-paper-writing/academic-plotting ~/.gemini/config/skills/
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/compiler ~/.gemini/config/skills/ara-compiler
cp -r /tmp/awesome-skills/skills/deep-research ~/.gemini/config/skills/
cp -r /tmp/awesome-skills/skills/papers-skill ~/.gemini/config/skills/
```

### Opção B: Full Pack (130+ Skills de Engenharia)
Se além de pesquisa você faz deploy na nuvem, automação Kubernetes, MLOps e Engenharia de Dados pesada.

**Instalação Automática:** Use o arquivo `auto-install-prompts.md`.

**Instalação Manual:**
```bash
agy plugin install https://github.com/DietrichGebert/ponytail
git clone https://github.com/Orchestra-Research/AI-Research-SKILLs.git /tmp/ai-research-skills
git clone https://github.com/google/antigravity-awesome-skills.git /tmp/awesome-skills
mkdir -p ~/.gemini/config/skills
cp -r /tmp/ai-research-skills/*/* ~/.gemini/config/skills/
cp -r /tmp/awesome-skills/skills/* ~/.gemini/config/skills/
```

---

## 🤖 Guia de Setup (Claude Code / Cursor IDE)
Se o seu LLM preferido é o Claude via Cursor ou Windsurf, não usamos `AGENTS.md`. 
Em vez disso, copie o conteúdo do arquivo `claude/.cursorrules` para a raiz do seu projeto. Esse arquivo dita ao modelo LLM as mesmas regras de interação com a sua pasta Obsidian, permitindo a "consciência da memória".

---

## 📚 Guias de Utilização
Para aprender a extrair 100% de potencial dessas ferramentas, leia:
- **[Guia Core Pack Acadêmico](guides/core-pack-usage.md)**: Pesquisa estruturada, literatura e escrita.
- **[Guia Full Pack Engenharia](guides/full-pack-usage.md)**: MLOps, DevOps e TDD profundo.

---

## 🏆 Agradecimentos e Créditos
Este ecossistema amalgama ferramentas brilhantes da comunidade Open-Source. Todo crédito vai para os autores originais:

- **Inspiração Original (Memória Claude+Obsidian)**: O conceito inicial de integração de memória de longo prazo usando Obsidian foi inspirado no trabalho de **Lucas Rosati** ([lucasrosati/claude-code-memory-setup](https://github.com/lucasrosati/claude-code-memory-setup)).
- **Ponytail Plugin**: Desenvolvido por Dietrich Gebert ([DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail)).
- **Pesquisa Acadêmica & ARA**: Desenvolvido por Orchestra Research ([Orchestra-Research/AI-Research-SKILLs](https://github.com/Orchestra-Research/AI-Research-SKILLs)).
- **Base ML & Engenharia**: Catálogo oficial mantido pelo Google ([google/antigravity-awesome-skills](https://github.com/google/antigravity-awesome-skills)).
- **Deep Research**: Desenvolvido por sanjay3290 ([sanjay3290/ai-skills](https://github.com/sanjay3290/ai-skills/tree/main/skills/deep-research)).
