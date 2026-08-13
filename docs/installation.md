# Installation Guide

Installation proceeds in four phases:
0. **Phase 0: The Execution Compression Layer** (RTK for shell-output savings).
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

PHASE 0: EXECUTION COMPRESSION LAYER
1. Install RTK via Homebrew (`brew install rtk`) or curl fallback.
2. Initialize it for the user's agent (e.g., `rtk init --agent antigravity`).

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
10. Copy the following specific skills from the Google repository to my local skills folder (this is the Core Pack; `save-session` and `resume-session` are NOT part of it -- they were already installed from this repo's own `skills/` directory in step 5, do not overwrite them): `papers-skill`, `deep-research`, `exa-search`, `tavily-web`, `research-brainstorming`, `creative-thinking`, `data-engineering-data-pipeline`, `data-engineering-data-driven-feature`, `data-structure-protocol`, `data-quality-frameworks`, `polars`, `data-scientist`, `data-storytelling`, `plotly`, `ml-engineer`, `ai-ml`, `ai-engineering-toolkit`, `rag-engineer`, `embedding-strategies`, `ml-pipeline-workflow`, `mlops-engineer`, `docker-expert`, `devops-deploy`, `unit-testing-test-generate`, `2slides-ppt-generator`, `latex-paper-conversion`, `architecture-decision-records`, `docs-architect`, `graphify`, `pytorch-patterns`, `scientific-thinking-literature-review`, `scientific-thinking-scholar-evaluation`, `mle-workflow`, `eval-harness`, `ai-regression-testing`.
11. Once finished, delete the `/tmp/ai-research-skills`, `/tmp/awesome-skills`, `/tmp/ponytail-plugin`, and `/tmp/aegisops-ai` directories and confirm that the ecosystem is ready.
```

*(Note: For the Full Pack, modify Phase 3 Step 6 to copy all skills instead of the specific list).*

---

## 💻 Method 2: Manual Terminal Installation (Bash)

If you prefer to maintain full control or integrate the setup into your own dotfiles, run the following bash commands directly in your terminal.

### Phase 0: The Execution Compression Layer (RTK)

RTK cuts CLI output tokens by 60-90% before the agent reads them.

```bash
# 1. Install RTK
brew install rtk

# 2. Initialize for your agent
rtk init --agent antigravity  # Or: rtk init -g (for Claude)
```

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

This step has enough moving parts (four upstream repos, path renames, per-target skill lists) that
hand-copying it into a doc has drifted out of sync with the real installer more than once. Rather
than duplicate that logic here again, run the installer itself for this phase. It is idempotent, so
if you already did Phases 0-2 manually above, re-running it now only fills in the skills step:

```bash
./setup.sh   # or .\setup.ps1 on Windows
```

If you specifically want to inspect or copy the skill-installation commands themselves, read
`install_skills()` and `install_pack()`/`CORE_SKILLS` in [`setup.sh`](../setup.sh) (or the
equivalent `Install-Skills`/`Install-Pack`/`$CoreSkills` in [`setup.ps1`](../setup.ps1)) -- that
script is the source of truth this guide is generated against, so copying from it directly can't
drift the way a second hand-written copy would.
