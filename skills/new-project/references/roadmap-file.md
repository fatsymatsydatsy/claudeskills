# Roadmap File Guide

This file defines the template for generating `.planning/ROADMAP.md`.

---

## Phase Numbering

- **Integer phases** (1, 2, 3): Planned milestone work
- **Decimal phases** (2.1, 2.2): Urgent insertions between planned phases,
  marked with INSERTED
- Phases execute in numeric order: 1 → 2 → 2.1 → 2.2 → 3

---

## Sprint & Task Rules

- Each phase contains one or more sprints
- Each sprint contains specific, actionable tasks
- Tasks must be concrete enough to execute without further clarification
- Every v1 REQ-ID must be mapped to exactly one phase

---

## Template
```markdown
# Roadmap: [Project Name]

## Overview
[One paragraph describing the journey from start to finish.]

## Phases

- [ ] **Phase 1: [Name]** — [One-line description]
- [ ] **Phase 2: [Name]** — [One-line description]
- [ ] **Phase 3: [Name]** — [One-line description]

## Phase Details

### Phase 1: [Name]
**Goal**: [What this phase delivers]
**Requirements**: [REQ-IDs]

**Success Criteria** (what must be TRUE before moving on):
- [ ] [Condition 1]
- [ ] [Condition 2]

**Prerequisites for next phase**:
- [What must be in place before Phase 2 can start]
- [What must be in place before Phase 2 can start]

#### Sprint 1: [Name]
- [ ] [Task]
- [ ] [Task]

#### Sprint 2: [Name]
- [ ] [Task]
- [ ] [Task]

---

### Phase 2: [Name]
**Goal**: [What this phase delivers]
**Requirements**: [REQ-IDs]

**Success Criteria** (what must be TRUE before moving on):
- [ ] [Condition 1]
- [ ] [Condition 2]

**Prerequisites for next phase**:
- [What must be in place before Phase 3 can start]

#### Sprint 1: [Name]
- [ ] [Task]
- [ ] [Task]

---

### Phase 2.1: [Name] (INSERTED)
**Goal**: [What this urgent insertion delivers]

**Success Criteria** (what must be TRUE before moving on):
- [ ] [Condition 1]

**Prerequisites for next phase**:
- [What must be in place before continuing]

#### Sprint 1: [Name]
- [ ] [Task]
- [ ] [Task]

---

### Phase 3: [Name]
**Goal**: [What this phase delivers]
**Requirements**: [REQ-IDs]

**Success Criteria** (what must be TRUE before moving on):
- [ ] [Condition 1]
- [ ] [Condition 2]

**Prerequisites for next phase**:
- [What must be in place before Phase 4 can start]
- None (final phase)

#### Sprint 1: [Name]
- [ ] [Task]
- [ ] [Task]

## Progress

| Phase | Sprints Complete | Status |
|-------|-----------------|--------|
| 1. [Name] | 0/[N] | Not started |
| 2. [Name] | 0/[N] | Not started |
| 3. [Name] | 0/[N] | Not started |
```