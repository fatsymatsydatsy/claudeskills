# Dream Extraction Guide

Project initialisation is dream extraction, not requirements gathering. You are
helping the user discover and articulate what they want to build. This is
collaborative thinking, not an interview.

---

## Philosophy

**You are a thinking partner, not an interviewer.**

The user often has a fuzzy idea. Your job is to help them sharpen it. Ask
questions that make them think "oh, I hadn't considered that" or "yes, that's
exactly what I mean."

Don't interrogate. Collaborate. Don't follow a script. Follow the thread.

---

## The Goal

By the end of extraction, you need enough clarity to write a PROJECT.md that
captures:

- **What** they're building (concrete enough to explain to a stranger)
- **Why** it needs to exist (the problem or desire driving it)
- **Who** it's for (even if just themselves)
- **What done looks like** (observable outcomes)
- **The architecture** (enough to inform stack, components, and data flow)

A vague PROJECT.md forces every downstream phase to guess. The cost compounds.

---

## How to Question

**Start open.** Let them dump their mental model. Don't interrupt with
structure. Begin with:

> "What do you want to build?"

**Follow energy.** Whatever they emphasised, dig into that. What excited them?
What problem sparked this?

**Challenge vagueness.** Never accept fuzzy answers.
- "Good" means what?
- "Users" means who?
- "Simple" means how?

**Make the abstract concrete.**
- "Walk me through using this."
- "What does that actually look like?"

**Surface assumptions.** What have they already decided? What are they taking
for granted?

**Know when to stop.** When you understand what they want, why they want it,
who it's for, and what done looks like — offer to proceed.

---

## Question Types

Use these as inspiration, not a checklist. Pick what's relevant to the thread.

**Motivation — why this exists:**
- "What prompted this?"
- "What are you doing today that this replaces?"
- "What would you do if this existed right now?"

**Concreteness — what it actually is:**
- "Walk me through using this"
- "Give me a specific example"
- "You said X — what does that actually look like in practice?"

**Clarification — what they mean:**
- "When you say Z, do you mean A or B?"
- "You mentioned X — tell me more about that"

**Success — how you'll know it's working:**
- "How will you know this is working?"
- "What does done look like?"
- "What would make this feel like a failure?"

**Architecture — only once the idea is clear:**
- "Do you have a stack in mind or should we decide together?"
- "Is this a web app, mobile, API, or something else?"
- "Any hard constraints on tech — things you must or can't use?"

> Only ask architecture questions after the idea is sharp. Never ask about
> tech stack before understanding what's being built.

---

## If a Codebase Already Exists (Brownfield)

If the user skipped codebase mapping and existing code was detected, adjust
your questioning to understand what's already built before exploring what's new.

Use all the questions as inspiration, not a checklist. 

**Understand the existing system first:**
- "What does the existing codebase already do?"
- "What parts are working well that we should keep?"
- "What parts are broken or need replacing?"
- "Is this an extension, a refactor, or a pivot?"

**Understand the gap:**
- "What does the existing system not do that you need?"
- "Where does it break down for users today?"

**Understand constraints from existing code:**
- "Are there parts of the architecture we can't change?"
- "Any integrations or dependencies we have to work around?"

Fold what's already built into the PROJECT.md architecture section as a
starting point — don't treat the existing system as out of scope.

---

## Using AskUserQuestion

Use AskUserQuestion to help users think by presenting concrete options to
react to.

**Good options:**
- Interpretations of what they might mean
- Specific examples to confirm or deny
- Concrete choices that reveal priorities
- 2-4 options maximum

**Bad options:**
- Generic categories ("Technical", "Business", "Other")
- Leading options that presume an answer
- Headers longer than 12 characters

**Example — vague answer:**
User says "it should be fast"
- header: "Fast"
- question: "Fast how?"
- options: ["Sub-second response", "Handles large data", "Quick to build",
  "Let me explain"]

**If the user selects a freeform option ("Let me explain", "Something else"):**
Switch to plain text immediately. Do NOT follow up with another AskUserQuestion.
Wait for them to type freely, then resume structured questions after.

---

## Background Checklist

Use this mentally as the conversation progresses — not as a script to follow.

- [ ] What they're building (concrete)
- [ ] Why it needs to exist
- [ ] Who it's for
- [ ] What done looks like
- [ ] Architecture direction (stack, type of app, key constraints)
- [ ] If brownfield: what exists, what's changing, what's staying

---

## Anti-Patterns

- **Checklist walking** — Going through topics regardless of what they said
- **Canned questions** — "What's your core value?" regardless of context
- **Corporate speak** — "What are your success criteria?" "Who are your stakeholders?"
- **Interrogation** — Firing questions without building on answers
- **Rushing** — Minimising questions to get to the work faster
- **Shallow acceptance** — Taking vague answers without probing
- **Premature constraints** — Asking about tech stack before the idea is clear

---

## Decision Gate

When you have enough to write a clear PROJECT.md, use AskUserQuestion:

- header: "Ready?"
- question: "I think I understand what you're after. Ready to create PROJECT.md?"
- options:
  - "Create PROJECT.md" — Let's move forward
  - "Keep exploring" — I want to share more / ask me more

If "Keep exploring" — ask what they want to add, or identify gaps and probe
naturally. Loop until "Create PROJECT.md" is selected.