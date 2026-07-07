<#
.SYNOPSIS
AI Research Workflow - Interactive Setup Script for Windows
Version: 4.0.0
#>
$ErrorActionPreference = "Stop"

Write-Host "=================================================" -ForegroundColor Cyan -NoNewline
Write-Host " " -NoNewline
Write-Host "AI-Powered Research Assistant - Setup v4.0.0" -ForegroundColor Cyan -NoNewline
Write-Host " " -NoNewline
Write-Host "=================================================" -ForegroundColor Cyan

# --- Step 1: Agent Selection ---
Write-Host "`nStep 1: Which AI agent do you use?" -ForegroundColor White
Write-Host "  [1] Google Antigravity"
Write-Host "  [2] Claude Code (Anthropic)"
Write-Host "  [3] Both"
$AgentChoice = Read-Host "Select (1/2/3)"

# --- Step 2: Pack Selection ---
Write-Host "`nStep 2: Which skill pack do you want to install?" -ForegroundColor White
Write-Host "  [1] Core Pack (Academic Research - ~38 skills)"
Write-Host "  [2] Full Pack (Enterprise Engineering - 130+ skills)"
$PackChoice = Read-Host "Select (1/2)"

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
Write-Host "  (Note: Proxy interception natively supports Claude Code and Cursor. Antigravity requires MCP mode.)" -ForegroundColor DarkGray
$HeadroomChoice = Read-Host "Install? (y/n) [Recommended: y]"
if ([string]::IsNullOrWhiteSpace($HeadroomChoice)) {
    $HeadroomChoice = "y"
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

$TempDir = Join-Path $env:TEMP "ai-research-setup"
if (Test-Path $TempDir) { Remove-Item -Recurse -Force $TempDir }
New-Item -ItemType Directory -Force -Path $TempDir | Out-Null

$PonytailDir = Join-Path $TempDir "ponytail-plugin"
$AiResearchSkillsDir = Join-Path $TempDir "ai-research-skills"
$AwesomeSkillsDir = Join-Path $TempDir "awesome-skills"
$AegisOpsDir = Join-Path $TempDir "aegisops-ai"

Write-Host "  Cloning repositories..."
git clone --quiet https://github.com/DietrichGebert/ponytail $PonytailDir 2>$null
git clone --quiet https://github.com/Orchestra-Research/AI-Research-SKILLs.git $AiResearchSkillsDir 2>$null
git clone --quiet https://github.com/google/antigravity-awesome-skills.git $AwesomeSkillsDir 2>$null
git clone --quiet https://github.com/Champbreed/AegisOps-AI.git $AegisOpsDir 2>$null

function Install-Skills ($TargetDir) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
    
    $BundledDir = Join-Path $ScriptDir "skills"
    if (Test-Path $BundledDir) {
        Copy-Item -Recurse -Force "$BundledDir\*" $TargetDir 2>$null
    }
    
    if (Test-Path $PonytailDir) { Copy-Item -Recurse -Force $PonytailDir (Join-Path $TargetDir "ponytail") 2>$null }
    if (Test-Path $AegisOpsDir) { Copy-Item -Recurse -Force $AegisOpsDir (Join-Path $TargetDir "aegisops-ai") 2>$null }
    
    if (Test-Path $AiResearchSkillsDir) {
        Copy-Item -Recurse -Force (Join-Path $AiResearchSkillsDir "20-ml-paper-writing\ml-paper-writing") $TargetDir 2>$null
        Copy-Item -Recurse -Force (Join-Path $AiResearchSkillsDir "20-ml-paper-writing\academic-plotting") $TargetDir 2>$null
        Copy-Item -Recurse -Force (Join-Path $AiResearchSkillsDir "22-agent-native-research-artifact\compiler") (Join-Path $TargetDir "ara-compiler") 2>$null
        Copy-Item -Recurse -Force (Join-Path $AiResearchSkillsDir "22-agent-native-research-artifact\manager") (Join-Path $TargetDir "ara-research-manager") 2>$null
        Copy-Item -Recurse -Force (Join-Path $AiResearchSkillsDir "22-agent-native-research-artifact\reviewer") (Join-Path $TargetDir "ara-rigor-reviewer") 2>$null
    }
}

if ($AgentChoice -eq "1" -or $AgentChoice -eq "3") {
    $AgSkillsDir = Join-Path $env:USERPROFILE ".gemini\config\skills"
    Install-Skills $AgSkillsDir
    
    if ($PackChoice -eq "1") {
        $CoreSkills = @("papers-skill", "deep-research", "exa-search", "tavily-web", "research-brainstorming", "creative-thinking", "data-engineering-data-pipeline", "data-engineering-data-driven-feature", "data-structure-protocol", "data-quality-frameworks", "polars", "data-scientist", "data-storytelling", "plotly", "ml-engineer", "ai-ml", "ai-engineering-toolkit", "rag-engineer", "embedding-strategies", "ml-pipeline-workflow", "mlops-engineer", "docker-expert", "devops-deploy", "unit-testing-test-generate", "2slides-ppt-generator", "latex-paper-conversion", "architecture-decision-records", "docs-architect", "graphify", "save-session", "resume-session")
        foreach ($skill in $CoreSkills) {
            $Src = Join-Path $AwesomeSkillsDir "skills\$skill"
            if (Test-Path $Src) { Copy-Item -Recurse -Force $Src $AgSkillsDir 2>$null }
        }
        Write-Host "  Installed Core Pack (~38 skills) to Antigravity"
    } else {
        if (Test-Path $AwesomeSkillsDir) { Copy-Item -Recurse -Force "$AwesomeSkillsDir\skills\*" $AgSkillsDir 2>$null }
        Write-Host "  Installed Full Pack (130+ skills) to Antigravity"
    }
}

if ($AgentChoice -eq "2" -or $AgentChoice -eq "3") {
    $ClaudeSkillsDir = Join-Path $env:USERPROFILE ".claude\skills"
    Install-Skills $ClaudeSkillsDir
    Write-Host "  Installed Claude Code skills"
}

# --- Install Headroom ---
if ($HeadroomChoice -match "^[yY]") {
    Write-Host "`nInstalling Headroom Token Compression Layer..." -ForegroundColor Cyan
    
    $PyCmd = "python"
    if (Get-Command "python3" -ErrorAction SilentlyContinue) { $PyCmd = "python3" }
    
    if (Get-Command $PyCmd -ErrorAction SilentlyContinue) {
        $PyVer = & $PyCmd -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
        if ([double]$PyVer -ge 3.10) {
            Write-Host "  Found Python $PyVer. Installing headroom-ai[all] via PyPI..."
            & $PyCmd -m pip install "headroom-ai[all]" --quiet
            
            [Environment]::SetEnvironmentVariable("HEADROOM_OUTPUT_SHAPER", "1", "User")
            Write-Host "  Headroom installed successfully."
            Write-Host "  Output shaper (HEADROOM_OUTPUT_SHAPER=1) enabled in Windows User Environment."
        } else {
            Write-Host "Warning: Found Python $PyVer. Headroom requires Python 3.10+." -ForegroundColor Red
            Write-Host "Please install a newer version of Python and run '$PyCmd -m pip install `"headroom-ai[all]`"' manually." -ForegroundColor Yellow
        }
    } else {
        Write-Host "Warning: 'python' or 'python3' not found. Please install Python 3.10+ and run 'python -m pip install `"headroom-ai[all]`"' manually." -ForegroundColor Red
    }
}

# --- Cleanup ---
Remove-Item -Recurse -Force $TempDir 2>$null

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
