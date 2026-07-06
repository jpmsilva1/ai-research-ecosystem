# Installation Guide

The AI Research Ecosystem operates on a **Two-Pillar Architecture**:
1. **Phase 1: The Persistent Memory Engine** (An Obsidian Vault structured as a Zettelkasten).
2. **Phase 2: The Skill Ecosystem** (The actual agent tools and capabilities).

You can install the ecosystem using two different approaches: **Autonomous Prompt-Based Installation** (letting the AI install itself) or **Manual Terminal Installation** (running bash commands yourself).

Choose your desired track and follow the instructions below in order.

---

## 🤖 Method 1: Autonomous Prompt-Based Installation

Instead of executing scripts manually, you can instruct your preferred AI agent to build the architecture autonomously. Copy the entire prompt block and paste it into your terminal chat.

### Phase 1 & 2: Complete Setup Prompt (Core Pack)
Copy and paste this exact prompt into your Agent (Antigravity or Claude Code):

```text
Act as a System Setup Engineer.
Please install my academic research ecosystem by executing the following autonomous steps in order:

PHASE 1: PERSISTENT MEMORY ENGINE
1. Create the Obsidian Vault directory structure: `mkdir -p ~/Documents/AntigravityBrain/{raw/assets,wiki/{entities,concepts,synthesis},graphify,logs}`
2. Download the catalog templates directly into the Vault:
   - `curl -sL https://raw.githubusercontent.com/jpmsilva1/ai-research-ecosystem/main/obsidian-vault-template/wiki/index.md -o ~/Documents/AntigravityBrain/wiki/index.md`
   - `curl -sL https://raw.githubusercontent.com/jpmsilva1/ai-research-ecosystem/main/obsidian-vault-template/wiki/changelog.md -o ~/Documents/AntigravityBrain/wiki/changelog.md`
3. Configure my Agent:
   - If I am using Antigravity: Create `~/.gemini/config/AGENTS.md` and instruct it that the Vault path is `~/Documents/AntigravityBrain`.
   - If I am using Claude Code: Create `~/.claude/.cursorrules` and instruct it that the Vault path is `~/Documents/AntigravityBrain`.

PHASE 2: SKILL ECOSYSTEM (Core Pack)
1. Install the ponytail plugin by running: `agy plugin install https://github.com/DietrichGebert/ponytail` (If using Antigravity)
2. Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` to `/tmp/ai-research-skills`.
3. Create my global skills folder (`~/.gemini/config/skills/` for Antigravity OR `~/.claude/skills/` for Claude).
4. Copy the folders `ml-paper-writing`, `academic-plotting` and the entire `22-agent-native-research-artifact` directory from `/tmp/ai-research-skills` to my local skills folder. Rename the subfolders from `22-*` to `ara-compiler`, `ara-research-manager`, and `ara-rigor-reviewer`.
5. Clone `https://github.com/google/antigravity-awesome-skills.git` to `/tmp/awesome-skills`.
6. Copy the following specific skills from the Google repository to my local skills folder: `papers-skill`, `deep-research`, `exa-search`, `tavily-web`, `research-brainstorming`, `creative-thinking`, `data-engineering-data-pipeline`, `data-engineering-data-driven-feature`, `data-structure-protocol`, `dbt-transformation-patterns`, `data-quality-frameworks`, `database-architect`, `database-optimizer`, `polars`, `data-scientist`, `data-storytelling`, `plotly`, `python-pro`, `python-patterns`, `ml-engineer`, `ai-ml`, `ai-engineering-toolkit`, `rag-engineer`, `embedding-strategies`, `hugging-face-datasets`, `hugging-face-community-evals`, `ml-pipeline-workflow`, `mlops-engineer`, `docker-expert`, `devops-deploy`, `unit-testing-test-generate`, `2slides-ppt-generator`, `latex-paper-conversion`, `architecture-decision-records`, `docs-architect`, `graphify`, `save-session`, `resume-session`.
7. Once finished, delete the `/tmp/ai-research-skills` and `/tmp/awesome-skills` directories and confirm that the ecosystem is ready.
```

*(Note: For the Full Pack, modify Phase 2 Step 6 to copy all skills instead of the specific list).*

---

## 💻 Method 2: Manual Terminal Installation (Bash)

If you prefer to maintain full control or integrate the setup into your own dotfiles, run the following bash commands directly in your terminal.

### Phase 1: The Persistent Memory Engine (Universal)

Run this block to create the Obsidian Vault architecture (this is identical regardless of which AI Agent you use):

```bash
# 1. Create the Obsidian Vault and its Zettelkasten structure
mkdir -p ~/Documents/AntigravityBrain/{raw/assets,wiki/{entities,concepts,synthesis},graphify,logs}

