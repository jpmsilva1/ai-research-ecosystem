# Quickstart (5 Minutes)

Get from zero to a fully configured AI Research Assistant in one command.

## 1. Clone and Run Setup

```bash
git clone https://github.com/jpmsilva1/ai-research-workflow.git
cd ai-research-workflow
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

## 3. Start Researching

Open your agent (Antigravity or Claude) and type:

```
/research
```

The Research Orchestrator will guide you through the full academic lifecycle:
Discovery -> Ingestion -> Synthesis -> Writing -> Review -> Presentation.

## 4. Save Your Session

When you are done, type `/salvar`. Your progress is permanently stored in the vault.

## 5. Resume Tomorrow

In a new session, type `/retomar`. The agent reads your `changelog.md` and `index.md` to pick up exactly where you left off.

## Key Commands

| Command | What It Does |
|---|---|
| `/research` | Start a guided research workflow |
| `/salvar` | Save session to persistent memory |
| `/retomar` | Resume from last session |
| `/lint` | Health-check the knowledge vault |
| `/file` | File a valuable answer into the wiki |

## Learn More

- [Full Architecture Overview](docs/architecture.md)
- [Core Pack Skills Guide](docs/guides/core-pack-usage.md)
- [Full Pack Skills Guide](docs/guides/full-pack-usage.md)
- [Manual Installation](docs/installation.md)
