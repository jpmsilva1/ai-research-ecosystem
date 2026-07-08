#!/usr/bin/env bats

setup() {
  export BATS_TEST_TMPDIR=$(mktemp -d)
  export HOME="$BATS_TEST_TMPDIR/home"
  
  mkdir -p "$HOME"
  
  # Mock git and python3
  mkdir -p "$BATS_TEST_TMPDIR/bin"
  export PATH="$BATS_TEST_TMPDIR/bin:$PATH"
  
  cat << 'EOF' > "$BATS_TEST_TMPDIR/bin/git"
#!/bin/bash
if [[ "$1" == "clone" ]]; then
    # Fake clone by creating the directory so cp -r doesn't fail
    mkdir -p "${@: -1}"
    exit 0
fi
exit 0
EOF
  chmod +x "$BATS_TEST_TMPDIR/bin/git"
  
  cat << 'EOF' > "$BATS_TEST_TMPDIR/bin/python3"
#!/bin/bash
if [[ "$1" == "-c" ]]; then
    if [[ "$2" == *"sys.exit(0 if sys.version_info >= (3, 10) else 1)"* ]]; then
        exit 0
    elif [[ "$2" == *"import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"* ]]; then
        echo "3.10"
        exit 0
    fi
fi
exit 0
EOF
  chmod +x "$BATS_TEST_TMPDIR/bin/python3"
}

teardown() {
  rm -rf "$BATS_TEST_TMPDIR"
}

@test "setup.sh - Antigravity installation (Core Pack)" {
  cd "$BATS_TEST_TMPDIR"
  
  # Inputs:
  # 1 -> Antigravity
  # 1 -> Core Pack
  # [enter] -> Default Vault
  # n -> No Headroom
  run bash -c "echo -e '1\n1\n\nn\n' | $BATS_TEST_DIRNAME/../setup.sh"
  
  [ "$status" -eq 0 ]
  [ -d "$HOME/Documents/AntigravityBrain/wiki" ]
  [ -f "$HOME/.gemini/config/AGENTS.md" ]
  [ -d "$HOME/.gemini/config/skills" ]
  [ ! -d "$HOME/.claude" ]
}

@test "setup.sh - Claude Code installation (Full Pack + Headroom)" {
  cd "$BATS_TEST_TMPDIR"
  
  # Inputs:
  # 2 -> Claude Code
  # 2 -> Full Pack
  # [enter] -> Default Vault
  # y -> Install Headroom
  run bash -c "echo -e '2\n2\n\ny\n' | $BATS_TEST_DIRNAME/../setup.sh"
  
  [ "$status" -eq 0 ]
  [ -d "$HOME/Documents/AntigravityBrain/wiki" ]
  [ -f "$HOME/.claude/.cursorrules" ]
  [ -d "$HOME/.claude/skills" ]
  [ ! -d "$HOME/.gemini" ]
  [[ "$output" == *"Headroom installed successfully"* ]]
}

@test "setup.sh - Both Agents installation" {
  cd "$BATS_TEST_TMPDIR"
  
  # Inputs:
  # 3 -> Both
  # 1 -> Core Pack
  # [enter] -> Default Vault
  # y -> Install Headroom
  run bash -c "echo -e '3\n1\n\ny\n' | $BATS_TEST_DIRNAME/../setup.sh"
  
  [ "$status" -eq 0 ]
  [ -d "$HOME/.gemini/config/skills" ]
  [ -d "$HOME/.claude/skills" ]
}
