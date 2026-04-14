#!/bin/bash
# Milva Lab — Non-developer workspace setup
# Run with:
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/team-milva/lab-no-code/main/setup.sh)"

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

DEST="$HOME/lab-workspace"

echo ""
echo -e "${BOLD}Milva Lab — Workspace Setup${NC}"
echo "-------------------------------------------"
echo ""

# ── 1. VS Code ──────────────────────────────────────────────────────────────
if ! command -v code &>/dev/null; then
  echo -e "${RED}✗ VS Code is not installed (or the 'code' command is not set up).${NC}"
  echo ""
  echo "  1. Install VS Code from https://code.visualstudio.com"
  echo "  2. Open VS Code, press Cmd+Shift+P"
  echo "     and run: Shell Command: Install 'code' command in PATH"
  echo "  3. Re-run this script."
  exit 1
fi
echo -e "${GREEN}✓ VS Code${NC}"

# ── 2. Git ───────────────────────────────────────────────────────────────────
if ! command -v git &>/dev/null; then
  echo -e "${YELLOW}Git is not installed. Triggering Xcode Command Line Tools install...${NC}"
  xcode-select --install
  echo ""
  echo "Re-run this script after the installation finishes."
  exit 1
fi
echo -e "${GREEN}✓ Git${NC}"

# ── 3. GitHub CLI (gh) ───────────────────────────────────────────────────────
if ! command -v gh &>/dev/null; then
  echo ""
  echo -e "${YELLOW}GitHub CLI is not installed. Installing via Homebrew...${NC}"
  if ! command -v brew &>/dev/null; then
    echo "  Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH (Apple Silicon)
    [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    # Add Homebrew to PATH (Intel)
    [[ -f /usr/local/bin/brew ]] && eval "$(/usr/local/bin/brew shellenv)"
  fi
  brew install gh
fi
echo -e "${GREEN}✓ GitHub CLI${NC}"

# ── 4. GitHub login ──────────────────────────────────────────────────────────
if ! gh auth status &>/dev/null; then
  echo ""
  echo -e "${YELLOW}You need to log in to GitHub.${NC}"
  echo "A browser window will open — just follow the steps there and come back when done."
  echo ""
  gh auth login --hostname github.com --git-protocol https --web
fi
echo -e "${GREEN}✓ GitHub authenticated${NC}"

# ── 5. Fork + clone ──────────────────────────────────────────────────────────
if [ -d "$DEST/.git" ]; then
  echo -e "${GREEN}✓ lab-workspace already cloned at $DEST${NC}"
else
  echo ""
  echo -e "${BLUE}Forking and cloning lab-workspace into $DEST ...${NC}"
  cd "$HOME"
  gh repo fork team-milva/lab-workspace --clone --fork-name lab-workspace
fi

# ── 6. Open VS Code ──────────────────────────────────────────────────────────
echo ""
echo -e "${BLUE}Opening VS Code...${NC}"
code "$DEST/lab-nocode-workspace.code-workspace"

echo ""
echo -e "${GREEN}${BOLD}All done!${NC}"
echo ""
echo "  VS Code is opening with the Milva Lab workspace."
echo "  Once it's open, type \"start\" to GitHub Copilot to finish setting up."
echo ""
