# New Project Workflow

## Phase -1: Resolve Output Path
Run `pwd` via Bash to get the current working directory. Set this as
`PROJECT_ROOT`. All `.planning/` paths in this workflow mean:
`{PROJECT_ROOT}/.planning/`

Confirm the output location to the user before proceeding:
> "Planning files will be written to: {PROJECT_ROOT}/.planning/"

If the user wants a different location, ask them to provide an absolute path
and use that as `PROJECT_ROOT` instead.

---

## Phase 0: Idea Document Check
Check if the user passed an `@idea-doc` file via `$ARGUMENTS`.
- If yes: read it in full and hold it as context. Proceed to Phase 1.
- If no: proceed to Phase 1.

---

## Phase 1: Brownfield Detection

### 1.1 — Scan for Existing Code
Check `{PROJECT_ROOT}` for signs of an existing codebase:
- Source files (`.js`, `.ts`, `.py`, `.go`, etc.)
- Config files (`package.json`, `requirements.txt`, `Cargo.toml`, etc.)
- Project structure (`src/`, `lib/`, `app/`, etc.)
- Infrastructure files (`Dockerfile`, `.env.example`, CI configs)

---

### 1.2 — Branch on What Was Found

**A) Idea doc provided + existing code detected:**
→ Proceed to **Phase 1.3** (Gap Analysis)

**B) Existing code detected + no idea doc:**
→ Inform the user that an existing codebase was detected and recommend
mapping it first to understand what's already built before planning.
Ask them:
- "Proceed anyway" — continue to Phase 2 without mapping
- "Exit and map first" — stop here; user should map the codebase
  manually and re-run `/new-project` afterward

**C) No existing code detected:**
→ Proceed to Phase 2 (clean slate)

**D) Idea doc provided + no existing code:**
→ Proceed to Phase 2 (use idea doc as starting context)

---

### 1.3 — Gap Analysis (runs only in case A)

Compare the idea doc against the detected codebase and produce a
structured report:

| Status | Description |
|--------|-------------|
| ✅ Already built | Feature/component exists and matches the spec |
| 🔧 Partially built | Exists but incomplete or differs from spec |
| ❌ Not yet built | Described in idea doc but absent from codebase |
| ⚠️ Diverges from spec | Exists in code but conflicts with idea doc |

Present findings grouped by these four categories. Be specific —
reference file paths, function names, or module names where relevant.

After presenting the report, proceed directly to Phase 2.

---

## Phase 2: Dream Extraction
See [questioning.md](~/.claude/skills/new-project/references/questioning.md)
for the full approach.

**Case A — Idea doc + existing code (came from Phase 1.3):**
Use both the idea doc and the gap analysis report as context. Surface
tensions between the idea doc and existing code where relevant.

**Case B — Existing code, no idea doc (user chose to proceed):**
Be aware an existing codebase was detected. Start with "What do you want
to build?" but follow up to understand what's new vs what already exists.
See the brownfield section of questioning.md.

**Case C — No existing code, no idea doc:**
Start from scratch. Begin with "What do you want to build?"

**Case D — Idea doc, no existing code:**
Use the idea doc as the starting context. Do not treat it as complete —
use it as a foundation to ask clarifying and deepening questions.

Ask one question at a time. Follow threads naturally. Stop only when the
user says they are done.

---

## Phase 3: Summary & Approval
Present a project summary and ask for approval before proceeding:
```
## Project Summary
**Vision:** [one sentence]
**Problem:** [what problem this solves and for whom]
**Core concept:** [what you're actually building]
**Key goals:** [what success looks like]
**Notable insights:** [anything interesting that emerged]
```

Use AskUserQuestion:
- "Yes, proceed" — move to Phase 4
- "No, let me adjust" — update summary and ask again

Do not proceed until explicitly approved.

Write `{PROJECT_ROOT}/.planning/PROJECT.md` immediately after approval.
See [project-file.md](~/.claude/skills/new-project/references/project-file.md)
for the template.

---

## Phase 4: Research
Use AskUserQuestion to ask the user if they want research done:

- header: "Research"
- question: "Would you like me to research the domain before defining
  architecture and requirements? This spawns 4 parallel agents and takes
  a few minutes but produces better results."
- options:
  - "Yes, research first" — proceed with research
  - "No, skip research" — proceed to Phase 5

**If "Yes, research first":**

Create research directory:
```bash
mkdir -p {PROJECT_ROOT}/.planning/research
```

Spawn 4 parallel Task calls using the `researcher` agent:
```
Task 1 — Stack research
Agent: researcher
Prompt: "Research the standard 2025 tech stack for [domain derived
from project summary].
Include specific libraries, versions, and rationale.
Note what NOT to use and why.
Write to: {PROJECT_ROOT}/.planning/research/STACK.md"

Task 2 — Features research
Agent: researcher
Prompt: "Research what features [domain] products typically have.
Categorise into: table stakes / differentiators / anti-features.
Note complexity and dependencies between features.
Write to: {PROJECT_ROOT}/.planning/research/FEATURES.md"

Task 3 — Architecture research
Agent: researcher
Prompt: "Research how [domain] systems are typically structured.
Cover component boundaries, data flow, and build order.
Write to: {PROJECT_ROOT}/.planning/research/ARCHITECTURE.md"

Task 4 — Pitfalls research
Agent: researcher
Prompt: "Research what [domain] projects commonly get wrong.
For each pitfall: warning signs, prevention strategy, which phase
to address it in.
Write to: {PROJECT_ROOT}/.planning/research/PITFALLS.md"
```

