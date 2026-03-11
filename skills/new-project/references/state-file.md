# State File Guide

This file defines the template for generating `.planning/STATE.md`.

STATE.md is the project's memory across sessions. Claude reads it at the start
of every session to understand where the project is, what's in progress, and
what comes next. It must always reflect the current state — not history.

---

## Update Rules

- Update after every sprint completion
- Update whenever an agent is spawned or completes
- Update whenever a blocker is added or resolved
- Update whenever a todo is added or completed
- Always update the `Last activity` field and `Last updated` footer
- Never track history — always overwrite with current state

---

## Template
```markdown
# Project State

## Project Reference
See: .planning/PROJECT.md
**Core value:** [One-liner from PROJECT.md]
**Current focus:** [Current phase name]

## Current Position
Phase: [X] of [Y] — [Phase name]
Sprint: [A] of [B] — [Sprint name]
Status: [Ready to plan / In progress / Sprint complete / Phase complete]
Last activity: [YYYY-MM-DD] — [What happened]

### Sprint Progress
- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

## Progress
Sprints completed: [N] of [Total]
[░░░░░░░░░░] 0%

## Session History
### Last 3 Sessions
| Date | What was done | Sprints completed |
|------|--------------|-------------------|
| [YYYY-MM-DD] | - | - |
| [YYYY-MM-DD] | - | - |
| [YYYY-MM-DD] | - | - |

## Active Agents
| Agent | Current Task | Status | Context Usage |
|-------|-------------|--------|---------------|
| [agent-name] | [task] | [Idle / Running / Blocked / Complete] | [X%] |

## Context Usage
**Overall project context:** [X%]
**Per agent:**
| Agent | Context Used |
|-------|-------------|
| [agent-name] | [X%] |

## Pending Todos
- [ ] [Todo 1]

## Blockers
- [ ] [Blocker — what is blocked and why]

*Updated after each sprint completion*
```

---

## Field Guide

**Current Position** — always reflects the live sprint and phase. Update
immediately when moving to a new sprint or phase.

**Sprint Progress** — copy the task list from ROADMAP.md for the current
sprint. Check off tasks as they complete.

**Progress bar** — fill with █ characters as sprints complete.
Example: 3 of 10 sprints done → `[███░░░░░░░] 30%`

**Session History** — keep only the last 3 sessions. Drop the oldest when
adding a new one.

**Active Agents** — list every agent currently spawned. Remove agents once
complete. Status options: Idle / Running / Blocked / Complete.

**Context Usage** — update whenever a new agent is spawned or an existing
one reports usage. Overall context is the main Claude session.

**Pending Todos** — ideas or tasks captured mid-session that don't belong
in the current sprint. Review at the start of each new phase.

**Blockers** — anything stopping forward progress. Remove when resolved.