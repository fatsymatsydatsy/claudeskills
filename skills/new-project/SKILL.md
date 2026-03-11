---
name: new-project
description: Activates at the start of a new project. Gathers deep context about the project idea through targeted questions, then generates a `.planning/` folder that captures the full project description, goals, and scope.
allowed-tools: Read, Write, Bash, AskUserQuestion, Task
model: sonnet
disable-model-invocation: true
argument-hint: [@idea-doc.md]
---

## Overview

Generates a `.planning/` folder as the project's source of truth, containing:
- `PROJECT.md` — project context
- `ARCHITECTURE.md` — system architecture
- `REQUIREMENTS.md` — scoped requirements
- `ROADMAP.md` — phase structure
- `STATE.md` — project memory

## Guidelines

Follow the project workflow outlined in
[new-project-workflow.md](~/.claude/skills/new-project/workflow/new-project-workflow.md)

## References
- [new-project-workflow.md](~/.claude/skills/new-project/workflow/new-project-workflow.md) — full phase-by-phase workflow
- [questioning.md](~/.claude/skills/new-project/references/questioning.md) — dream extraction guide
- [project-file.md](~/.claude/skills/new-project/references/project-file.md) — PROJECT.md template
- [architecture-file.md](~/.claude/skills/new-project/references/architecture-file.md) — ARCHITECTURE.md template
- [architecture-diagrams.md](~/.claude/skills/new-project/references/architecture-diagrams.md) — diagram conventions
- [requirements-file.md](~/.claude/skills/new-project/references/requirements-file.md) — REQUIREMENTS.md template
- [roadmap-file.md](~/.claude/skills/new-project/references/roadmap-file.md) — ROADMAP.md template
- [state-file.md](~/.claude/skills/new-project/references/state-file.md) — STATE.md template

## Success Criteria
- [ ] `.planning/` folder created
- [ ] `PROJECT.md` written and approved
- [ ] `ARCHITECTURE.md` written and approved
- [ ] `REQUIREMENTS.md` written and approved
- [ ] `ROADMAP.md` written and approved
- [ ] `STATE.md` initialised
- [ ] User confirmed completion
