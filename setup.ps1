<#
.SYNOPSIS
AI Research Ecosystem - Interactive Setup Script for Windows
Version: 5.1.1
#>
$ErrorActionPreference = "Stop"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Error: 'git' is not installed or not in PATH. Please install git to continue." -ForegroundColor Red
    exit 1
}

Write-Host "================================================="  -ForegroundColor Cyan
Write-Host "  AI-Powered Research Assistant - Setup v5.1.1  "   -ForegroundColor Cyan
Write-Host "================================================="  -ForegroundColor Cyan

# Skills pulled from google/antigravity-awesome-skills for the Core Pack.
# This is the exact original list -- do not rename, reorder, or add to it.
$CoreSkills = @("papers-skill", "deep-research", "exa-search", "tavily-web", "research-brainstorming", "creative-thinking", "data-engineering-data-pipeline", "data-engineering-data-driven-feature", "data-structure-protocol", "data-quality-frameworks", "polars", "data-scientist", "data-storytelling", "plotly", "ml-engineer", "ai-ml", "ai-engineering-toolkit", "rag-engineer", "embedding-strategies", "ml-pipeline-workflow", "mlops-engineer", "docker-expert", "devops-deploy", "unit-testing-test-generate", "2slides-ppt-generator", "latex-paper-conversion", "architecture-decision-records", "docs-architect", "graphify", "pytorch-patterns", "scientific-thinking-literature-review", "scientific-thinking-scholar-evaluation", "mle-workflow", "eval-harness", "ai-regression-testing")

# Loops on an invalid answer instead of silently proceeding -- an unmatched
# choice used to fall through every `-eq` check below, install nothing, and
# still print "Setup Complete!" at the end.
function Read-Choice ($Prompt, $Valid) {
    while ($true) {
        $answer = Read-Host $Prompt
        if ($Valid -contains $answer) { return $answer }
        Write-Host "  Invalid choice '$answer'. Please enter one of: $($Valid -join '/')" -ForegroundColor Red
    }
}

# --- Step 1: Agent Selection ---
Write-Host "`nStep 1: Which AI agent do you use?" -ForegroundColor White
Write-Host "  [1] Google Antigravity"
Write-Host "  [2] Claude Code (Anthropic)"
Write-Host "  [3] Both"
$AgentChoice = Read-Choice "Select (1/2/3)" @("1", "2", "3")

# --- Step 2: Pack Selection ---
Write-Host "`nStep 2: Which skill pack do you want to install?" -ForegroundColor White
Write-Host "  [1] Core Pack (Academic Research - $($CoreSkills.Count) skills)"
Write-Host "  [2] Full Pack (Enterprise Engineering - 130+ skills)"
$PackChoice = Read-Choice "Select (1/2)" @("1", "2")

# --- Step 3: Vault Location ---
$DefaultVault = Join-Path $env:USERPROFILE "Documents\AntigravityBrain"
Write-Host "`nStep 3: Where should the Obsidian vault be created?" -ForegroundColor White
$VaultPath = Read-Host "Path (default: $DefaultVault)"
if ([string]::IsNullOrWhiteSpace($VaultPath)) {
    $VaultPath = $DefaultVault
}

# --- Step 4: Headroom Token Compression ---
Write-Host "`nStep 4: Install Headroom token compression layer?" -ForegroundColor White
Write-Host "  Headroom compresses your prompts and tool outputs to save 47-92% tokens."
Write-Host "  It runs as a local transparent proxy on port 8787."
if ($AgentChoice -eq "1") {
    Write-Host "  (Warning: Antigravity connects directly to its API and bypasses local proxies. This feature is only effective for Claude Code or Cursor)." -ForegroundColor Yellow
} elseif ($AgentChoice -eq "3") {
    Write-Host "  (Note: Proxy compression will only work for Claude Code, as Antigravity bypasses local proxies)." -ForegroundColor Yellow
} else {
    Write-Host "  (Note: Proxy interception natively supports Claude Code and Cursor)." -ForegroundColor DarkGray
}
$HeadroomChoice = Read-Host "Install? (y/n) [Recommended: y]"
if ([string]::IsNullOrWhiteSpace($HeadroomChoice)) {
    $HeadroomChoice = "y"
}

# --- Step 5: RTK Execution Compression ---
Write-Host "`nStep 5: Install RTK (Rust Token Killer) execution compression?" -ForegroundColor White
Write-Host "  RTK compresses shell command outputs (git, pytest, pip...) by 60-90%."
Write-Host "  Works with ALL agents, including Google Antigravity."
$RtkChoice = Read-Host "Install? (y/n) [Recommended: y]"
if ([string]::IsNullOrWhiteSpace($RtkChoice)) {
    $RtkChoice = "y"
}

