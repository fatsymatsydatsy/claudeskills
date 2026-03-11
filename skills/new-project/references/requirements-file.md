# Requirements File Guide

This file defines the template and REQ-ID format for generating
`.planning/REQUIREMENTS.md`.

---

## REQ-ID Format

Every requirement gets a unique ID in the format:
```
[CATEGORY]-[NUMBER]
```

- Category: 2-5 uppercase letters representing the feature area
- Number: zero-padded 2-digit number starting at 01

**Examples:**
- `AUTH-01` — first authentication requirement
- `AUTH-02` — second authentication requirement
- `DASH-01` — first dashboard requirement
- `API-01` — first API requirement

Common category names:
| Category | Meaning |
|----------|---------|
| AUTH | Authentication & authorisation |
| USER | User management & profiles |
| DASH | Dashboard & UI |
| API | API endpoints |
| DATA | Data management |
| NOTIF | Notifications |
| BILL | Billing & payments |
| PERF | Performance |

Create new categories as needed. Keep them short and obvious.

---

## Requirement Writing Rules

Each requirement must be:

- **Specific and testable:** "User can reset password via email link" ✓
  — not "Handle password reset" ✗
- **User-centric:** "User can X" — not "System does Y"
- **Atomic:** One capability per requirement
- **Mapped to roadmap:** Every v1 requirement maps to exactly one phase

---

## Template
```markdown
# Requirements

## v1 — In Scope
[Features being built in this version. Every item maps to a phase in ROADMAP.md.]

### [Category Name]
- [ ] **[REQ-ID]**: [User can ...]
- [ ] **[REQ-ID]**: [User can ...]

### [Category Name]
- [ ] **[REQ-ID]**: [User can ...]

## v2 — Deferred
[Features wanted but not in v1. No REQ-IDs needed yet.]

- [Feature] — [why deferred]
- [Feature] — [why deferred]

## Out of Scope
[Explicit boundaries. Include reasoning to prevent re-adding.]

- [Feature] — [why excluded]
- [Feature] — [why excluded]

## Roadmap Traceability
[Maps every v1 REQ-ID to its phase. Filled in after ROADMAP.md is created.]

| REQ-ID | Requirement | Phase |
|--------|-------------|-------|
| [ID] | [brief description] | Phase [N] |
```