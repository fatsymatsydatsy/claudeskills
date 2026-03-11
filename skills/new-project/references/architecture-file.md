# Architecture File Guide

This file defines the template for generating `.planning/ARCHITECTURE.md`.

ARCHITECTURE.md is the technical source of truth for how the system is built.
It follows the C4 model — describing the system from high-level context down
to component detail. It is a living document — update it whenever the
architecture changes. Always reflect current state, never history.

For diagram examples and conventions, see
[architecture-diagrams.md](~/.claude/skills/new-project/references/architecture-diagrams.md).

---

## Update Rules

- Update whenever a new component, service, or integration is added
- Update whenever the data flow or database schema changes
- Update whenever infrastructure or deployment changes
- Always update the `Last updated` footer with what changed
- Never track history — overwrite with current state

---

## Template
```markdown
# Architecture: [Project Name]

## System Context
[One paragraph — what the system does, who uses it, what external systems
it interacts with. Understandable by anyone, not just developers.]

[Context diagram — see architecture-diagrams.md]

---

## Tech Stack

| Layer | Technology | Rationale |
|-------|-----------|-----------|
| Frontend | [e.g. React] | [why] |
| Backend | [e.g. Node.js] | [why] |
| Database | [e.g. PostgreSQL] | [why] |
| Infrastructure | [e.g. AWS] | [why] |

---

## Components

[The major deployable parts of the system and how they interact.
Each component is a separately deployable or runnable unit.]

[Component diagram — see architecture-diagrams.md]

### [Component Name]
**What it is:** [One sentence]
**Responsibility:** [What this component owns and does]
**Talks to:** [Other components and how]

---

## Data Flow

[How data moves through the system for core user journeys.
Focus on the most important flows — not every possible path.]

### [Flow Name]
[Data flow diagram — see architecture-diagrams.md]

---

## Database Schema

[High-level data models and relationships. Always reflect current schema.]
```
[Entity A]
- id: uuid (PK)
- field: type

[Entity B]
- id: uuid (PK)
- entity_a_id: uuid (FK → Entity A)
- field: type
```

**Relationships:**
- [Entity A] has many [Entity B]
- [Entity B] belongs to [Entity A]

---

## Infrastructure & Deployment

### Environments
| Environment | Purpose | URL |
|-------------|---------|-----|
| Development | Local | localhost |
| Staging | Pre-production | [URL] |
| Production | Live | [URL] |

### Deployment
[How the system is deployed — CI/CD, hosting, containerisation.]

### Scaling
[How the system handles load. What scales horizontally? Any caching?]

---

## Third Party Integrations

| Service | Purpose | How it connects |
|---------|---------|----------------|
| [e.g. Stripe] | [Payments] | [REST API via backend] |
| [e.g. SendGrid] | [Email] | [SMTP / API] |

---

*Last updated: [date] — [what changed]*
```