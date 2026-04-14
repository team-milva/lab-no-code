# Milva Lab — Workspace Setup

---

## Step 1 — Install VS Code

Download and install VS Code from [code.visualstudio.com](https://code.visualstudio.com).

**Mac:** After installing, open VS Code, press `Cmd + Shift + P`, and run:
**Shell Command: Install 'code' command in PATH**

**Windows:** During installation, make sure **"Add to PATH"** is checked.

---

## Step 2 — Run the setup script

### Mac

**Step 1** — Open Terminal (press `Cmd + Space`, type "Terminal", press Enter) and run:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/team-milva/lab-no-code/master/setup.sh)"
```

**Step 2** — Follow any prompts (a browser window may open to log in to GitHub).

**Step 3** — Once VS Code opens, type **"start"** to GitHub Copilot in the chat panel to finish.

---

### Windows

**Step 1** — Open PowerShell (press `Win + R`, type "powershell", press Enter) and run:

```powershell
irm https://raw.githubusercontent.com/team-milva/lab-no-code/master/setup.ps1 | iex
```

**Step 2** — Follow any prompts (a browser window may open to log in to GitHub).

**Step 3** — Once VS Code opens, type **"start"** to GitHub Copilot in the chat panel to finish.

---

## Files in this repo

| File | Description |
|---|---|
| `setup.sh` | Mac setup script — installs prerequisites, forks and clones the workspace, opens VS Code |
| `setup.ps1` | Windows setup script — same as `setup.sh` but for PowerShell |
