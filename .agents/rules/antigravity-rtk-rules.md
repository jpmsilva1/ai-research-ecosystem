# RTK - Rust Token Killer (Google Antigravity)

**Purpose**: Semantically compress verbose shell output BEFORE it reaches the LLM context window, saving 60–90% tokens. RTK only helps when there is verbose stdout to compress. Wrapping silent or network-bound commands wastes a telemetry slot and actively HARMS efficiency score.

---

## GOLDEN RULE

> **Ask: "Does this command produce verbose text output I will READ?"**
> - YES → prefix with `rtk`
> - NO → run raw (no prefix)

---

## ✅ ALWAYS use `rtk` prefix (verbose stdout, high compression value)

### Git — Inspection commands
```bash
rtk git status                    # File change summary
rtk git diff <file>               # File diffs
rtk git diff HEAD                 # All staged diffs
rtk git log -p                    # Full patch log (85%+ compression typical)
rtk git log --stat                # File change stats
rtk git show <commit>             # Commit details with diff
rtk git blame <file>              # Line-by-line authorship
```

### Search & Filesystem
```bash
rtk grep "pattern" src/           # Search results
rtk grep -r "pattern" .           # Recursive search
rtk ls -la                        # Directory listing with metadata
rtk find . -name "*.py"           # File search results
rtk cat <file>                    # File contents (when reading for context)
rtk head -n 50 <file>             # File preview
rtk tail -n 100 <logfile>         # Log tails
```

### Python & Research
```bash
rtk python train.py               # Training script output (massive savings)
rtk python -m pytest              # Test output — strips passing, keeps failures
rtk pytest                        # Same
rtk pip install <pkg>             # Installation logs
rtk pip list                      # Installed packages
rtk conda list                    # Conda environment packages
rtk python -c "import X; print(X.__version__)"  # Quick version checks
```

### System & Docker
```bash
rtk docker ps -a                  # Container listings
rtk docker logs <container>       # Container log output
rtk docker images                 # Image listings
rtk npm test                      # Test runner output
rtk npm install                   # Install logs
rtk cargo test                    # Rust test output
rtk make                          # Build output
```

---

## ❌ NEVER use `rtk` prefix (zero/minimal stdout — wastes telemetry slots)

```bash
# Git write/network operations — output goes to stderr or is trivial
git push                          # Network-bound, stderr output only
git pull                          # Same
git fetch                         # Same
git clone                         # Same
git add <file>                    # Produces NO stdout
git rm <file>                     # Produces NO stdout
git commit                        # Trivial stdout (hash + stat summary), not worth compressing
git checkout <branch>             # Minimal output
git stash                         # Minimal output
git tag <name>                    # Minimal/no output
git merge <branch>                # Use with caution — may need rtk if verbose

# File writes
cp, mv, mkdir, rm                 # No meaningful stdout
touch <file>                      # No stdout
echo "x" > file.txt              # No stdout
```

---

## Meta Commands (never need `rtk` prefix)
```bash
rtk gain                          # Show token savings dashboard
rtk gain --history                # Full command history with per-command savings
rtk discover                      # Find missed RTK opportunities in shell history
rtk proxy <cmd>                   # Run raw (bypass compression, for debugging)
```

---

## Why This Matters

RTK tracks every command in a global telemetry database. Every 0%-saving command (fallbacks, silent commands) lowers your global efficiency score and wastes a telemetry slot. Targeting only verbose commands keeps the efficiency meter above 50%.

**Expected efficiency by command type:**
| Command | Typical Savings |
|---|---|
| `rtk git log -p` | 80–90% |
| `rtk pytest` | 70–85% |
| `rtk python train.py` | 60–80% |
| `rtk grep` | 40–60% |
| `rtk git status` | 20–40% |
| `rtk git push` | **0% — DO NOT USE** |
