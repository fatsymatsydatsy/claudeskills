# Failure Report Format

All failures that reach escalation (after 2 attempts) are logged to:
`{PROJECT_ROOT}/.failures/failure-log.md`

Entries are appended — never overwrite existing entries. If the file does
not exist, create it before writing.

---

## Test Failure Entry

Use this format when tests fail after 2 execution attempts:

```
## Sprint [N] — [Sprint Name] — [YYYY-MM-DD]
**Type:** Test failure
**Phase:** [N]
**Attempts:** 2

**What was being built:**
[one sentence — what this sprint was implementing]

**What failed:**
[plain English — what the tests expected vs what happened]

**Attempt 1 approach:**
[one sentence — how the execution agent approached it]

**Attempt 2 approach:**
[one sentence — what different approach was tried]

**Test output (attempt 2):**
[paste failing test output — truncate to relevant lines if long]

**Status:** ⚠️ Escalated to user
**Resolution:** [fill in after resolved — e.g. "User guided fix — resolved" or "Skipped"]
```

---

## Audit Failure Entry

Use this format when critical audit findings cannot be resolved after 1
fix attempt:

```
## Sprint [N] — [Sprint Name] — [YYYY-MM-DD]
**Type:** Audit blocked
**Phase:** [N]
**Fix attempts:** 1

**What was being built:**
[one sentence — what this sprint was implementing]

**Unresolved critical findings:**
- [finding — file — line if relevant]
- [finding — file — line if relevant]

**Fix approach:**
[one sentence — what was changed in the fix attempt]

**Status:** ⚠️ Escalated to user
**Resolution:** [fill in after resolved — e.g. "User guided fix — resolved" or "Override approved"]
```

---

## Resolution Updates

When a failure is resolved after escalation, update the `**Resolution:**`
field of the relevant entry in-place. Do not append a new entry.

Valid resolution values:
- `User guided fix — resolved on [date]`
- `Skipped — [brief reason]`
- `Override approved — [brief reason]`
- `Aborted phase`

---

## Writing Guidelines

- **Plain English first** — the "What failed" and "What was being built"
  fields are for a human reading this later, not for debugging. Avoid
  technical jargon in these fields.
- **Be specific in findings** — always include file name and line number
  for audit findings where available.
- **Truncate ruthlessly** — test output should be the failing assertion
  and error message only. Do not paste full test suite output.
- **One entry per escalation** — if the same sprint fails tests AND has
  audit findings, write two separate entries.