# Project File Guide
This file defines the template for generating `.planning/PROJECT.md`.

PROJECT.md is written in Phase 3 immediately after the user approves the
project summary. It captures the project vision and scope. Architecture
details live in ARCHITECTURE.md; detailed requirements live in REQUIREMENTS.md.

---

## Template
```markdown
# [Project Name]

## Vision
[One sentence. What is this and who is it for?]

## Problem
[What problem does this solve and for whom? Use the user's own language.]

## Core Concept
[What are you actually building? Concrete enough to explain to a stranger.]

## Key Goals
[What does success look like? What must be true when this is done?]

## Scope

### In Scope
- [High-level capability 1]
- [High-level capability 2]

### Out of Scope
- [Exclusion 1] — [why]
- [Exclusion 2] — [why]

## Constraints
- **[Type]**: [What] — [Why]

Common types: Tech stack, Timeline, Budget, Dependencies, Compatibility,
Performance, Security

## Notable Insights
[Anything interesting or non-obvious that emerged during dream extraction.]

## References
- Architecture: `.planning/ARCHITECTURE.md`
- Requirements: `.planning/REQUIREMENTS.md`
- Roadmap: `.planning/ROADMAP.md`

*Last updated: [date] — [what changed]*
```