# 2. Download the central catalog templates
curl -sL https://raw.githubusercontent.com/jpmsilva1/ai-research-ecosystem/main/obsidian-vault-template/wiki/index.md -o ~/Documents/AntigravityBrain/wiki/index.md
curl -sL https://raw.githubusercontent.com/jpmsilva1/ai-research-ecosystem/main/obsidian-vault-template/wiki/changelog.md -o ~/Documents/AntigravityBrain/wiki/changelog.md
```

**Next, configure your specific agent so it knows where the Vault is:**

**For Google Antigravity Users:**
```bash
mkdir -p ~/.gemini/config
curl -sL https://raw.githubusercontent.com/jpmsilva1/ai-research-ecosystem/main/agents/antigravity/AGENTS.md -o ~/.gemini/config/AGENTS.md
sed -i.bak "s|{{VAULT_PATH}}|$HOME/Documents/AntigravityBrain|g" ~/.gemini/config/AGENTS.md && rm ~/.gemini/config/AGENTS.md.bak
```

**For Claude Code Users:**
```bash
mkdir -p ~/.claude
curl -sL https://raw.githubusercontent.com/jpmsilva1/ai-research-ecosystem/main/agents/claude/.cursorrules -o ~/.claude/.cursorrules
sed -i.bak "s|{{VAULT_PATH}}|$HOME/Documents/AntigravityBrain|g" ~/.claude/.cursorrules && rm ~/.claude/.cursorrules.bak
```

### Phase 2: The Skill Ecosystem

Now that the Memory Engine is ready, install the behavioral skills.

**For Google Antigravity Users (Core Pack):**
```bash
# 1. Install Ponytail Plugin
agy plugin install https://github.com/DietrichGebert/ponytail

# 2. Clone Repositories to Temp
git clone https://github.com/Orchestra-Research/AI-Research-SKILLs.git /tmp/ai-research-skills
git clone https://github.com/google/antigravity-awesome-skills.git /tmp/awesome-skills

# 3. Create Skills Directory
mkdir -p ~/.gemini/config/skills

# 4. Copy Orchestra Academic & ARA Skills
cp -r /tmp/ai-research-skills/20-ml-paper-writing/ml-paper-writing ~/.gemini/config/skills/
cp -r /tmp/ai-research-skills/20-ml-paper-writing/academic-plotting ~/.gemini/config/skills/
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/compiler ~/.gemini/config/skills/ara-compiler
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/manager ~/.gemini/config/skills/ara-research-manager
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/reviewer ~/.gemini/config/skills/ara-rigor-reviewer

# 5. Copy Google Awesome Skills
for skill in papers-skill deep-research exa-search tavily-web research-brainstorming creative-thinking data-engineering-data-pipeline data-engineering-data-driven-feature data-structure-protocol dbt-transformation-patterns data-quality-frameworks database-architect database-optimizer polars data-scientist data-storytelling plotly python-pro python-patterns ml-engineer ai-ml ai-engineering-toolkit rag-engineer embedding-strategies hugging-face-datasets hugging-face-community-evals ml-pipeline-workflow mlops-engineer docker-expert devops-deploy unit-testing-test-generate 2slides-ppt-generator latex-paper-conversion architecture-decision-records docs-architect graphify save-session resume-session; do
    cp -r /tmp/awesome-skills/skills/$skill ~/.gemini/config/skills/
done

# 6. Cleanup
rm -rf /tmp/ai-research-skills /tmp/awesome-skills
echo "Antigravity Core Pack Installation Complete!"
```

**For Claude Code Users (Core Pack):**
```bash
# 1. Clone Repositories to Temp
git clone https://github.com/DietrichGebert/ponytail /tmp/ponytail-plugin
git clone https://github.com/Orchestra-Research/AI-Research-SKILLs.git /tmp/ai-research-skills

# 2. Create Claude Skills Directory
mkdir -p ~/.claude/skills

# 3. Copy Academic Tools & Ponytail
cp -r /tmp/ponytail-plugin ~/.claude/skills/ponytail
cp -r /tmp/ai-research-skills/20-ml-paper-writing/ml-paper-writing ~/.claude/skills/
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/compiler ~/.claude/skills/ara-compiler
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/manager ~/.claude/skills/ara-research-manager
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/reviewer ~/.claude/skills/ara-rigor-reviewer

# 4. Cleanup
rm -rf /tmp/ponytail-plugin /tmp/ai-research-skills
echo "Claude Code Setup Complete!"
```
