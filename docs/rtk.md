# Execution Compression (Layer 0)

The AI Research Ecosystem uses **RTK (Rust Token Killer)** to compress shell command outputs before the AI agent reads them.

## 1. Why RTK?
While Headroom (Layer 1) compresses API network payloads, it is bypassed by agents like Google Antigravity. RTK operates at the **execution layer**, intercepting commands like `pytest` or `git` and semantically summarizing them (e.g., stripping passing tests, showing only failures).

## 2. Installation
```bash
brew install rtk
```
*(If Homebrew is unavailable: `curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh`)*

## 3. Agent Configuration
Run the initialization command for your specific agent:
```bash
rtk init -g --agent antigravity   # For Google Antigravity
rtk init -g                       # For Claude Code
```

## 4. Verifying Savings
Run `rtk gain` in your terminal to see a dashboard of how many tokens RTK has saved you.
