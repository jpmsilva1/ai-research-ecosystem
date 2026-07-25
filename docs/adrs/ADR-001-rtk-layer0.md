# ADR 001: Introduce RTK as Layer 0 (Pre-Execution Compression)

## Context
Google Antigravity connects directly to native APIs, bypassing our Layer 1 Headroom HTTP proxy. Antigravity users suffer from high token consumption on shell commands (e.g., `git status`, `pytest`).

## Decision
We will integrate `rtk-ai/rtk` as Layer 0. RTK intercepts bash executions natively via shell hooks and applies semantic compression *before* the output reaches the terminal.

## Consequences
- **Positive:** Antigravity users gain 60-90% token reduction on CLI commands.
- **Positive:** Zero conflict with Headroom (which handles API payloads for Claude).
- **Negative:** Adds a binary dependency (Rust Token Killer).
