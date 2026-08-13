#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

# `run !` below needs bats-core >= 1.5.0; without this, bare `! cmd` never
# fails the test (bash ignores `set -e` for commands whose status is
# inverted with `!`), silently defeating the assertion.
bats_require_minimum_version 1.5.0

setup() {
  # bats-core already provides and populates BATS_TEST_TMPDIR; overwriting it
  # here was undefined behaviour and leaked a redundant mktemp -d directory.
  export HOME="$BATS_TEST_TMPDIR/home"
  mkdir -p "$HOME"

  # Mock every external command setup.sh can shell out to, so the suite never
  # touches the network or a real package manager. Previously only git and
  # python3 were mocked; the RTK prompt was answered by an accidental extra
  # blank line, defaulted to "y", and ran a real `curl | sh` against the
  # internet on every test run.
  mkdir -p "$BATS_TEST_TMPDIR/bin"
  export PATH="$BATS_TEST_TMPDIR/bin:$PATH"

  cat << 'EOF' > "$BATS_TEST_TMPDIR/bin/git"
#!/bin/bash
if [[ "$1" == "clone" ]]; then
    # Fake clone by creating the destination dir so copy_dir sees "cloned but
    # empty", the same shape a real clone of an unreachable/renamed repo has.
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
if [[ "$1" == "-m" && "$2" == "pip" ]]; then
    exit 0
fi
exit 0
EOF
  chmod +x "$BATS_TEST_TMPDIR/bin/python3"

  # No real Homebrew, so setup.sh takes the "brew install rtk" branch and it
  # fails cleanly -- it must never fall through to the curl-pipe-sh branch
  # in a test.
  cat << 'EOF' > "$BATS_TEST_TMPDIR/bin/brew"
#!/bin/bash
touch "$BATS_TEST_TMPDIR/brew.called"
exit 1
EOF
  chmod +x "$BATS_TEST_TMPDIR/bin/brew"

  cat << 'EOF' > "$BATS_TEST_TMPDIR/bin/curl"
#!/bin/bash
touch "$BATS_TEST_TMPDIR/curl.called"
exit 1
EOF
  chmod +x "$BATS_TEST_TMPDIR/bin/curl"
}

# teardown is intentionally empty: BATS_TEST_TMPDIR is bats-core's own temp
# dir and bats cleans it up itself.

@test "setup.sh - Antigravity installation (Core Pack, no Headroom, no RTK)" {
  cd "$BATS_TEST_TMPDIR"

  # Inputs, in setup.sh's actual prompt order:
  # 1 -> Antigravity | 1 -> Core Pack | [enter] -> default vault | n -> no Headroom | n -> no RTK
  run bash -c "printf '1\n1\n\nn\nn\n' | $BATS_TEST_DIRNAME/../setup.sh"

  [ "$status" -eq 0 ]
  [ -d "$HOME/Documents/AntigravityBrain/wiki" ]
  [ -f "$HOME/.gemini/config/AGENTS.md" ]
  [ ! -d "$HOME/.claude" ]

  # A specific bundled skill must actually be present, not just the parent
  # directory that mkdir -p creates unconditionally.
  [ -f "$HOME/.gemini/config/skills/lint-vault/SKILL.md" ]

  # The vault path must be interpolated into AGENTS.md, not left as the
  # literal placeholder -- this is the exact regression that motivated
  # collapsing the two install branches into one function.
  grep -q "$HOME/Documents/AntigravityBrain" "$HOME/.gemini/config/AGENTS.md"
  # `! cmd` does not trip bats'/bash's errexit on failure (bash ignores set -e
  # for commands whose status is inverted with !), so a bare `!` here would
  # never actually fail this test even if the placeholder were left behind.
  run ! grep -q '{{VAULT_PATH}}' "$HOME/.gemini/config/AGENTS.md"

  # The Core Pack upstream repo is mocked as an empty clone, so 0 of 35 pack
  # skills can land; the script must say so rather than claim success.
  [[ "$output" == *"expected 35 Core Pack skills but installed 0"* ]]

  # Never touched the network for RTK.
  [ ! -f "$BATS_TEST_TMPDIR/curl.called" ]
}

@test "setup.sh - Claude Code installation (Full Pack + Headroom, no RTK)" {
  cd "$BATS_TEST_TMPDIR"

  # 2 -> Claude Code | 2 -> Full Pack | [enter] -> default vault | y -> Headroom | n -> no RTK
  run bash -c "printf '2\n2\n\ny\nn\n' | $BATS_TEST_DIRNAME/../setup.sh"

  [ "$status" -eq 0 ]
  [ -f "$HOME/.claude/.cursorrules" ]
  [ ! -d "$HOME/.gemini" ]

  # This is the bug that shipped broken /save and /resume to every Claude
  # Code user: interpolation ran only in the Antigravity branch.
  [ -f "$HOME/.claude/skills/save-session/SKILL.md" ]
  grep -q "$HOME/Documents/AntigravityBrain" "$HOME/.claude/skills/save-session/SKILL.md"
  run ! grep -rq '{{VAULT_PATH}}' "$HOME/.claude/skills/"

  [[ "$output" == *"Headroom installed successfully"* ]]
  [ ! -f "$BATS_TEST_TMPDIR/curl.called" ]
}

@test "setup.sh - Both agents (Core Pack, RTK enabled but offline)" {
  cd "$BATS_TEST_TMPDIR"

  # 3 -> Both | 1 -> Core Pack | [enter] -> default vault | n -> no Headroom | y -> RTK
  run bash -c "printf '3\n1\n\nn\ny\n' | $BATS_TEST_DIRNAME/../setup.sh"

  [ "$status" -eq 0 ]
  [ -d "$HOME/.gemini/config/skills" ]
  [ -d "$HOME/.claude/skills" ]

  # academic-plotting used to be Antigravity-only; must now land for Claude too.
  # The mocked clone leaves the directory empty, so we only assert the branch
  # was attempted for both targets by checking both skill trees exist and
  # neither agent was skipped.
  [ -f "$HOME/.gemini/config/skills/lint-vault/SKILL.md" ]
  [ -f "$HOME/.claude/skills/lint-vault/SKILL.md" ]

  # RTK path used brew (mocked, fails cleanly) and must never fall through
  # to a real network call.
  [ -f "$BATS_TEST_TMPDIR/brew.called" ]
  [ ! -f "$BATS_TEST_TMPDIR/curl.called" ]
}

@test "setup.sh - invalid agent choice is rejected, not silently skipped" {
  cd "$BATS_TEST_TMPDIR"

  # 4 is not a valid agent choice; the script must re-prompt, and hitting
  # EOF on a non-interactive stream must abort loudly rather than exit 0
  # having installed nothing.
  run bash -c "printf '4\n' | $BATS_TEST_DIRNAME/../setup.sh"

  [ "$status" -ne 0 ]
  [[ "$output" == *"Invalid choice"* ]]
}
