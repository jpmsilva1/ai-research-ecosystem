# Installation Guide

The AI Research Ecosystem operates on a **Three-Pillar Architecture**:
1. **Phase 1: The Network Compression Layer** (Headroom Proxy for token savings).
2. **Phase 2: The Persistent Memory Engine** (An Obsidian Vault structured as a Zettelkasten).
3. **Phase 3: The Skill Ecosystem** (The actual agent tools and capabilities).

You can install the ecosystem using two different approaches: **Autonomous Prompt-Based Installation** (letting the AI install itself) or **Manual Terminal Installation** (running bash commands yourself).

Choose your desired track and follow the instructions below in order.

---

## 🤖 Method 1: Autonomous Prompt-Based Installation

Instead of executing scripts manually, you can instruct your preferred AI agent to build the architecture autonomously. Copy the entire prompt block and paste it into your terminal chat.

### Phase 1, 2 & 3: Complete Setup Prompt (Core Pack)
Copy and paste this exact prompt into your Agent (Antigravity or Claude Code):

```text
Act as a System Setup Engineer.
Please install my academic research ecosystem by executing the following autonomous steps in order:

PHASE 1: NETWORK COMPRESSION LAYER
1. Ask me if I want to install the Headroom compression layer (optional but recommended). Skip this phase entirely if I am using Google Antigravity, as it bypasses local proxies.
2. If yes, run `pip install "headroom-ai[all]"` and set `export HEADROOM_OUTPUT_SHAPER=1` in my shell rc file. Remind me to run `headroom proxy --port 8787` in a separate terminal.

PHASE 2: PERSISTENT MEMORY ENGINE
1. Create the Obsidian Vault directory structure: `mkdir -p ~/Documents/AntigravityBrain/{raw/assets,wiki/{entities,concepts,synthesis},graphify,logs}`
2. Download the catalog templates directly into the Vault:
   - `curl -sL https://raw.githubusercontent.com/jpmsilva1/ai-research-ecosystem/main/obsidian-vault-template/wiki/index.md -o ~/Documents/AntigravityBrain/wiki/index.md`
   - `curl -sL https://raw.githubusercontent.com/jpmsilva1/ai-research-ecosystem/main/obsidian-vault-template/wiki/changelog.md -o ~/Documents/AntigravityBrain/wiki/changelog.md`
3. Configure my Agent:
   - If I am using Antigravity: Create `~/.gemini/config/AGENTS.md` and instruct it that the Vault path is `~/Documents/AntigravityBrain`.
   - If I am using Claude Code: Create `~/.claude/.cursorrules` and instruct it that the Vault path is `~/Documents/AntigravityBrain`.

PHASE 3: SKILL ECOSYSTEM (Core Pack)
1. Clone `https://github.com/DietrichGebert/ponytail` to `/tmp/ponytail-plugin`.
2. Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` to `/tmp/ai-research-skills`.
3. Clone `https://github.com/Champbreed/AegisOps-AI.git` to `/tmp/aegisops-ai`.
4. Create my global skills folder (`~/.gemini/config/skills/` for Antigravity OR `~/.claude/skills/` for Claude).
5. Copy the `skills/` directory from the cloned ai-research-ecosystem repository to my local skills folder to install the native proprietary skills.
6. Copy the folders `ml-paper-writing`, `academic-plotting` and the entire `22-agent-native-research-artifact` directory from `/tmp/ai-research-skills` to my local skills folder. Rename the subfolders from `22-*` to `ara-compiler`, `ara-research-manager`, and `ara-rigor-reviewer`.
7. Copy `/tmp/ponytail-plugin` to my local skills folder as `ponytail`.
8. Copy `/tmp/aegisops-ai` to my local skills folder as `aegisops-ai`.
9. Clone `https://github.com/google/antigravity-awesome-skills.git` to `/tmp/awesome-skills`.
10. Copy the following specific skills from the Google repository to my local skills folder: `papers-skill`, `deep-research`, `exa-search`, `tavily-web`, `research-brainstorming`, `creative-thinking`, `data-engineering-data-pipeline`, `data-engineering-data-driven-feature`, `data-structure-protocol`, `data-quality-frameworks`, `polars`, `data-scientist`, `data-storytelling`, `plotly`, `ml-engineer`, `ai-ml`, `ai-engineering-toolkit`, `rag-engineer`, `embedding-strategies`, `ml-pipeline-workflow`, `mlops-engineer`, `docker-expert`, `devops-deploy`, `unit-testing-test-generate`, `2slides-ppt-generator`, `latex-paper-conversion`, `architecture-decision-records`, `docs-architect`, `graphify`, `save-session`, `resume-session`.
11. Once finished, delete the `/tmp/ai-research-skills`, `/tmp/awesome-skills`, `/tmp/ponytail-plugin`, and `/tmp/aegisops-ai` directories and confirm that the ecosystem is ready.
```

*(Note: For the Full Pack, modify Phase 3 Step 6 to copy all skills instead of the specific list).*

---

## 💻 Method 2: Manual Terminal Installation (Bash)

If you prefer to maintain full control or integrate the setup into your own dotfiles, run the following bash commands directly in your terminal.

### Phase 1: The Network Compression Layer (Optional but Recommended)

Headroom transparently compresses your agent's API requests by 47-92%.

```bash
# 1. Install Headroom
pip install "headroom-ai[all]"