$ScriptDir = $PSScriptRoot

# --- Create Vault Structure ---
Write-Host "`nCreating vault structure at: $VaultPath" -ForegroundColor Cyan
$Dirs = @(
    "$VaultPath\raw\assets",
    "$VaultPath\wiki\entities",
    "$VaultPath\wiki\concepts",
    "$VaultPath\wiki\synthesis",
    "$VaultPath\graphify",
    "$VaultPath\logs"
)
foreach ($Dir in $Dirs) {
    New-Item -ItemType Directory -Force -Path $Dir | Out-Null
}

# Copy templates if they don't already exist
$IndexTemplate = Join-Path $ScriptDir "obsidian-vault-template\wiki\index.md"
$IndexTarget = Join-Path $VaultPath "wiki\index.md"
if (-not (Test-Path $IndexTarget)) {
    Copy-Item $IndexTemplate $IndexTarget
    Write-Host "  Created wiki/index.md"
}

$ChangelogTemplate = Join-Path $ScriptDir "obsidian-vault-template\wiki\changelog.md"
$ChangelogTarget = Join-Path $VaultPath "wiki\changelog.md"
if (-not (Test-Path $ChangelogTarget)) {
    Copy-Item $ChangelogTemplate $ChangelogTarget
    Write-Host "  Created wiki/changelog.md"
}

# --- Install Agent Configuration ---
Write-Host "`nInstalling agent configuration..." -ForegroundColor Cyan
$VaultPathForward = $VaultPath -replace '\\', '/'

if ($AgentChoice -eq "1" -or $AgentChoice -eq "3") {
    $AntigravityConfig = Join-Path $env:USERPROFILE ".gemini\config"
    New-Item -ItemType Directory -Force -Path $AntigravityConfig | Out-Null
    
    $AgentsTemplate = Join-Path $ScriptDir "agents\antigravity\AGENTS.md"
    $AgentsTarget = Join-Path $AntigravityConfig "AGENTS.md"
    (Get-Content $AgentsTemplate) -replace '\{\{VAULT_PATH\}\}', $VaultPathForward | Set-Content $AgentsTarget
    Write-Host "  Installed AGENTS.md to $AntigravityConfig\"
}

if ($AgentChoice -eq "2" -or $AgentChoice -eq "3") {
    $ClaudeConfig = Join-Path $env:USERPROFILE ".claude"
    New-Item -ItemType Directory -Force -Path $ClaudeConfig | Out-Null
    
    $CursorTemplate = Join-Path $ScriptDir "agents\claude\.cursorrules"
    $CursorTarget = Join-Path $ClaudeConfig ".cursorrules"
    (Get-Content $CursorTemplate) -replace '\{\{VAULT_PATH\}\}', $VaultPathForward | Set-Content $CursorTarget
    Write-Host "  Installed .cursorrules to $ClaudeConfig\"
}

# --- Install Skills ---
Write-Host "`nInstalling skills..." -ForegroundColor Cyan

