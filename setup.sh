#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# AI Research Workflow - Interactive Setup Script
# Version: 4.0.0
# ============================================================

BOLD="\033[1m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
RESET="\033[0m"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BOLD}${CYAN}"
echo "================================================="
echo "  AI-Powered Research Assistant - Setup v4.0.0  "
echo "================================================="
echo -e "${RESET}"

# --- Step 1: Agent Selection ---
echo -e "${BOLD}Step 1: Which AI agent do you use?${RESET}"
echo "  [1] Google Antigravity"
echo "  [2] Claude Code (Anthropic)"
echo "  [3] Both"
read -rp "Select (1/2/3): " AGENT_CHOICE

# --- Step 2: Pack Selection ---
echo ""
echo -e "${BOLD}Step 2: Which skill pack do you want to install?${RESET}"
echo "  [1] Core Pack (Academic Research - ~38 skills)"
echo "  [2] Full Pack (Enterprise Engineering - 130+ skills)"
read -rp "Select (1/2): " PACK_CHOICE

# --- Step 3: Vault Location ---
echo ""
DEFAULT_VAULT="$HOME/Documents/AntigravityBrain"
echo -e "${BOLD}Step 3: Where should the Obsidian vault be created?${RESET}"
read -rp "Path (default: $DEFAULT_VAULT): " VAULT_PATH
VAULT_PATH="${VAULT_PATH:-$DEFAULT_VAULT}"

# --- Step 4: Headroom Token Compression ---
echo ""
echo -e "${BOLD}Step 4: Install Headroom token compression layer?${RESET}"
echo "  Headroom compresses your prompts and tool outputs to save 47-92% tokens."
echo "  It runs as a local transparent proxy on port 8787."
read -rp "Install? (y/n) [Recommended: y]: " HEADROOM_CHOICE
HEADROOM_CHOICE="${HEADROOM_CHOICE:-y}"

# --- Create Vault Structure ---
echo ""
echo -e "${CYAN}Creating vault structure at: $VAULT_PATH${RESET}"
mkdir -p "$VAULT_PATH"/{raw/assets,wiki/{entities,concepts,synthesis},graphify,logs}

# Copy templates if they don't already exist
if [ ! -f "$VAULT_PATH/wiki/index.md" ]; then
    cp "$SCRIPT_DIR/obsidian-vault-template/wiki/index.md" "$VAULT_PATH/wiki/index.md"
    echo "  Created wiki/index.md"
fi
if [ ! -f "$VAULT_PATH/wiki/changelog.md" ]; then
    cp "$SCRIPT_DIR/obsidian-vault-template/wiki/changelog.md" "$VAULT_PATH/wiki/changelog.md"
    echo "  Created wiki/changelog.md"
fi

# --- Install Agent Configuration ---
echo ""
echo -e "${CYAN}Installing agent configuration...${RESET}"

if [[ "$AGENT_CHOICE" == "1" || "$AGENT_CHOICE" == "3" ]]; then
    ANTIGRAVITY_CONFIG="$HOME/.gemini/config"
    mkdir -p "$ANTIGRAVITY_CONFIG"
    # Write AGENTS.md with the user's vault path
    sed "s|{{VAULT_PATH}}|$VAULT_PATH|g" \
        "$SCRIPT_DIR/agents/antigravity/AGENTS.md" > "$ANTIGRAVITY_CONFIG/AGENTS.md"
    echo "  Installed AGENTS.md to $ANTIGRAVITY_CONFIG/"
fi

if [[ "$AGENT_CHOICE" == "2" || "$AGENT_CHOICE" == "3" ]]; then
    CLAUDE_CONFIG="$HOME/.claude"
    mkdir -p "$CLAUDE_CONFIG"
    sed "s|{{VAULT_PATH}}|$VAULT_PATH|g" \
        "$SCRIPT_DIR/agents/claude/.cursorrules" > "$CLAUDE_CONFIG/.cursorrules"
    echo "  Installed .cursorrules to $CLAUDE_CONFIG/"
fi

# --- Install Skills ---
echo ""
echo -e "${CYAN}Installing skills...${RESET}"

# Cleanup temp before cloning
rm -rf /tmp/ponytail-plugin /tmp/ai-research-skills /tmp/awesome-skills /tmp/aegisops-ai 2>/dev/null || true

# Clone repos to temp
git clone --quiet https://github.com/DietrichGebert/ponytail /tmp/ponytail-plugin 2>/dev/null || true
git clone --quiet https://github.com/Orchestra-Research/AI-Research-SKILLs.git /tmp/ai-research-skills 2>/dev/null || true
git clone --quiet https://github.com/google/antigravity-awesome-skills.git /tmp/awesome-skills 2>/dev/null || true
git clone --quiet https://github.com/Champbreed/AegisOps-AI.git /tmp/aegisops-ai 2>/dev/null || true

