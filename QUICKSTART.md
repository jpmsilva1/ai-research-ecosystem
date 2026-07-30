# Quickstart (5 Minutes)

Get from zero to a fully configured AI Research Assistant in one command.

## 0. Prerequisites

Make sure you have **Python 3.10+**, `git`, and optionally **Homebrew** (for RTK compression) installed. You can verify with:

```bash
python3 --version && git --version
```

*(The setup script will offer to install Headroom token compression automatically. No manual steps needed.)*

## 1. Clone and Run Setup

```bash
git clone https://github.com/jpmsilva1/ai-research-ecosystem.git
cd ai-research-ecosystem
chmod +x setup.sh && ./setup.sh
```

The interactive setup will ask you:
- Which agent you use (Antigravity, Claude Code, or both).
- Which skill pack to install (Core for academic research, Full for engineering).
- Where to create your Obsidian vault (default: `~/Documents/AntigravityBrain/`).

## 2. Open Obsidian

Open the vault folder the script created. You should see:
- `wiki/index.md` -- Your central knowledge catalog.
- `wiki/changelog.md` -- Timeline of all operations.
- `raw/` -- Drop your PDFs and source documents here.

## 1.5. Enable Token Compression (RTK)

RTK compresses terminal output by up to 90%.
```bash
brew install rtk
rtk init --agent antigravity  # Use 'rtk init -g' if using Claude Code
```

> **Note for Antigravity Users:** You must run this initialization command in the root folder of **every new project** you create. It is project-scoped for your safety. See the [RTK FAQ](docs/rtk.md#5-frequently-asked-questions-faq).

## 3. Start Researching

**If you installed Headroom:** Open a separate terminal and run `headroom proxy --port 8787`.
*(Note: RTK is active transparently and will compress your shell commands natively without a proxy server).*

Now, start your agent depending on your choice during setup:

**Path A: Google Antigravity**
Simply type:
```bash
agy
```

**Path B: Claude Code (with Headroom Proxy)**
To ensure Claude routes through the token compressor, use the alias created by the setup script:
```bash
claude-headroom
```
*(If you didn't run the setup script, you must manually run `export ANTHROPIC_BASE_URL="http://localhost:8787" && claude`)*

Once your agent is running, type:
```text
/research
```

The Research Orchestrator will guide you through the full academic lifecycle:
Discovery -> Ingestion -> Synthesis -> Writing -> Review -> Presentation.

## 4. Save Your Session

When you are done, type `/save`. 
*Behind the scenes:* The agent compiles a permanent Zettelkasten log from its lightweight, running scratch trace (`scratch/session-trace.md`), rather than retroactively scanning thousands of tokens from the terminal buffer. Your progress is permanently stored in the vault, and the scratch trace is securely deleted.

## 5. Resume Tomorrow

In a new session, type `/resume`. 
*Behind the scenes:* The agent reads your `changelog.md` to identify and load **only** your most recent session log. It provides an executive summary of pending tasks and will explicitly ask if you need older context, ensuring your fresh session starts with a perfectly clean, low-token context window.

## Key Commands

| Command | What It Does |
|---|---|
| `/research` | Start a guided research workflow |
| `/paper-code-finder` | Find source code for an academic paper |
| `/save` | Save session to persistent memory |
| `/resume` | Resume from last session |
| `/lint` | Health-check the knowledge vault |
| `/file` | File a valuable answer into the wiki |

## Learn More

- [Full Architecture Overview](docs/architecture.md)
- [Core Pack Skills Guide](docs/guides/core-pack-usage.md)
- [Full Pack Skills Guide](docs/guides/full-pack-usage.md)
- [Manual Installation](docs/installation.md)
