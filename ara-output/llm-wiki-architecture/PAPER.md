---
title: "LLM Wiki: A pattern for building personal knowledge bases using LLMs"
authors: ["Andrej Karpathy"]
year: 2026
venue: "GitHub Gist"
doi: "https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f"
ara_version: "1.0"
domain: "AI Workflow Architecture"
keywords: ["LLM", "Wiki", "Knowledge Base", "RAG", "Agent", "Zettelkasten"]
claims_summary:
  - "Persistent LLM-Wikis eliminate redundant synthesis at query time by pre-compiling knowledge."
  - "LLMs can maintain wikis at near-zero marginal cost, preventing the structural decay common in human-maintained wikis."
abstract: "This document proposes a pattern where LLMs incrementally build and maintain a persistent, structured, interlinked collection of markdown files (a wiki) between the human and raw sources. Unlike traditional RAG which rediscovers knowledge at query time, the LLM-Wiki pre-compiles synthesis, cross-references, and logs during an ingest operation, allowing knowledge to compound over time at near-zero maintenance cost."
---

# LLM Wiki: A pattern for building personal knowledge bases using LLMs

## Overview
This ARA codifies the LLM-Wiki pattern, which shifts the paradigm from query-time retrieval to ingest-time compilation. The LLM acts as an autonomous maintainer of a persistent markdown knowledge base.

## Layer Index

### Cognitive Layer (`/logic`)
| File | Description |
|------|-------------|
| [problem.md](logic/problem.md) | Observations → gaps → key insight |
| [claims.md](logic/claims.md) | 2 falsifiable claims (C01–C02) |
| [concepts.md](logic/concepts.md) | 5 formal concepts (LLM-Wiki, Schema, Operations) |
| [experiments.md](logic/experiments.md) | 3 experimental plans |
| [solution/architecture.md](logic/solution/architecture.md) | 3-layer architecture |
| [solution/algorithm.md](logic/solution/algorithm.md) | Ingest, Query, Lint operations |
| [solution/constraints.md](logic/solution/constraints.md) | Boundary conditions |
| [solution/heuristics.md](logic/solution/heuristics.md) | Indexing and logging tricks |
| [related_work.md](logic/related_work.md) | Vannevar Bush Memex |

### Physical Layer (`/src`)
| File | Description | Claims |
|------|-------------|--------|
| [execution/wiki_operations.py](src/execution/wiki_operations.py) | Python stubs for wiki operations | C01, C02 |
| [configs/training.md](src/configs/training.md) | Model requirements | |
| [configs/model.md](src/configs/model.md) | Markdown parsing rules | |
| [environment.md](src/environment.md) | Required dependencies | |

### Exploration Graph (`/trace`)
| File | Description |
|------|-------------|
| [exploration_tree.yaml](trace/exploration_tree.yaml) | 8-node research DAG |

### Evidence (`/evidence`)
| File | Description |
|------|-------------|
| [README.md](evidence/README.md) | Full index |
| [tables/table1_architecture_comparison.md](evidence/tables/table1_architecture_comparison.md) | RAG vs LLM-Wiki |
