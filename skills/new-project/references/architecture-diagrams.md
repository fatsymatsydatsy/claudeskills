# Architecture Diagram Guide

Reference this file when drawing diagrams for ARCHITECTURE.md.

---

## Diagram Format

Use ASCII diagrams inside code blocks for all architecture visuals.

Arrow types:
- `──►` Synchronous request / direct call
- `- ->` Asynchronous / event-driven
- `──` Bidirectional / data sync

Label arrows when the relationship needs clarification:
```
[Frontend] ──REST──► [API Server]
[API Server] ──SQL──► [Database]
```

---

## Context Diagram

Shows the system and what it connects to at the highest level:
```
                [User]
                  │
                  ▼
          [Your System]
         /             \
[External Service A]  [External Service B]
```

---

## Component Diagram

Shows major deployable parts and how they communicate:
```
[Frontend App]
      │ REST
      ▼
[API Server] ──── [Background Worker]
      │                   │
      ▼                   ▼
[Primary DB]        [Job Queue]
```

---

## Data Flow Diagrams

### Request / Response Flow
```
[User] ──POST /login──► [API Server]
                              │
                    ──SQL──► [Database]
                              │
                    ◄── JWT ──
                              │
              ◄── 200 + token ──
```

### Async Flow
```
[User uploads file] ──► [API Server] ──► [Job Queue]
                                               │
                                     [Background Worker]
                                               │
                                          [Storage]
```

---

## Deployment Diagram

Shows how the system is hosted and deployed:
```
[Code Push] ──► [CI Pipeline] ──► [Staging] ──► [Production]
                                                      │
                                              [Load Balancer]
                                             /               \
                                      [Server A]         [Server B]
```