if [[ "$AGENT_CHOICE" == "1" || "$AGENT_CHOICE" == "3" ]]; then
    SKILLS_DIR="$HOME/.gemini/config/skills"
    mkdir -p "$SKILLS_DIR"

    # Copy repo-bundled skills
    if [ -d "$SCRIPT_DIR/skills" ]; then
        cp -r "$SCRIPT_DIR/skills/"* "$SKILLS_DIR/" 2>/dev/null || true
        echo "  Installed bundled skills (lint-vault, research-orchestrator, distributed-gpu-engineer, academic-rebuttal-simulator, experiment-sweeper)"
    fi

    # Ponytail
    [ -d /tmp/ponytail-plugin ] && cp -r /tmp/ponytail-plugin "$SKILLS_DIR/ponytail" 2>/dev/null || true

    # AegisOps-AI Gatekeeper
    [ -d /tmp/aegisops-ai ] && cp -r /tmp/aegisops-ai "$SKILLS_DIR/aegisops-ai" 2>/dev/null || true

    # Orchestra ARA
    [ -d /tmp/ai-research-skills ] && {
        cp -r /tmp/ai-research-skills/20-ml-paper-writing/ml-paper-writing "$SKILLS_DIR/" 2>/dev/null || true
        cp -r /tmp/ai-research-skills/20-ml-paper-writing/academic-plotting "$SKILLS_DIR/" 2>/dev/null || true
        cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/compiler "$SKILLS_DIR/ara-compiler" 2>/dev/null || true
        cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/manager "$SKILLS_DIR/ara-research-manager" 2>/dev/null || true
        cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/reviewer "$SKILLS_DIR/ara-rigor-reviewer" 2>/dev/null || true
    }

    if [[ "$PACK_CHOICE" == "1" ]]; then
        # Core Pack
        CORE_SKILLS=(papers-skill deep-research exa-search tavily-web research-brainstorming creative-thinking data-engineering-data-pipeline data-engineering-data-driven-feature data-structure-protocol data-quality-frameworks polars data-scientist data-storytelling plotly ml-engineer ai-ml ai-engineering-toolkit rag-engineer embedding-strategies ml-pipeline-workflow mlops-engineer docker-expert devops-deploy unit-testing-test-generate 2slides-ppt-generator latex-paper-conversion architecture-decision-records docs-architect graphify save-session resume-session)
        for skill in "${CORE_SKILLS[@]}"; do
            [ -d "/tmp/awesome-skills/skills/$skill" ] && cp -r "/tmp/awesome-skills/skills/$skill" "$SKILLS_DIR/" 2>/dev/null || true
        done
        echo "  Installed Core Pack (~38 skills)"
    else
        # Full Pack
        [ -d /tmp/awesome-skills/skills ] && cp -r /tmp/awesome-skills/skills/* "$SKILLS_DIR/" 2>/dev/null || true
        echo "  Installed Full Pack (130+ skills)"
    fi
fi

if [[ "$AGENT_CHOICE" == "2" || "$AGENT_CHOICE" == "3" ]]; then
    CLAUDE_SKILLS="$HOME/.claude/skills"
    mkdir -p "$CLAUDE_SKILLS"

    [ -d /tmp/ponytail-plugin ] && cp -r /tmp/ponytail-plugin "$CLAUDE_SKILLS/ponytail" 2>/dev/null || true
    [ -d /tmp/aegisops-ai ] && cp -r /tmp/aegisops-ai "$CLAUDE_SKILLS/aegisops-ai" 2>/dev/null || true
    [ -d /tmp/ai-research-skills ] && {
        cp -r /tmp/ai-research-skills/20-ml-paper-writing/ml-paper-writing "$CLAUDE_SKILLS/" 2>/dev/null || true
        cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/compiler "$CLAUDE_SKILLS/ara-compiler" 2>/dev/null || true
        cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/manager "$CLAUDE_SKILLS/ara-research-manager" 2>/dev/null || true
        cp -r /tmp/ai-research-skills/22-agent-native-research-artifact/reviewer "$CLAUDE_SKILLS/ara-rigor-reviewer" 2>/dev/null || true
    }
    echo "  Installed Claude Code skills"
fi

# --- Install Headroom ---
if [[ "$HEADROOM_CHOICE" == "y" || "$HEADROOM_CHOICE" == "Y" ]]; then
    echo ""
    echo -e "${CYAN}Installing Headroom Token Compression Layer...${RESET}"
    if command -v pip &> /dev/null; then
        pip install "headroom-ai[all]" --quiet
        
        # Enable output shaping for the user
        SHELL_RC="$HOME/.bashrc"
        [ -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.zshrc"
        if ! grep -q "HEADROOM_OUTPUT_SHAPER" "$SHELL_RC" 2>/dev/null; then
            echo 'export HEADROOM_OUTPUT_SHAPER=1' >> "$SHELL_RC"
        fi
        
        echo "  Headroom installed successfully."
        echo "  Output shaper enabled in $SHELL_RC."
    else
        echo -e "\033[0;31mWarning: 'pip' not found. Please install Python 3.10+ and run 'pip install \"headroom-ai[all]\"' manually.\033[0m"
    fi
fi

# --- Cleanup ---
rm -rf /tmp/ponytail-plugin /tmp/ai-research-skills /tmp/awesome-skills /tmp/aegisops-ai

# --- Done ---
echo ""
echo -e "${BOLD}${GREEN}=================================================${RESET}"
echo -e "${BOLD}${GREEN}  Setup Complete!${RESET}"
echo -e "${BOLD}${GREEN}=================================================${RESET}"
echo ""
echo -e "Next steps:"
if [[ "$HEADROOM_CHOICE" == "y" || "$HEADROOM_CHOICE" == "Y" ]]; then
    echo -e "  0. Start your token compressor: ${CYAN}headroom proxy --port 8787${RESET} (in a separate terminal)"
fi
echo -e "  1. Open Obsidian and point it at: ${CYAN}$VAULT_PATH${RESET}"
if [[ "$HEADROOM_CHOICE" == "y" || "$HEADROOM_CHOICE" == "Y" ]]; then
    echo -e "  2. Start your agent (configure API base URL to ${CYAN}http://localhost:8787${RESET}) and type: ${CYAN}/resume${RESET}"
else
    echo -e "  2. Start your agent and type: ${CYAN}/resume${RESET}"
fi
echo -e "  3. Or start a new research workflow with: ${CYAN}/research${RESET}"
echo ""
