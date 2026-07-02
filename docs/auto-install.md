# Automated Setup (Prompt-Based Installation)

Instead of downloading repositories and copying files manually, you can instruct your preferred AI agent to install the workflow autonomously. Choose your AI (Antigravity or Claude Code) and your desired track (Core Pack or Full Pack), copy the entire prompt block, and paste it into your terminal chat.

---

## Google Antigravity

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

## Claude Code CLI

If you use Anthropic's official **Claude Code CLI**, use this prompt:

```text
You are my Claude Code assistant. I need you to configure our academic research environment by installing a specific set of skills and rules.

Step 1: Find your global configuration/skills directory (usually Claude CLI has a config folder where it supports custom scripts). Create this folder if necessary.
Step 2: Temporarily clone the repository: `git clone https://github.com/DietrichGebert/ponytail /tmp/ponytail-plugin` and implement the Ponytail rules into your global system prompt (avoiding over-engineering).
Step 3: Clone `https://github.com/Orchestra-Research/AI-Research-SKILLs.git` to `/tmp/ai-research-skills` and move the academic tools (`ml-paper-writing`, `ARA` ecosystem) to our environment.
Step 4: Clean the `/tmp/` folder.
Step 5: Read the README files we just downloaded to understand the taxonomy of "Agent-Native Research Artifacts".
Confirm when you are finished.
```
