# Execute Phase Workflow

## Step 0: Load Context
Set `PROJECT_ROOT` to the current working directory. All file paths in this workflow are relative to it.

Run the following before doing anything else (`mkdir -p` is safe — skips creation if the directory already exists):
```
mkdir -p {PROJECT_ROOT}/.failures
mkdir -p {PROJECT_ROOT}/tests
mkdir -p {PROJECT_ROOT}/src
```

Then read the following files in full:
- `{PROJECT_ROOT}/.planning/ROADMAP.md`
- `{PROJECT_ROOT}/.planning/STATE.md`
- `{PROJECT_ROOT}/.planning/PROJECT.md`
- `{PROJECT_ROOT}/.planning/ARCHITECTURE.md`
- `{PROJECT_ROOT}/.planning/REQUIREMENTS.md`
- `{PROJECT_ROOT}/.failures/failure-log.md` — read if it exists, skip silently if not

Determine the target phase from `$ARGUMENTS`. If no phase number was
provided, ask the user which phase to execute.

---

## Step 1: Analyse Sprint Dependencies

Read the target phase from ROADMAP.md. Extract all sprints and map their
dependencies:

- **Independent sprints** — no dependency on another sprint in this phase;
  can run in parallel
- **Dependent sprints** — requires output from a prior sprint; must run
  sequentially after its dependency completes

Produce a dependency map:
```
Phase [N]: [Phase Name]
├── Sprint 1 — [Name] (independent)
├── Sprint 2 — [Name] (independent)
└── Sprint 3 — [Name] (depends on Sprint 1)
```

---

## Step 2: Execution Plan & Confirmation

Present the execution plan to the user before starting:
```
## Phase [N] Execution Plan

**Goal:** [phase goal from ROADMAP.md]
**Sprints:** [total count]
**Success criteria:** [from ROADMAP.md]

### Sprint Order
| Sprint | Name | Mode | Depends On |
|--------|------|------|------------|
| 1 | [Name] | Parallel | — |
| 2 | [Name] | Parallel | — |
| 3 | [Name] | Sequential | Sprint 1 |

Each sprint will be followed by a test run and audit before you approve it.
```

Use AskUserQuestion:
- "Start execution" — proceed to Step 3
- "I have questions first" — answer then re-present plan and ask again

Do not begin execution until explicitly confirmed.

---

## Step 3: Execute Sprints

Work through sprints in the order determined by Step 1.

- **Parallel sprints:** each triggers Step 3.2 individually as it returns —
  do not wait for other parallel sprints to complete first.
- **Sequential sprints:** complete the full 3.2 → 3.3 → 3.4 cycle before
  spawning the next sprint.

### 3.1 — Run Sprint

**Independent sprints (parallel):**
Spawn all independent sprints as parallel Task calls using the
`execution-agent`:
```
Task: Execute Sprint [N]
Agent: execution-agent
Prompt: "
Execute Sprint [N]: [Sprint Name]

Tasks:
[list of tasks from ROADMAP.md for this sprint]

Read for context:
- {PROJECT_ROOT}/.planning/ARCHITECTURE.md
- {PROJECT_ROOT}/.planning/REQUIREMENTS.md
- Any existing src/ files relevant to this sprint

Write all output to: {PROJECT_ROOT}/src/
Mirror the component structure defined in ARCHITECTURE.md.
Do not write tests. Do not modify .planning/ files.

Return:
## SPRINT COMPLETE
**Files created:** [list]
**Files modified:** [list]
**What was implemented:** [plain English summary]
"
```

**Dependent sprints (sequential):**
Spawn one at a time, only after the specific sprint it depends on has been
approved in Step 3.4 — not merely completed. Other parallel sprints may still
be running; only the dependency relationship matters, not global completion.

For parallel sprints: each is tested, audited, and approved individually as
it returns. Do not wait for all parallel sprints to finish before beginning
Step 3.2 on the first one that completes.

---

### 3.2 — Test & Audit

Once the execution agent returns `## SPRINT COMPLETE`, spawn test and
audit agents in parallel:
```
Task: Test Sprint [N]
Agent: test-agent
Prompt: "
Sprint [N] has just been implemented. Run tests for it.

Files implemented:
[list from execution agent response]

Read for context:
- {PROJECT_ROOT}/.planning/PROJECT.md
- {PROJECT_ROOT}/.planning/ARCHITECTURE.md

Write tests to: {PROJECT_ROOT}/tests/
Mirror the src/ structure exactly.

Run all tests after writing them and return results.

Return:
## TESTS PASSED
**Tests written:** [list]
**Coverage:** [%]

OR

## TESTS FAILED
**Tests written:** [list]
**Failures:** [what failed and why]
"
```
```
Task: Audit Sprint [N]
Agent: audit-agent
Prompt: "
Audit the code written for Sprint [N].

Files to audit:
[list from execution agent response]

Read for reference:
- {PROJECT_ROOT}/.planning/ARCHITECTURE.md
- {PROJECT_ROOT}/.planning/REQUIREMENTS.md

Return findings in three categories:
## AUDIT COMPLETE

**Critical** (blocks approval):
- [finding — file — line if relevant]

**Warning** (should fix, does not block):
- [finding]

**Suggestion** (optional improvement):
- [finding]

**Requirements check:** [which REQ-IDs are satisfied by this sprint]
**Architecture alignment:** [compliant / deviations noted]
"
```

