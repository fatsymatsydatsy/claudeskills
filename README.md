# Claude Skills & Agents

A collection of custom skills and agents that supercharge Claude Code — helping you plan and build software projects from idea to working code.

---

## What does this give you?

Two commands you can run inside Claude Code:

| Command | What it does |
|---|---|
| `/new-project` | Interviews you about your project idea and creates a full plan (goals, architecture, roadmap) |
| `/execute-phase` | Takes that plan and actually builds the code, one step at a time |

Behind the scenes, a team of AI agents handles the heavy lifting — one writes code, one tests it, one audits it, one does research, and so on.

---

## Before you start — what you need

You need two things installed on your computer:

### 1. Node.js
Node.js lets your computer run JavaScript tools. Claude Code needs it.

- Go to **https://nodejs.org**
- Download the version that says **"LTS"** (the big green button)
- Open the downloaded file and follow the installer steps
- When it's done, restart your computer

### 2. Claude Code
Claude Code is the AI assistant you'll be chatting with. It runs in your Terminal (the black text window).

Open your **Terminal** (on Mac: press `Command + Space`, type "Terminal", press Enter) and paste this command, then press Enter:

```
npm install -g @anthropic-ai/claude-code
```

It will download and install. When it finishes, type:

```
claude --version
```

If you see a version number (like `1.x.x`), it worked.

> **You'll also need an Anthropic account.** Go to **https://claude.ai** and sign up for free. When you first run `claude`, it will ask you to log in.

---

## Installation — adding the skills

### Step 1: Download this repo

Click the green **"Code"** button at the top of this page, then click **"Download ZIP"**.

Unzip the downloaded file. You'll get a folder — remember where it is (e.g. your Downloads folder).

### Step 2: Open Terminal in that folder

**On Mac:**
1. Open the unzipped folder in Finder
2. Right-click on an empty space inside the folder
3. Click **"Open Terminal Here"** (if you don't see this, open Terminal normally and type `cd ` then drag the folder into the Terminal window and press Enter)

**On Windows:**
1. Open the unzipped folder in File Explorer
2. Click the address bar at the top, type `cmd`, press Enter
3. A black Command Prompt window will open

### Step 3: Run the install script

**On Mac/Linux**, paste this and press Enter:
```
bash install.sh
```

**On Windows**, paste this and press Enter:
```
bash install.sh
```
*(If that doesn't work on Windows, see the manual installation below)*

You should see:
```
Done! Skills and agents are installed.
```

That's it — you're set up!

---

## How to use it

### Starting a new project

1. Create a new empty folder somewhere on your computer for your project
2. Open Terminal inside that folder (same steps as above)
3. Type `claude` and press Enter — Claude Code will start
4. Type `/new-project` and press Enter
5. Claude will ask you questions about what you want to build — just answer in plain English!

It will create a `.planning` folder with your full project plan inside.

### Building the project

Once your plan is ready, still inside Claude Code, type:
```
/execute-phase 1
```

This builds Phase 1 of your project. When it's done and you've approved it, run:
```
/execute-phase 2
```

And so on for each phase.

---

## Manual installation (if the script didn't work)

If the install script didn't work, you can copy the files yourself.

You need to copy files into a hidden folder called `.claude` in your home directory.

**On Mac**, your home directory is `/Users/YOUR_NAME/`
**On Windows**, it's `C:\Users\YOUR_NAME\`

Copy the folders like this:

| Copy this | Into here |
|---|---|
| `skills/new-project` | `~/.claude/skills/new-project` |
| `skills/execute-phase` | `~/.claude/skills/execute-phase` |
| `agents/audit-agent.md` | `~/.claude/agents/audit-agent.md` |
| `agents/execution-agent.md` | `~/.claude/agents/execution-agent.md` |
| `agents/researcher.md` | `~/.claude/agents/researcher.md` |
| `agents/roadmapper.md` | `~/.claude/agents/roadmapper.md` |
| `agents/synthesizer.md` | `~/.claude/agents/synthesizer.md` |
| `agents/test-agent.md` | `~/.claude/agents/test-agent.md` |

> **Note:** On Mac, folders starting with `.` are hidden. To see them in Finder, press `Command + Shift + .` to toggle hidden files.

---

## What each agent does (behind the scenes)

You don't need to call these directly — the skills use them automatically. But here's what they do:

| Agent | Role |
|---|---|
| **execution-agent** | Writes the actual source code |
| **test-agent** | Writes and runs tests to make sure the code works |
| **audit-agent** | Reviews the code against your original plan |
| **researcher** | Does research on specific technical topics |
| **roadmapper** | Reads your plan and builds a step-by-step roadmap |
| **synthesizer** | Summarises research into a single concise document |

---

## Troubleshooting

**"command not found: claude"**
Node.js or Claude Code isn't installed correctly. Go back to the installation steps and try again. Make sure you restarted your computer after installing Node.js.

**"Permission denied" when running install.sh (Mac)**
Run this first, then try again:
```
chmod +x install.sh
```

**Claude doesn't recognise `/new-project`**
The skills might not be in the right folder. Check that `~/.claude/skills/new-project/` exists and contains files.

**I don't see the `.claude` folder**
It's a hidden folder. On Mac press `Command + Shift + .` in Finder to show hidden files.

---

## Questions?

If you get stuck, send a message and we'll help you out!
