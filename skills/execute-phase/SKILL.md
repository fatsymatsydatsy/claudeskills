---
name: execute-phase
description: Executes a single phase of a project built with the new-project skill. Reads the planning files, maps sprint dependencies, runs sprints via execution agents, tests and audits each sprint, and walks the user through approval before moving to the next sprint.
allowed-tools: Read, Write, Bash, AskUserQuestion, Task
model: sonnet
disable-model-invocation: true
argument-hint: [phase-number]
---

## Overview

Executes one phase of a project by:
- Reading `.planning/` files to understand the phase and its sprints
- Mapping sprint dependencies to determine parallel vs sequential execution
- Spawning execution, test, and audit agents per sprint
- Walking the user through approval after each sprint
- Updating `STATE.md` and `ROADMAP.md` on completion

## Guidelines

Follow the workflow outlined in
[execute-phase-workflow.md](~/.claude/skills/execute-phase/references/execute-phase-workflow.md)

## References
- [execute-phase-workflow.md](~/.claude/skills/execute-phase/references/execute-phase-workflow.md) — full step-by-step workflow
- [failure-log-format.md](~/.claude/skills/execute-phase/references/failure-log-format.md) — failure log entry format

## Success Criteria
- [ ] All sprints in the phase approved by user
- [ ] `STATE.md` updated after each sprint approval
- [ ] `ROADMAP.md` marked with phase complete
- [ ] Phase success criteria verified against `ROADMAP.md`