# A random name avoids clobbering a pre-existing file/junction at a predictable
# path, and lets multiple runs (or a crashed prior run) coexist safely.
$TempDir = Join-Path $env:TEMP ("ai-research-setup-" + [System.Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $TempDir | Out-Null

# Everything below can throw under $ErrorActionPreference = "Stop"; the finally
# block guarantees $TempDir is removed even on a mid-install failure.
try {

$PonytailDir = Join-Path $TempDir "ponytail-plugin"
$AiResearchSkillsDir = Join-Path $TempDir "ai-research-skills"
$AwesomeSkillsDir = Join-Path $TempDir "awesome-skills"
$AegisOpsDir = Join-Path $TempDir "aegisops-ai"

Write-Host "  Cloning repositories..."
# A failed clone must not be fatal -- $ErrorActionPreference = "Stop" turns
# git's non-zero exit into a terminating error, which used to abort the whole
# script (skipping every remaining install step) on a single offline/renamed
# repo. Wrap each clone so a failure just leaves its Test-Path check below
# to report the skill source as unavailable, same as setup.sh's `|| true`.
function Invoke-Clone ($Url, $Dest) {
    try { git clone --quiet --depth 1 $Url $Dest 2>$null } catch { }
}
Invoke-Clone "https://github.com/DietrichGebert/ponytail" $PonytailDir
Invoke-Clone "https://github.com/Orchestra-Research/AI-Research-SKILLs.git" $AiResearchSkillsDir
Invoke-Clone "https://github.com/google/antigravity-awesome-skills.git" $AwesomeSkillsDir
Invoke-Clone "https://github.com/Champbreed/AegisOps-AI.git" $AegisOpsDir
foreach ($pair in @(@($PonytailDir,"ponytail-plugin"), @($AiResearchSkillsDir,"ai-research-skills"), @($AwesomeSkillsDir,"awesome-skills"), @($AegisOpsDir,"aegisops-ai"))) {
    if (-not (Test-Path $pair[0])) {
        Write-Host "  Warning: could not fetch '$($pair[1])' (offline or unavailable); its skills will be skipped." -ForegroundColor Yellow
    }
}

# Copy a directory's *contents* into dest, replacing dest wholesale first.
# `Copy-Item -Recurse -Force src dest` nests (dest\src-leaf-name\...) when dest
# already exists, which silently corrupted the skill layout on a second run.
function Copy-DirContents ($Src, $Dest) {
    if (-not (Test-Path $Src)) { return $false }
    if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    Copy-Item -Recurse -Force (Join-Path $Src "*") $Dest -ErrorAction SilentlyContinue
    return $true
}

# Sweeps every installed file under $Dir for the {{VAULT_PATH}} placeholder,
# not just save-session/resume-session -- lint-vault and research-orchestrator
# (and any future skill) carry the same placeholder and were shipping broken.
function Set-VaultPathPlaceholder ($Dir) {
    if (-not (Test-Path $Dir)) { return }
    Get-ChildItem -Recurse -File $Dir -ErrorAction SilentlyContinue | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
        if ($content -and $content.Contains('{{VAULT_PATH}}')) {
            $content.Replace('{{VAULT_PATH}}', $VaultPathForward) | Set-Content $_.FullName -NoNewline
        }
    }
}

function Install-Skills ($TargetDir) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
    $Bundled = 0
    $Extras = 0

    $BundledDir = Join-Path $ScriptDir "skills"
    if (Test-Path $BundledDir) {
        Get-ChildItem -Directory $BundledDir | ForEach-Object {
            if (Copy-DirContents $_.FullName (Join-Path $TargetDir $_.Name)) { $Bundled++ }
        }
    }

    if (Copy-DirContents $PonytailDir (Join-Path $TargetDir "ponytail")) { $Extras++ }
    if (Copy-DirContents $AegisOpsDir (Join-Path $TargetDir "aegisops-ai")) { $Extras++ }
    if (Copy-DirContents (Join-Path $AiResearchSkillsDir "20-ml-paper-writing\ml-paper-writing") (Join-Path $TargetDir "ml-paper-writing")) { $Extras++ }
    if (Copy-DirContents (Join-Path $AiResearchSkillsDir "20-ml-paper-writing\academic-plotting") (Join-Path $TargetDir "academic-plotting")) { $Extras++ }
    if (Copy-DirContents (Join-Path $AiResearchSkillsDir "22-agent-native-research-artifact\compiler") (Join-Path $TargetDir "ara-compiler")) { $Extras++ }
    if (Copy-DirContents (Join-Path $AiResearchSkillsDir "22-agent-native-research-artifact\research-manager") (Join-Path $TargetDir "ara-research-manager")) { $Extras++ }
    if (Copy-DirContents (Join-Path $AiResearchSkillsDir "22-agent-native-research-artifact\rigor-reviewer") (Join-Path $TargetDir "ara-rigor-reviewer")) { $Extras++ }

    Write-Host "  Installed $Bundled bundled + $Extras companion skills -> $TargetDir"
}

function Install-Pack ($TargetDir, $Label) {
    $PackCount = 0
    if ($PackChoice -eq "1") {
        foreach ($skill in $CoreSkills) {
            if (Copy-DirContents (Join-Path $AwesomeSkillsDir "skills\$skill") (Join-Path $TargetDir $skill)) { $PackCount++ }
        }
        if ($PackCount -lt $CoreSkills.Count) {
            Write-Host "  Warning: expected $($CoreSkills.Count) Core Pack skills but installed $PackCount. The upstream skills repository may be unavailable." -ForegroundColor Yellow
        }
    } else {
        if (Test-Path (Join-Path $AwesomeSkillsDir "skills")) {
            Get-ChildItem -Directory (Join-Path $AwesomeSkillsDir "skills") -ErrorAction SilentlyContinue | ForEach-Object {
                if (Copy-DirContents $_.FullName (Join-Path $TargetDir $_.Name)) { $PackCount++ }
            }
        }
    }
    Set-VaultPathPlaceholder $TargetDir
    Write-Host "  $Label`: installed $PackCount pack skills (plus bundled and companion skills above)"
}

if ($AgentChoice -eq "1" -or $AgentChoice -eq "3") {
    $AgSkillsDir = Join-Path $env:USERPROFILE ".gemini\config\skills"
    Install-Skills $AgSkillsDir
    Install-Pack $AgSkillsDir "Antigravity"
}

if ($AgentChoice -eq "2" -or $AgentChoice -eq "3") {
    $ClaudeSkillsDir = Join-Path $env:USERPROFILE ".claude\skills"
    Install-Skills $ClaudeSkillsDir
    Install-Pack $ClaudeSkillsDir "Claude Code"
}

# --- Install RTK ---
if ($RtkChoice -match "^[yY]") {
    Write-Host "`nInstalling RTK Execution Compression Layer..." -ForegroundColor Cyan
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id rtk-ai.rtk --silent --accept-package-agreements --accept-source-agreements 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  RTK installed via winget."
        } else {
            Write-Host "Warning: 'winget install rtk-ai.rtk' failed. Skipping RTK." -ForegroundColor Yellow
        }
    } else {
        Write-Host "Warning: winget not found. Install RTK manually: https://github.com/rtk-ai/rtk" -ForegroundColor Yellow
    }

    if (Get-Command rtk -ErrorAction SilentlyContinue) {
        if ($AgentChoice -eq "1" -or $AgentChoice -eq "3") { rtk init --agent antigravity 2>$null | Out-Null }
        if ($AgentChoice -eq "2" -or $AgentChoice -eq "3") { rtk init -g 2>$null | Out-Null }
        Write-Host "  RTK initialized."
    }
}

