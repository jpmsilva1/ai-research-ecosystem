#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# AI Research Ecosystem - Interactive Setup Script
# Version: 5.1.0
# ============================================================

BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
RESET="\033[0m"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Skills pulled from google/antigravity-awesome-skills for the Core Pack.
# This array is the single source of truth for the Core Pack contents; the
# documentation is written to match it, not the other way around.
CORE_SKILLS=(
    papers-skill deep-research exa-search tavily-web research-brainstorming
    creative-thinking data-engineering-data-pipeline
    data-engineering-data-driven-feature data-structure-protocol
    data-quality-frameworks polars data-scientist data-storytelling plotly
    ml-engineer ai-ml ai-engineering-toolkit rag-engineer embedding-strategies
    ml-pipeline-workflow mlops-engineer docker-expert devops-deploy
    unit-testing-test-generate 2slides-ppt-generator latex-paper-conversion
    architecture-decision-records docs-architect graphify pytorch-patterns
    scientific-thinking-literature-review scientific-thinking-scholar-evaluation
    mle-workflow eval-harness ai-regression-testing
)

# Bundled skills shipped in this repo (skills/), counted for the menu blurb.
BUNDLED_COUNT=$(find "$SCRIPT_DIR/skills" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
# Core Pack total = upstream skills + bundled skills + the 7 fixed extras
# (ponytail, aegisops-ai, ml-paper-writing, academic-plotting, and the 3 ARA skills).
CORE_TOTAL=$(( ${#CORE_SKILLS[@]} + BUNDLED_COUNT + 7 ))

# --- Spinner (cosmetic only; callers must still `wait` for the real status) ---
spin() {
    local pid=$1
    local delay=0.1
    local spinstr="|/-\\"
    # Skip the animation when stdout is not a terminal, otherwise the frames
    # and backspaces pollute captured output in CI and test harnesses.
    [ -t 1 ] || return 0
    while kill -0 "$pid" 2>/dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep "$delay"
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# --- Prompt helpers ---
# `read` returns non-zero at EOF, which under `set -e` would abort the script
# with no message on any non-interactive run. Tolerate it and fall back.
ask() {
    local prompt=$1 default=${2:-} reply=""
    printf '%s' "$prompt" >&2
    read -r reply || reply=""
    printf '%s' "${reply:-$default}"
}

# Prompt until the answer matches an extended-regex alternation, e.g. "1|2|3".
ask_choice() {
    local prompt=$1 valid=$2 default=${3:-} reply
    while true; do
        reply=$(ask "$prompt" "$default")
        if [[ "$reply" =~ ^($valid)$ ]]; then
            printf '%s' "$reply"
            return 0
        fi
        printf 'Invalid choice: %s. Expected one of: %s\n' "${reply:-<empty>}" "${valid//|/, }" >&2
        if [ ! -t 0 ]; then
            printf 'Non-interactive input exhausted; aborting.\n' >&2
            exit 1
        fi
    done
}

# Escape characters that are special on the replacement side of `sed s|...|...|`.
sed_escape() {
    printf '%s' "$1" | sed -e 's/[\\&|]/\\&/g'
}

# Copy a directory's *contents* into dest, replacing dest wholesale.
# A plain `cp -r src dest` nests (dest/src/...) when dest already exists,
# which silently corrupted the skill layout on any re-run.
copy_dir() {
    local src=$1 dest=$2
    [ -d "$src" ] || return 1
    rm -rf "$dest"
    mkdir -p "$dest"
    cp -R "$src/." "$dest/"
}

# Substitute the user's vault path into every installed file that references it.
interpolate_vault_path() {
    local root=$1 esc f
    esc=$(sed_escape "$VAULT_PATH")
    while IFS= read -r f; do
        sed -i.bak "s|{{VAULT_PATH}}|$esc|g" "$f" && rm -f "$f.bak"
    done < <(grep -rl '{{VAULT_PATH}}' "$root" 2>/dev/null || true)
}

# Install the full skill set into one target directory.
# Both agents share this; keeping two near-identical copies is what let the
# Claude branch drift and ship un-interpolated, pack-less installs.
install_skills() {
    local target=$1 label=$2
    local bundled=0 extras=0 pack=0 src name
    mkdir -p "$target"

    if [ -d "$SCRIPT_DIR/skills" ]; then
        for src in "$SCRIPT_DIR/skills"/*/; do
            [ -d "$src" ] || continue
            name=$(basename "$src")
            if copy_dir "$src" "$target/$name"; then
                bundled=$((bundled + 1))
            fi
        done
    fi

    copy_dir "$TEMP_DIR/ponytail-plugin" "$target/ponytail" && extras=$((extras + 1)) || true
    copy_dir "$TEMP_DIR/aegisops-ai" "$target/aegisops-ai" && extras=$((extras + 1)) || true

    local ara="$TEMP_DIR/ai-research-skills"
    copy_dir "$ara/20-ml-paper-writing/ml-paper-writing" "$target/ml-paper-writing" && extras=$((extras + 1)) || true
    copy_dir "$ara/20-ml-paper-writing/academic-plotting" "$target/academic-plotting" && extras=$((extras + 1)) || true
    copy_dir "$ara/22-agent-native-research-artifact/compiler" "$target/ara-compiler" && extras=$((extras + 1)) || true
    copy_dir "$ara/22-agent-native-research-artifact/research-manager" "$target/ara-research-manager" && extras=$((extras + 1)) || true
    copy_dir "$ara/22-agent-native-research-artifact/rigor-reviewer" "$target/ara-rigor-reviewer" && extras=$((extras + 1)) || true

    if [[ "$PACK_CHOICE" == "1" ]]; then
        local skill
        for skill in "${CORE_SKILLS[@]}"; do
            copy_dir "$TEMP_DIR/awesome-skills/skills/$skill" "$target/$skill" && pack=$((pack + 1)) || true
        done
    else
        if [ -d "$TEMP_DIR/awesome-skills/skills" ]; then
            for src in "$TEMP_DIR/awesome-skills/skills"/*/; do
                [ -d "$src" ] || continue
                copy_dir "$src" "$target/$(basename "$src")" && pack=$((pack + 1)) || true
            done
        fi
    fi

    interpolate_vault_path "$target"

    local total=$((bundled + extras + pack))
    echo "  $label: installed $total skills ($bundled bundled, $extras companion, $pack pack) -> $target"
    if [[ "$PACK_CHOICE" == "1" && "$pack" -lt "${#CORE_SKILLS[@]}" ]]; then
        echo -e "${YELLOW}    Warning: expected ${#CORE_SKILLS[@]} Core Pack skills but installed $pack.${RESET}"
        echo -e "${YELLOW}    The upstream skills repository may be unavailable. Re-run when online.${RESET}"
    fi
}

if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: 'git' is not installed or not in PATH. Please install git to continue.${RESET}"
    exit 1
fi

echo -e "${BOLD}${CYAN}"
echo "================================================="
echo "  AI-Powered Research Assistant - Setup v5.1.0  "
echo "================================================="
echo -e "${RESET}"

# --- Step 1: Agent Selection ---
echo -e "${BOLD}Step 1: Which AI agent do you use?${RESET}"
echo "  [1] Google Antigravity"
echo "  [2] Claude Code (Anthropic)"
echo "  [3] Both"
AGENT_CHOICE=$(ask_choice "Select (1/2/3): " "1|2|3")

# --- Step 2: Pack Selection ---
echo ""
echo -e "${BOLD}Step 2: Which skill pack do you want to install?${RESET}"
echo "  [1] Core Pack (Academic Research - ${CORE_TOTAL} skills)"
echo "  [2] Full Pack (Enterprise Engineering - 130+ skills)"
PACK_CHOICE=$(ask_choice "Select (1/2): " "1|2")

# --- Step 3: Vault Location ---
echo ""
DEFAULT_VAULT="$HOME/Documents/AntigravityBrain"
echo -e "${BOLD}Step 3: Where should the Obsidian vault be created?${RESET}"
VAULT_PATH=$(ask "Path (default: $DEFAULT_VAULT): " "$DEFAULT_VAULT")
# `read` does not expand tilde, so "~/Documents/Brain" would create a literal "~" dir.
# The quoted tildes below are deliberate: we are matching the literal character
# the user typed, not asking the shell to expand it.
# shellcheck disable=SC2088
case "$VAULT_PATH" in
    "~")   VAULT_PATH="$HOME" ;;
    "~/"*) VAULT_PATH="$HOME/${VAULT_PATH#\~/}" ;;
esac

# --- Step 4: Headroom Token Compression ---
echo ""
echo -e "${BOLD}Step 4: Install Headroom token compression layer?${RESET}"
echo "  Headroom compresses your prompts and tool outputs to save 47-92% tokens."
echo "  It runs as a local transparent proxy on port 8787."
if [[ "$AGENT_CHOICE" == "1" ]]; then
    echo -e "  ${YELLOW}(Warning: Antigravity connects directly to its API and bypasses local proxies. This feature is only effective for Claude Code or Cursor).${RESET}"
elif [[ "$AGENT_CHOICE" == "3" ]]; then
    echo -e "  ${YELLOW}(Note: Proxy compression will only work for Claude Code, as Antigravity bypasses local proxies).${RESET}"
else
    echo -e "  \033[0;90m(Note: Proxy interception natively supports Claude Code and Cursor).${RESET}"
fi
HEADROOM_CHOICE=$(ask_choice "Install? (y/n) [Recommended: y]: " "y|Y|n|N|yes|no" "y")

# --- Step 5: RTK Execution Compression ---
echo ""
echo -e "${BOLD}Step 5: Install RTK (Rust Token Killer) execution compression?${RESET}"
echo "  RTK compresses shell command outputs (git, pytest, pip...) by 60-90%."
echo "  Works with ALL agents, including Google Antigravity."
RTK_CHOICE=$(ask_choice "Install? (y/n) [Recommended: y]: " "y|Y|n|N|yes|no" "y")

# Normalize yes/no answers once so later branches agree on what counts as yes.
[[ "$HEADROOM_CHOICE" =~ ^[yY] ]] && HEADROOM_YES=1 || HEADROOM_YES=0
[[ "$RTK_CHOICE" =~ ^[yY] ]] && RTK_YES=1 || RTK_YES=0

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
VAULT_PATH_ESC=$(sed_escape "$VAULT_PATH")

if [[ "$AGENT_CHOICE" == "1" || "$AGENT_CHOICE" == "3" ]]; then
    ANTIGRAVITY_CONFIG="$HOME/.gemini/config"
    mkdir -p "$ANTIGRAVITY_CONFIG"
    sed "s|{{VAULT_PATH}}|$VAULT_PATH_ESC|g" \
        "$SCRIPT_DIR/agents/antigravity/AGENTS.md" > "$ANTIGRAVITY_CONFIG/AGENTS.md"
    echo "  Installed AGENTS.md to $ANTIGRAVITY_CONFIG/"
fi

if [[ "$AGENT_CHOICE" == "2" || "$AGENT_CHOICE" == "3" ]]; then
    CLAUDE_CONFIG="$HOME/.claude"
    mkdir -p "$CLAUDE_CONFIG"
    sed "s|{{VAULT_PATH}}|$VAULT_PATH_ESC|g" \
        "$SCRIPT_DIR/agents/claude/.cursorrules" > "$CLAUDE_CONFIG/.cursorrules"
    echo "  Installed .cursorrules to $CLAUDE_CONFIG/"
fi

# --- Install Skills ---
echo ""
echo -e "${CYAN}Installing skills...${RESET}"

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Clone repos to temp (disable terminal prompts for private/missing repos)
(
    env GIT_TERMINAL_PROMPT=0 git clone --quiet --depth 1 https://github.com/DietrichGebert/ponytail "$TEMP_DIR/ponytail-plugin" 2>/dev/null || true
    env GIT_TERMINAL_PROMPT=0 git clone --quiet --depth 1 https://github.com/Orchestra-Research/AI-Research-SKILLs.git "$TEMP_DIR/ai-research-skills" 2>/dev/null || true
    env GIT_TERMINAL_PROMPT=0 git clone --quiet --depth 1 https://github.com/google/antigravity-awesome-skills.git "$TEMP_DIR/awesome-skills" 2>/dev/null || true
    env GIT_TERMINAL_PROMPT=0 git clone --quiet --depth 1 https://github.com/Champbreed/AegisOps-AI.git "$TEMP_DIR/aegisops-ai" 2>/dev/null || true
) &
CLONE_PID=$!
spin "$CLONE_PID"
wait "$CLONE_PID" || true

# Report anything that failed to fetch, rather than silently installing less.
for repo in ponytail-plugin ai-research-skills awesome-skills aegisops-ai; do
    [ -d "$TEMP_DIR/$repo" ] || \
        echo -e "${YELLOW}  Warning: could not fetch '$repo' (offline or unavailable); its skills will be skipped.${RESET}"
done

if [[ "$AGENT_CHOICE" == "1" || "$AGENT_CHOICE" == "3" ]]; then
    install_skills "$HOME/.gemini/config/skills" "Antigravity"
fi

if [[ "$AGENT_CHOICE" == "2" || "$AGENT_CHOICE" == "3" ]]; then
    install_skills "$HOME/.claude/skills" "Claude Code"
fi

# --- Install RTK ---
if [[ "$RTK_YES" == "1" ]]; then
    echo ""
    echo -e "${CYAN}Installing RTK Execution Compression Layer...${RESET}"
    if command -v brew &>/dev/null; then
        if brew install rtk --quiet; then
            echo "  RTK installed via Homebrew."
        else
            echo -e "${YELLOW}  Warning: 'brew install rtk' failed. Skipping RTK.${RESET}"
        fi
    else
        echo -e "${YELLOW}  Warning: installing from a remote script over curl. Ensure you trust the source.${RESET}"
        if curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh; then
            echo "  RTK installer completed."
        else
            echo -e "${YELLOW}  Warning: the RTK installer failed. Skipping RTK.${RESET}"
        fi
    fi

    if command -v rtk &>/dev/null; then
        if [[ "$AGENT_CHOICE" == "1" || "$AGENT_CHOICE" == "3" ]]; then
            rtk init --agent antigravity >/dev/null 2>&1 || true
        fi
        if [[ "$AGENT_CHOICE" == "2" || "$AGENT_CHOICE" == "3" ]]; then
            rtk init -g >/dev/null 2>&1 || true
        fi
        echo "  RTK initialized."
    else
        echo -e "${YELLOW}  Warning: 'rtk' is not on PATH; skipping initialization.${RESET}"
    fi
fi

# --- Install Headroom ---
HEADROOM_OK=0
SHELL_RC=""
if [[ "$HEADROOM_YES" == "1" ]]; then
    echo ""
    echo -e "${CYAN}Installing Headroom Token Compression Layer...${RESET}"
    PYTHON_CMD="python3"
    if ! command -v $PYTHON_CMD &> /dev/null; then
        if command -v python &> /dev/null; then
            PYTHON_CMD="python"
        else
            PYTHON_CMD=""
        fi
    fi

    if [[ -n "$PYTHON_CMD" ]]; then
        if $PYTHON_CMD -c "import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)" 2>/dev/null; then
            PY_VER=$($PYTHON_CMD -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
            echo -n "  Found Python $PY_VER. Installing headroom-ai[all] via PyPI..."
            PIP_LOG=$(mktemp)
            ( $PYTHON_CMD -m pip install "headroom-ai[all]" --quiet >"$PIP_LOG" 2>&1 ) &
            PIP_PID=$!
            spin "$PIP_PID"
            if wait "$PIP_PID"; then
                echo " Done."
                HEADROOM_OK=1
            else
                echo " Failed."
                echo -e "${RED}  Warning: pip install failed. Last lines:${RESET}"
                tail -n 5 "$PIP_LOG" | sed 's/^/    /'
                echo -e "${YELLOW}  Retry manually, e.g. '$PYTHON_CMD -m pip install --user \"headroom-ai[all]\"'.${RESET}"
            fi
            rm -f "$PIP_LOG"

            if [[ "$HEADROOM_OK" == "1" ]]; then
                # Pick the rc file for the *current* shell. Defaulting to .bashrc
                # put the alias in a file zsh never reads on stock macOS.
                case "$(basename "${SHELL:-bash}")" in
                    zsh)  SHELL_RC="$HOME/.zshrc" ;;
                    bash) SHELL_RC="$HOME/.bashrc" ;;
                    *)    if [ -f "$HOME/.zshrc" ]; then SHELL_RC="$HOME/.zshrc"; else SHELL_RC="$HOME/.bashrc"; fi ;;
                esac
                if ! grep -q "HEADROOM_OUTPUT_SHAPER" "$SHELL_RC" 2>/dev/null; then
                    echo 'export HEADROOM_OUTPUT_SHAPER=1' >> "$SHELL_RC"
                fi
                if ! grep -q "alias claude-headroom=" "$SHELL_RC" 2>/dev/null; then
                    echo 'alias claude-headroom='\''ANTHROPIC_BASE_URL="http://localhost:8787" claude'\''' >> "$SHELL_RC"
                fi
                echo "  Headroom installed successfully."
                echo "  Output shaper and 'claude-headroom' alias enabled in $SHELL_RC."
            fi
        else
            PY_VER=$($PYTHON_CMD -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')" 2>/dev/null || echo "unknown")
            echo -e "${RED}Warning: Found Python $PY_VER. Headroom requires Python 3.10+.${RESET}"
            echo -e "${YELLOW}Please install a newer version of Python and run '$PYTHON_CMD -m pip install \"headroom-ai[all]\"' manually.${RESET}"
        fi
    else
        echo -e "${RED}Warning: 'python3' or 'python' not found. Please install Python 3.10+ and run 'python3 -m pip install \"headroom-ai[all]\"' manually.${RESET}"
    fi
fi

# --- Done ---
echo ""
echo -e "${BOLD}${GREEN}=================================================${RESET}"
echo -e "${BOLD}${GREEN}  Setup Complete!${RESET}"
echo -e "${BOLD}${GREEN}=================================================${RESET}"
echo ""
echo -e "Next steps:"
STEP=1
echo -e "  $STEP. Open Obsidian and point it at: ${CYAN}$VAULT_PATH${RESET}"; STEP=$((STEP + 1))
if [[ "$HEADROOM_OK" == "1" ]]; then
    echo -e "  $STEP. Start your token compressor: ${CYAN}headroom proxy --port 8787${RESET} (in a separate terminal)"; STEP=$((STEP + 1))
fi
if [[ "$HEADROOM_OK" == "1" && ( "$AGENT_CHOICE" == "2" || "$AGENT_CHOICE" == "3" ) ]]; then
    echo -e "  $STEP. Start Claude Code with the pre-configured alias: ${CYAN}claude-headroom${RESET}"
    echo -e "     (run ${CYAN}source $SHELL_RC${RESET} first, or open a new terminal)"
else
    echo -e "  $STEP. Start your agent (e.g., ${CYAN}claude${RESET} or ${CYAN}agy${RESET})"
fi
STEP=$((STEP + 1))
if [[ "$AGENT_CHOICE" == "1" || "$AGENT_CHOICE" == "3" ]]; then
    echo -e "     Note: Antigravity (${CYAN}agy${RESET}) bypasses local proxies natively."
fi
echo -e "  $STEP. Type: ${CYAN}/resume${RESET} to continue your last session, or ${CYAN}/research${RESET} for a new workflow"
echo ""