After all 4 complete, spawn synthesizer:
```
Task 5 — Synthesize research
Agent: synthesizer
Prompt: "Read all 4 research files and produce a concise summary.
- {PROJECT_ROOT}/.planning/research/STACK.md
- {PROJECT_ROOT}/.planning/research/FEATURES.md
- {PROJECT_ROOT}/.planning/research/ARCHITECTURE.md
- {PROJECT_ROOT}/.planning/research/PITFALLS.md
Write to: {PROJECT_ROOT}/.planning/research/SUMMARY.md"
```

Present key findings to the user before proceeding:
```
## Research Complete
**Recommended stack:** [from SUMMARY.md]
**Table stakes features:** [from SUMMARY.md]
**Watch out for:** [from SUMMARY.md]
```

**If "No, skip research":** proceed directly to Phase 5.

---

## Phase 5: Architecture
See [architecture-file.md](~/.claude/skills/new-project/references/architecture-file.md)
for the template and update rules.

See [architecture-diagrams.md](~/.claude/skills/new-project/references/architecture-diagrams.md)
when drawing any diagrams.

**If research exists:** use findings from
`{PROJECT_ROOT}/.planning/research/ARCHITECTURE.md` and
`{PROJECT_ROOT}/.planning/research/STACK.md` as the foundation.
Do not re-research — synthesise into the architecture document.

**If no research:** derive architecture direction from dream extraction
(Phase 2) and the project summary (Phase 3).

Before drafting, derive the key architectural decisions from what was
learned during dream extraction and research (if run). Do not ask the
user open-ended questions — you already have the context. Instead,
present your derived decisions to the user for confirmation using
AskUserQuestion:
```
Based on our conversation, here's what I'm planning to build with:

**Tech stack:** [derived from dream extraction / research]
**Major components:** [derived from dream extraction / research]
**Hard constraints:** [derived from dream extraction / research]

Does this look right, or would you like to adjust anything before
I draft the architecture?
```

Options:
- "Yes, looks right" — proceed to draft
- "Let me adjust" — take corrections, update decisions, confirm again

Once confirmed, draft and write `{PROJECT_ROOT}/.planning/ARCHITECTURE.md`.
Ask for a final approval on the written document before proceeding to Phase 6.

---

## Phase 6: Requirements
See [requirements-file.md](~/.claude/skills/new-project/references/requirements-file.md)
for REQ-ID format and template.

**If research exists:** scope features per category (v1 / v2 / out of scope)
using AskUserQuestion, drawing from
`{PROJECT_ROOT}/.planning/research/FEATURES.md`.

**If no research:** gather requirements through conversation.

Present full requirements list and ask for approval before writing.

Write `{PROJECT_ROOT}/.planning/REQUIREMENTS.md` immediately after
approval.

---

## Phase 7: Roadmap
See [roadmap-file.md](~/.claude/skills/new-project/references/roadmap-file.md)
for template and structure.

Spawn the `roadmapper` agent via Task:
```
Task: Create roadmap
Agent: roadmapper
Prompt: "
Create a roadmap from the context below.
Follow the template in:
~/.claude/skills/new-project/references/roadmap-file.md

Read the following files:
- {PROJECT_ROOT}/.planning/PROJECT.md
- {PROJECT_ROOT}/.planning/ARCHITECTURE.md
- {PROJECT_ROOT}/.planning/REQUIREMENTS.md
- {PROJECT_ROOT}/.planning/research/SUMMARY.md (if exists)

Write the completed roadmap to:
{PROJECT_ROOT}/.planning/ROADMAP.md

Return ## ROADMAP CREATED with a summary table when done.
Return ## ROADMAP BLOCKED with specific blockers if unable to proceed.
"
```

Present the returned summary table to the user:
```
## Proposed Roadmap

| # | Phase | Sprints | Requirements mapped |
|---|-------|---------|---------------------|
| 1 | [Name] | [N] | [REQ-IDs] |
...

All [X] v1 requirements mapped ✓
```

Use AskUserQuestion:
- "Approve" — proceed to Phase 8
- "Adjust phases" — provide feedback, re-spawn roadmapper with notes
- "Review full roadmap" — display full ROADMAP.md then ask again

Loop until approved.

---

## Phase 8: STATE.md & Completion

Write `{PROJECT_ROOT}/.planning/STATE.md` using the template in
[state-file.md](~/.claude/skills/new-project/references/state-file.md).

Confirm to the user which files were created:
```
## Project Initialised ✓

Files created:
- {PROJECT_ROOT}/.planning/PROJECT.md        (Phase 3)
- {PROJECT_ROOT}/.planning/ARCHITECTURE.md   (Phase 5)
- {PROJECT_ROOT}/.planning/REQUIREMENTS.md   (Phase 6)
- {PROJECT_ROOT}/.planning/ROADMAP.md        (Phase 7)
- {PROJECT_ROOT}/.planning/STATE.md          (Phase 8)
- {PROJECT_ROOT}/.planning/research/         (Phase 4, if research was run)
```