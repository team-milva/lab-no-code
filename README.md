# Milva Lab — Workspace Setup

---

## Mac

**Step 1** — Open Terminal (press `Cmd + Space`, type "Terminal", press Enter) and run:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/team-milva/lab-no-code/master/setup.sh)"
```

> **Alternative:** Right-click [this link](https://github.com/team-milva/lab-no-code/raw/master/install.command) → "Download Linked File", then double-click the downloaded file.
> If macOS blocks it: right-click → Open → Open

**Step 2** — Follow any prompts (a browser window may open to log in to GitHub).

**Step 3** — Once VS Code opens, type **"start"** to GitHub Copilot in the chat panel to finish.

---

## Windows

**Step 1** — Open PowerShell (press `Win + R`, type "powershell", press Enter) and run:

```powershell
irm https://raw.githubusercontent.com/team-milva/lab-no-code/master/setup.ps1 | iex
```

> **Alternative:** Right-click [this link](https://github.com/team-milva/lab-no-code/raw/master/install.bat) → "Save link as", then double-click the downloaded file.
> If Windows asks "Do you want to allow this app to make changes?" — click Yes

**Step 2** — Follow any prompts (a browser window may open to log in to GitHub).

**Step 3** — Once VS Code opens, type **"start"** to GitHub Copilot in the chat panel to finish.

---

## Files in this repo

| File | Description |
|---|---|
| `install.command` | Mac double-click installer — opens Terminal and runs the setup script |
| `install.bat` | Windows double-click installer — opens PowerShell and runs the setup script |
| `setup.sh` | Mac setup script — installs prerequisites, forks and clones the workspace, opens VS Code |
| `setup.ps1` | Windows setup script — same as `setup.sh` but for PowerShell |
