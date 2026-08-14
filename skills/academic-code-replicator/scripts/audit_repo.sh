#!/usr/bin/env bash
# Phase 1 Ingestion: Automated Repo Audit Script
# Extracts entry points, hardcoded paths, and dependency signals.
set -uo pipefail
# (no -e: grep/find returning "no matches" is a normal outcome here, not a
# script failure, and the exit status below is set explicitly.)

TARGET_DIR=${1:-src/original/}

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: target directory '$TARGET_DIR' does not exist." >&2
    exit 1
fi

echo "=== Entry Points ==="
find "$TARGET_DIR" -not -path "*/.git/*" -type f \
    \( -name "main.py" -o -name "train.py" -o -name "run_*.py" -o -name "__main__.py" \
       -o -name "*.R" -o -name "*.jl" -o -name "Makefile" -o -name "setup.py" \) \
    -not -path "*/\.*"

echo -e "\n=== Hardcoded Paths (Potential Phase 3 Fixes) ==="
# Matches paths starting with / or Windows drives like C:\
grep -rnE --binary-files=without-match --exclude-dir={.git,node_modules,venv,.venv} \
    "['\"](/[a-zA-Z]|[a-zA-Z]:\\\\)" "$TARGET_DIR" 2>/dev/null \
    | grep -vE "http" | head -n 20

echo -e "\n=== Dependency Files ==="
find "$TARGET_DIR" -not -path "*/.git/*" -maxdepth 3 -type f \
    \( -name "requirements.txt" -o -name "environment.yml" -o -name "renv.lock" \
       -o -name "Project.toml" -o -name "pyproject.toml" -o -name "Pipfile" \
       -o -name "poetry.lock" -o -name "DESCRIPTION" \)

echo -e "\n=== Detected Parallelism ==="
grep -rnE --binary-files=without-match --exclude-dir={.git,node_modules,venv,.venv} \
    "(multiprocessing|joblib.Parallel|doParallel|mclapply|Threads.@threads)" "$TARGET_DIR" 2>/dev/null

exit 0
