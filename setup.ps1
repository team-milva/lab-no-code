# Milva Lab — Non-developer workspace setup (Windows)
# Run with:
#   irm https://raw.githubusercontent.com/team-milva/lab-no-code/master/setup.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "Milva Lab — Workspace Setup" -ForegroundColor White
Write-Host "-------------------------------------------"
Write-Host ""

# ── 0. Choose install location ──────────────────────────────────────────────
$defaultDest = "$env:USERPROFILE\lab-workspace"
Write-Host "Where should the workspace be installed?"
Write-Host "  Press Enter to use the default: $defaultDest" -ForegroundColor Cyan
Write-Host ""
$destInput = Read-Host "Folder path"
$DEST = if ($destInput.Trim() -ne '') { $destInput.Trim() } else { $defaultDest }
Write-Host ""
Write-Host "Installing to: $DEST" -ForegroundColor Cyan
Write-Host ""

# ── 1. VS Code ───────────────────────────────────────────────────────────────
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
  Write-Host "x VS Code is not installed (or the 'code' command is not set up)." -ForegroundColor Red
  Write-Host ""
  Write-Host "  1. Install VS Code from https://code.visualstudio.com"
  Write-Host "  2. During install, check 'Add to PATH'"
  Write-Host "  3. Re-run this script."
  Read-Host "Press Enter to exit"
  exit 1
}
Write-Host "v VS Code" -ForegroundColor Green

# ── 2. Git ───────────────────────────────────────────────────────────────────
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host "x Git is not installed." -ForegroundColor Red
  Write-Host "  Install it from https://git-scm.com and re-run this script."
  Read-Host "Press Enter to exit"
  exit 1
}
Write-Host "v Git" -ForegroundColor Green

# ── 3. GitHub CLI (gh) ───────────────────────────────────────────────────────
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Write-Host ""
  Write-Host "GitHub CLI is not installed. Installing via winget..." -ForegroundColor Yellow
  try {
    winget install --id GitHub.cli --accept-source-agreements --accept-package-agreements
    # Refresh PATH so gh is immediately available
    $env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")
  } catch {
    Write-Host "x Could not install GitHub CLI automatically." -ForegroundColor Red
    Write-Host "  Please install it from https://cli.github.com and re-run this script."
    Read-Host "Press Enter to exit"
    exit 1
  }
}
Write-Host "v GitHub CLI" -ForegroundColor Green

# ── 4. GitHub login ──────────────────────────────────────────────────────────
gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
  Write-Host ""
  Write-Host "You need to log in to GitHub." -ForegroundColor Yellow
  Write-Host "A browser window will open — follow the steps there and come back when done."
  Write-Host ""
  gh auth login --hostname github.com --git-protocol https --web
}
Write-Host "v GitHub authenticated" -ForegroundColor Green

# ── 5. Fork + clone ──────────────────────────────────────────────────────────
if (Test-Path "$DEST\.git") {
  Write-Host "v lab-workspace already cloned at $DEST" -ForegroundColor Green
} else {
  Write-Host ""
  Write-Host "Forking and cloning lab-workspace into $DEST ..." -ForegroundColor Cyan
  $parentDir = Split-Path $DEST -Parent
  if (-not (Test-Path $parentDir)) { New-Item -ItemType Directory -Path $parentDir -Force | Out-Null }
  Set-Location $parentDir
  gh repo fork team-milva/lab-workspace --clone --fork-name (Split-Path $DEST -Leaf)
}

# ── 6. Open VS Code ──────────────────────────────────────────────────────────
Write-Host ""
Write-Host "Opening VS Code..." -ForegroundColor Cyan
code "$DEST\lab-nocode-workspace.code-workspace"

Write-Host ""
Write-Host "All done!" -ForegroundColor Green
Write-Host ""
Write-Host "  VS Code is opening with the Milva Lab workspace."
Write-Host "  Once it's open, type ""start"" to GitHub Copilot to finish setting up."
Write-Host ""
Read-Host "Press Enter to close"
