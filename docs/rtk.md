# Execution Compression (Layer 0)

The AI Research Ecosystem uses **RTK (Rust Token Killer)** to compress shell command outputs before the AI agent reads them.

## 1. Why RTK?
While Headroom (Layer 1) compresses API network payloads, it is bypassed by agents like Google Antigravity. RTK operates at the **execution layer**, intercepting commands like `pytest` or `git` and semantically summarizing them (e.g., stripping passing tests, showing only failures). 

**The Dual-Layer Synergy:**
- **For Google Antigravity:** RTK is your exclusive compression layer, solving the token bloat by intercepting large shell outputs natively.
- **For Claude Code:** RTK works perfectly alongside Headroom. RTK semantically crushes the terminal output first, and then Headroom algorithmically crushes the final API payload sent over the network.

## 2. Installation
```bash
brew install rtk
```
*(If Homebrew is unavailable: `curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh`)*

## 3. Agent Configuration
Run the initialization command for your specific agent:
```bash
rtk init --agent antigravity   # For Google Antigravity
rtk init -g                       # For Claude Code
```

## 4. Verifying Savings
Run `rtk gain` in your terminal to see a dashboard of how many tokens RTK has saved you.

## 5. Frequently Asked Questions (FAQ)

### Why does `rtk gain` show a warning saying "No hook installed"?
If you are using Google Antigravity, **this warning is completely safe to ignore**. The dashboard defaults to checking for a *global* hook (which Claude Code uses). Antigravity uses a strict *project-scoped* hook (`.agents/rules/`). As long as you ran `rtk init --agent antigravity` inside your project, it is working perfectly!

### Do I need to initialize RTK for every new project?
**Yes.** Antigravity has a strict security model that prevents it from blindly intercepting your entire Mac's terminal. You must `cd` into your new project's root folder and run `rtk init --agent antigravity` once for that specific project.
> [!TIP]
> **Pro Tip:** To save time, add an alias to your `~/.zshrc` profile: `alias rtk-antigravity='rtk init --agent antigravity'`. Then, inside any new project folder, just type `rtk-antigravity`.

### Can I hook the `cd` command to initialize it automatically?
Technically yes, but **it is highly discouraged**. If you hook `cd`, your terminal will attempt to inject AI rules into *every single folder* you navigate into on your machine (like your Downloads or system folders). It is much safer to run the command manually only when creating a new AI-assisted project.

### When I run `rtk gain`, which project's savings does it show?
The `rtk gain` dashboard displays your **Global** token savings across *all* projects combined. Even though you initialize the agent hooks per-project, the actual telemetry database is stored globally. You can run `rtk gain` from any directory on your computer to see your total machine-wide savings.
