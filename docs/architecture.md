# Architecture Overview

This document provides a deep dive into the technical architecture of the AI-Powered Research Assistant.

## The 4-Layer Architecture

The ecosystem is built on four distinct, orthogonal layers. Each layer has a single responsibility and can be understood independently.

### Layer 1: Network Compression (`headroom proxy`)
For supported clients (Claude Code, Cursor), the **Headroom Proxy** (running locally on port 8787) intercepts raw network requests. It applies AST minification, JSON crushing, and text compression transparently.
- Compresses tool outputs and file reads by 47–92%.
- Shapes model output verbosity (`HEADROOM_OUTPUT_SHAPER=1`) to save up to 30% on output tokens.
- **Optional & Client-Dependent**: Google Antigravity bypasses this proxy entirely.

### Layer 2: Raw Sources (`/raw/`)
Immutable source documents: PDFs, clipped articles, data files. The LLM reads from this layer but NEVER modifies it. This is the ground truth.

### Layer 3: The Wiki (`/wiki/`)
LLM-generated and LLM-maintained markdown files. The agent owns this layer entirely:
- `index.md` -- Central catalog of all wiki pages. The agent reads this first to find relevant context.
- `changelog.md` -- Append-only chronological log of all operations.
- `entities/` -- Pages about specific people, tools, models, datasets.
- `concepts/` -- Pages about techniques, patterns, architectural decisions.
- `synthesis/` -- Filed query answers, comparison tables, and deep analyses.

### Layer 4: The Schema (`agents/`)
Configuration documents (AGENTS.md, .cursorrules) that dictate how the LLM behaves. These turn a generic chatbot into a disciplined wiki maintainer.

## Token Economy

The architecture achieves dramatic, compounding token savings through three orthogonal mechanisms:

### 1. Semantic Reduction (Graphify)
Instead of reading an entire codebase (~170,000 tokens for a medium repo), the agent reads pre-computed AST maps (~6,000 tokens). This yields a **~96.4% reduction** in input token consumption.

### 2. The Index Protocol (Knowledge Retrieval)
Instead of scanning all wiki pages to find context, the agent reads a single `index.md` file (~200-500 tokens) and selectively loads only the 2-3 relevant pages. This prevents token waste on irrelevant content.

### 3. Network Compression (Headroom)
When the agent *does* read a file or runs a tool, the Headroom proxy compresses the raw text/JSON before sending it to the API.

**Compounding Effect:** A query that would normally consume 170,000 tokens (reading full codebase) is reduced to ~3,679 tokens by Graphify, and then further compressed to **~400–800 tokens** by Headroom.

## Operations

The system supports five core operations:

| Operation | Trigger | What Happens |
|---|---|---|
| **Ingest** | Add a source to `raw/` | LLM reads it, writes summary to `wiki/`, updates `index.md` and `changelog.md`. |
| **Query** | Ask a question | LLM reads `index.md`, drills into relevant pages, synthesizes an answer. |
| **File** | `/file` command | A valuable query answer is saved to `wiki/synthesis/`, updating `index.md`. |
| **Lint** | `/lint` command | LLM scans `wiki/` for broken links, orphan pages, stale entries. |
| **Save/Resume** | `/save` / `/resume` | Session state is saved to `logs/` and `changelog.md`, or restored from them. |

## System Flow

```mermaid
flowchart TD
    U[User] -->|Interacts via CLI| L[LLM Agent]
    
    subgraph Obsidian Vault
        L -->|Reads index.md first| W["wiki/"]
        L -->|Reads AST maps| G["graphify/"]
        L -->|Reads sources| R["raw/"]
        L -->|Writes logs| Lg["logs/"]
    end
    
    subgraph Schema Layer
        AGENTS["AGENTS.md"] -->|Configures behavior| L
    end
    
    L -->|Direct API Request (Antigravity)| API[LLM API]
    L -.->|Proxied Request (Claude/Cursor)| HP[Headroom Proxy :8787]
    HP -.->|Compressed API Request| API
    API -.->|Returns Response| HP
    HP -.->|Forwards Response| L
```
