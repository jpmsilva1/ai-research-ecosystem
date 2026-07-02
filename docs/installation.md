# Installation Guide

You can install the AI Research Workflow ecosystem using two different approaches: **Autonomous Prompt-Based Installation** (letting the AI install itself) or **Manual Terminal Installation** (running bash commands yourself).

Choose your desired track (Core Pack or Full Pack) and follow the instructions below.

---

## 🤖 Method 1: Autonomous Prompt-Based Installation

Instead of executing scripts manually, you can instruct your preferred AI agent to install the workflow autonomously. Copy the entire prompt block and paste it into your terminal chat.

### Option A: Core Pack (Academic Research)
Copy and paste this exact prompt into Antigravity:

```text
Act as a System Setup Engineer.
Please install my academic research ecosystem by executing the following autonomous steps:

1. Install the ponytail plugin by running: `agy plugin install https://github.com/DietrichGebert/ponytail`
2. Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` to `/tmp/ai-research-skills`.
3. Create the folder `~/.gemini/config/skills/` if it does not exist.
4. Copy the folders `ml-paper-writing`, `academic-plotting` and the entire `22-agent-native-research-artifact` directory to my local skills folder. Rename the subfolders from `22-*` to `ara-compiler`, `ara-research-manager`, and `ara-rigor-reviewer`.
5. Clone `https://github.com/google/antigravity-awesome-skills.git` to `/tmp/awesome-skills`.
6. Copy the following specific skills from the Google repository to my local skills folder: `papers-skill`, `deep-research`, `exa-search`, `tavily-web`, `research-brainstorming`, `creative-thinking`, `data-engineering-data-pipeline`, `data-engineering-data-driven-feature`, `data-structure-protocol`, `dbt-transformation-patterns`, `data-quality-frameworks`, `database-architect`, `database-optimizer`, `polars`, `data-scientist`, `data-storytelling`, `plotly`, `python-pro`, `python-patterns`, `ml-engineer`, `ai-ml`, `ai-engineering-toolkit`, `rag-engineer`, `embedding-strategies`, `hugging-face-datasets`, `hugging-face-community-evals`, `ml-pipeline-workflow`, `mlops-engineer`, `docker-expert`, `devops-deploy`, `unit-testing-test-generate`, `2slides-ppt-generator`, `latex-paper-conversion`, `architecture-decision-records`, `docs-architect`, `graphify`, `save-session`, `resume-session`.
7. Once finished, delete the `/tmp/ai-research-skills` and `/tmp/awesome-skills` directories and confirm that the ecosystem is ready.
```

### Option B: Full Pack (Enterprise Engineering)
Copy and paste this exact prompt into Antigravity:

```text
Act as a System Setup Engineer. 
Please install the complete Awesome Skills catalog into my environment autonomously:

1. Install the ponytail plugin by running: `agy plugin install https://github.com/DietrichGebert/ponytail`
2. Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` to `/tmp/ai-research-skills`.
3. Copy ALL skills from inside the Orchestra Research subfolders to my `~/.gemini/config/skills/` folder.
4. Clone `https://github.com/google/antigravity-awesome-skills.git` to `/tmp/awesome-skills`.
5. Copy the entire contents of the `skills/` folder from the cloned Google repository into my `~/.gemini/config/skills/`.
6. Once finished, clean the `/tmp/` folder and confirm the end of the operation.
```

---

## 💻 Method 2: Manual Terminal Installation (Bash)

If you prefer to maintain full control or integrate the setup into your own dotfiles, run the following bash commands directly in your terminal.

### Option A: Core Pack (Academic Research)
Run this block to install the ~38 skills curated specifically for the Academic Lifecycle:

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
echo "Core Pack Installation Complete!"
```

### Option B: Full Pack (Enterprise Engineering)
Run this block to install the complete catalog of 130+ engineering skills:

```bash
# 1. Install Ponytail Plugin
agy plugin install https://github.com/DietrichGebert/ponytail

# 2. Clone Repositories to Temp
git clone https://github.com/Orchestra-Research/AI-Research-SKILLs.git /tmp/ai-research-skills
git clone https://github.com/google/antigravity-awesome-skills.git /tmp/awesome-skills

# 3. Create Skills Directory
mkdir -p ~/.gemini/config/skills

# 4. Copy All Skills
cp -r /tmp/ai-research-skills/*/* ~/.gemini/config/skills/
cp -r /tmp/awesome-skills/skills/* ~/.gemini/config/skills/

# 5. Cleanup
rm -rf /tmp/ai-research-skills /tmp/awesome-skills
echo "Full Pack Installation Complete!"
```

---

## Claude Code CLI Support

If you use Anthropic's official **Claude Code CLI** instead of Antigravity, use this prompt to instruct Claude to adapt the environment:

```text
You are my Claude Code assistant. I need you to configure our academic research environment by installing a specific set of skills and rules.

Step 1: Find your global configuration/skills directory (usually Claude CLI has a config folder where it supports custom scripts). Create this folder if necessary.
Step 2: Temporarily clone the repository: `git clone https://github.com/DietrichGebert/ponytail /tmp/ponytail-plugin` and implement the Ponytail rules into your global system prompt (avoiding over-engineering).
Step 3: Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` to `/tmp/ai-research-skills` and move the academic tools (`ml-paper-writing`, `ARA` ecosystem) to our environment.
Step 4: Clean the `/tmp/` folder.
Step 5: Read the README files we just downloaded to understand the taxonomy of "Agent-Native Research Artifacts".
Confirm when you are finished.
```