# 2. Enable output shaping (reduces model verbosity)
export HEADROOM_OUTPUT_SHAPER=1
echo 'export HEADROOM_OUTPUT_SHAPER=1' >> ~/.zshrc

# 3. Verify setup
headroom doctor

# Important: Before starting your agent, you must run the proxy in a separate terminal:
# headroom proxy --port 8787
```

### Phase 2: The Persistent Memory Engine (Universal)

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

### Phase 3: The Skill Ecosystem

Now that the Memory Engine is ready, install the behavioral skills.

**For Google Antigravity Users (Core Pack):**
```bash
# 1. Clone Repositories to Temp
git clone https://github.com/DietrichGebert/ponytail /tmp/ponytail-plugin
git clone https://github.com/Orchestra-Research/AI-Research-SKILLs.git /tmp/ai-research-skills
git clone https://github.com/google/antigravity-awesome-skills.git /tmp/awesome-skills
git clone https://github.com/Champbreed/AegisOps-AI.git /tmp/aegisops-ai

# 2. Create Skills Directory
mkdir -p ~/.gemini/config/skills

# 3. Copy Native Proprietary Skills
cp -r skills/* ~/.gemini/config/skills/

# 4. Copy Ponytail & AegisOps-AI
cp -r /tmp/ponytail-plugin ~/.gemini/config/skills/ponytail
cp -r /tmp/aegisops-ai ~/.gemini/config/skills/aegisops-ai

# 5. Copy Orchestra Academic & ARA Skills
cp -r /tmp/ai-research-skills/20-ml-paper-writing/ml-paper-writing ~/.gemini/config/skills/
cp -r /tmp/ai-research-skills/20-ml-paper-writing/academic-plotting ~/.gemini/config/skills/
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/compiler ~/.gemini/config/skills/ara-compiler
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/manager ~/.gemini/config/skills/ara-research-manager
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/reviewer ~/.gemini/config/skills/ara-rigor-reviewer

# 6. Copy Google Awesome Skills
for skill in papers-skill deep-research exa-search tavily-web research-brainstorming creative-thinking data-engineering-data-pipeline data-engineering-data-driven-feature data-structure-protocol data-quality-frameworks polars data-scientist data-storytelling plotly ml-engineer ai-ml ai-engineering-toolkit rag-engineer embedding-strategies ml-pipeline-workflow mlops-engineer docker-expert devops-deploy unit-testing-test-generate 2slides-ppt-generator latex-paper-conversion architecture-decision-records docs-architect graphify save-session resume-session; do
    cp -r /tmp/awesome-skills/skills/$skill ~/.gemini/config/skills/
done

# 7. Cleanup
rm -rf /tmp/ai-research-skills /tmp/awesome-skills /tmp/ponytail-plugin /tmp/aegisops-ai
echo "Antigravity Core Pack Installation Complete!"
```

**For Claude Code Users (Core Pack):**
```bash
# 1. Clone Repositories to Temp
git clone https://github.com/DietrichGebert/ponytail /tmp/ponytail-plugin
git clone https://github.com/Orchestra-Research/AI-Research-SKILLs.git /tmp/ai-research-skills
git clone https://github.com/Champbreed/AegisOps-AI.git /tmp/aegisops-ai

# 2. Create Claude Skills Directory
mkdir -p ~/.claude/skills

# 3. Copy Native Proprietary Skills
cp -r skills/* ~/.claude/skills/

# 4. Copy Academic Tools, Ponytail & AegisOps-AI
cp -r /tmp/ponytail-plugin ~/.claude/skills/ponytail
cp -r /tmp/aegisops-ai ~/.claude/skills/aegisops-ai
cp -r /tmp/ai-research-skills/20-ml-paper-writing/ml-paper-writing ~/.claude/skills/
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/compiler ~/.claude/skills/ara-compiler
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/manager ~/.claude/skills/ara-research-manager
cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/reviewer ~/.claude/skills/ara-rigor-reviewer

# 5. Cleanup
rm -rf /tmp/ponytail-plugin /tmp/ai-research-skills /tmp/aegisops-ai
echo "Claude Code Setup Complete!"
```