---

### 3.3 — Handle Results

Evaluate the combined test and audit results.

**Priority rule:** if tests fail, fix tests first — do not process audit
findings until tests pass. Rewriting failing code makes audit findings on
that code irrelevant.



**If tests passed + no critical audit findings:**
→ Proceed to Step 3.4 (sprint approval)

**If tests failed:**
→ Spawn a second `execution-agent` Task with a different approach:
```
Task: Fix Sprint [N] — Attempt 2
Agent: execution-agent
Prompt: "
Your previous implementation of Sprint [N] failed tests.

Original implementation:
[files from attempt 1]

Test failures:
[failures from test-agent]

Try a different approach. Do not repeat the same implementation.
Overwrite the previous files if needed.

Read for context:
- {PROJECT_ROOT}/.planning/ARCHITECTURE.md
- {PROJECT_ROOT}/.planning/REQUIREMENTS.md
- Any existing src/ files relevant to this sprint

Return:
## SPRINT COMPLETE
[same format as before]
"
```
Re-run test and audit agents after attempt 2.

If tests pass but critical audit findings exist → proceed to the
"If critical audit findings exist" path below.

If tests still fail after attempt 2 → append a Test Failure entry to
`{PROJECT_ROOT}/.failures/failure-log.md` following the format in
`~/.claude/skills/execute-phase/references/failure-log-format.md`.

Then escalate to user:
```
## Sprint [N] Failed — Your Input Needed

**What was attempted:** [summary of both approaches]
**What is failing:** [plain English]
**Test output:** [failures]

How would you like to proceed?
```
Use AskUserQuestion:
- "Try this approach: [user describes fix]" — spawn execution agent with
  user guidance, then re-run test and audit agents. If this also fails,
  escalate again with the same options (there is no attempt limit on
  user-guided retries — each is a fresh attempt with explicit direction)
- "Skip this sprint" — mark as skipped in STATE.md and continue
- "Abort phase" — stop execution, update STATE.md, report to user

After the user's choice is resolved, update the `**Resolution:**` field of
the failure log entry in-place per the format file.

**If critical audit findings exist:**
→ Spawn execution agent to fix them:
```
Task: Fix Audit Findings — Sprint [N]
Agent: execution-agent
Prompt: "
Fix the following critical findings from an audit of Sprint [N]:

[critical findings from audit-agent]

Files to fix:
[list]

Read for context:
- {PROJECT_ROOT}/.planning/ARCHITECTURE.md
- {PROJECT_ROOT}/.planning/REQUIREMENTS.md
- Any existing src/ files relevant to this sprint

Do not change anything unrelated to these findings.

Return:
## SPRINT COMPLETE
[same format]
"
```
Re-run test and audit agents in parallel after fix (same as Step 3.2). If critical findings still exist after this attempt → append an Audit Failure entry to
`{PROJECT_ROOT}/.failures/failure-log.md` following the format in
`~/.claude/skills/execute-phase/references/failure-log-format.md`.

Then escalate to user:
```
## Sprint [N] Audit Blocked — Your Input Needed

**Critical findings that could not be resolved:**
[list]

How would you like to proceed?
```
Use AskUserQuestion:
- "Try this approach: [user describes fix]" — spawn execution agent with
  user guidance, then re-run test and audit agents. If critical findings
  remain, escalate again with the same options (there is no attempt limit
  on user-guided retries — each is a fresh attempt with explicit direction)
- "Override — approve anyway" — mark findings in STATE.md and proceed
- "Abort phase" — stop execution, update STATE.md, report to user

After the user's choice is resolved, update the `**Resolution:**` field of
the failure log entry in-place per the format file.

Warnings and suggestions — present to user but do not block approval.

---

### 3.4 — Sprint Approval

Present a sprint summary to the user:
```
## Sprint [N] Complete — [Sprint Name]

**Implemented:**
[what was built, in plain English]

**Files created/modified:**
[list]

**Tests:** [X passed, Y failed] — [coverage %]
**Audit:** [clean / warnings noted]

**Warnings (non-blocking):**
[list if any]

**Suggestions:**
[list if any]
```

Use AskUserQuestion:
- "Approve — next sprint" — update STATE.md, proceed to next sprint
- "Approve — show warnings first" — display warnings in full, then ask again
- "Request fixes" — describe what to fix, re-spawn execution agent,
  re-test, re-audit, re-present

Update STATE.md immediately after approval:
- Mark sprint as complete
- Update current position
- Log any warnings or suggestions as pending todos

---

## Step 4: Phase Completion

Once all sprints are approved, verify against ROADMAP.md success criteria:
```
## Phase [N] Complete

**Success criteria:**
- [x] [criterion 1]
- [x] [criterion 2]
- [ ] [criterion 3 — note if unmet and why]

**Requirements satisfied this phase:**
[REQ-IDs]

**Ready for next phase:** Phase [N+1] — [Name]
Prerequisites: [from ROADMAP.md]
```

Update ROADMAP.md:
- Mark phase as complete in the progress table

Update STATE.md:
- Update current position to next phase
- Clear sprint progress
- Log session summary