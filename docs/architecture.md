# Architecture Overview

This document provides a deep dive into the technical architecture of the AI-Powered Research Assistant.

## The Three-Layer Vault (LLM-Wiki Pattern)

Inspired by Andrej Karpathy's LLM-Wiki concept, the persistent memory vault follows a strict three-layer separation:

### Layer 1: Raw Sources (`/raw/`)
Immutable source documents: PDFs, clipped articles, data files. The LLM reads from this layer but NEVER modifies it. This is the ground truth.

### Layer 2: The Wiki (`/wiki/`)
LLM-generated and LLM-maintained markdown files. The agent owns this layer entirely:
- `index.md` -- Central catalog of all wiki pages. The agent reads this first to find relevant context.
- `changelog.md` -- Append-only chronological log of all operations.
- `entities/` -- Pages about specific people, tools, models, datasets.
- `concepts/` -- Pages about techniques, patterns, architectural decisions.
- `synthesis/` -- Filed query answers, comparison tables, and deep analyses.

### Layer 3: The Schema (`agents/`)
Configuration documents (AGENTS.md, .cursorrules) that dictate how the LLM behaves. These turn a generic chatbot into a disciplined wiki maintainer.

## Token Economy

The architecture achieves dramatic token savings through two mechanisms:

### 1. Graphify (Code Understanding)
Instead of reading an entire codebase (~170,000 tokens for a medium repo), the agent reads pre-computed AST maps (~6,000 tokens). This yields a **~96.4% reduction** in input token consumption.

### 2. The Index Protocol (Knowledge Retrieval)
Instead of scanning all wiki pages to find context, the agent reads a single `index.md` file (~200-500 tokens) and selectively loads only the 2-3 relevant pages. This prevents token waste on irrelevant content.

## Operations

The system supports five core operations:

| Operation | Trigger | What Happens |
|---|---|---|
| **Ingest** | Add a source to `raw/` | LLM reads it, writes summary to `wiki/`, updates `index.md` and `changelog.md`. |
| **Query** | Ask a question | LLM reads `index.md`, drills into relevant pages, synthesizes an answer. |
| **File** | `/file` command | A valuable query answer is saved to `wiki/synthesis/`, updating `index.md`. |
| **Lint** | `/lint` command | LLM scans `wiki/` for broken links, orphan pages, stale entries. |
| **Save/Resume** | `/salvar` / `/retomar` | Session state is saved to `logs/` and `changelog.md`, or restored from them. |

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
```