# --- Install Headroom ---
if ($HeadroomChoice -match "^[yY]") {
    Write-Host "`nInstalling Headroom Token Compression Layer..." -ForegroundColor Cyan
    
    $PyCmd = "python"
    if (Get-Command "python3" -ErrorAction SilentlyContinue) { $PyCmd = "python3" }
    
    if (Get-Command $PyCmd -ErrorAction SilentlyContinue) {
        # $PyVer must be assigned before the version check, not just on the success
        # path, or the failure message below reads "Found Python ." with no version.
        $PyVer = & $PyCmd -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')" 2>$null
        & $PyCmd -c "import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)" 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  Found Python $PyVer. Installing headroom-ai[all] via PyPI..."
            & $PyCmd -m pip install "headroom-ai[all]" --quiet
            if ($LASTEXITCODE -eq 0) {
                [Environment]::SetEnvironmentVariable("HEADROOM_OUTPUT_SHAPER", "1", "User")
                Write-Host "  Headroom installed successfully."
                Write-Host "  Output shaper (HEADROOM_OUTPUT_SHAPER=1) enabled in Windows User Environment."
            } else {
                Write-Host "Warning: pip install failed. Retry manually with '$PyCmd -m pip install `"headroom-ai[all]`"'." -ForegroundColor Red
            }
        } else {
            Write-Host "Warning: Found Python $PyVer. Headroom requires Python 3.10+." -ForegroundColor Red
            Write-Host "Please install a newer version of Python and run '$PyCmd -m pip install `"headroom-ai[all]`"' manually." -ForegroundColor Yellow
        }
    } else {
        Write-Host "Warning: 'python' or 'python3' not found. Please install Python 3.10+ and run 'python -m pip install `"headroom-ai[all]`"' manually." -ForegroundColor Red
    }
}

}
finally {
    # --- Cleanup ---
    if (Test-Path $TempDir) { Remove-Item -Recurse -Force $TempDir -ErrorAction SilentlyContinue }
}

# --- Done ---
Write-Host "`n=================================================" -ForegroundColor Green
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green

Write-Host "`nNext steps:" -ForegroundColor White
if ($HeadroomChoice -match "^[yY]") {
    Write-Host "  0. Start your token compressor:" -NoNewline
    Write-Host " Start-Process -NoNewWindow headroom -ArgumentList `"proxy --port 8787`"" -ForegroundColor Cyan
}
Write-Host "  1. Open Obsidian and point it at:" -NoNewline
Write-Host " $VaultPath" -ForegroundColor Cyan

if ($HeadroomChoice -match "^[yY]") {
    Write-Host "  2. Start your agent (configure API base URL to " -NoNewline
    Write-Host "http://localhost:8787" -ForegroundColor Cyan -NoNewline
    Write-Host ") and type: " -NoNewline
    Write-Host "/resume" -ForegroundColor Cyan
    Write-Host "     (Note: Antigravity does not support overriding base URL; Headroom proxy only intercepts Claude Code/Cursor/Aider)." -ForegroundColor DarkGray
} else {
    Write-Host "  2. Start your agent and type: " -NoNewline
    Write-Host "/resume" -ForegroundColor Cyan
}
Write-Host "  3. Or start a new research workflow with: " -NoNewline
Write-Host "/research`n" -ForegroundColor Cyan
