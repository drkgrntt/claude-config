---
name: comments
description: Use when adding, changing, or reviewing code comments or doc comments in any language. Keeps comments that explain why, and removes ones that restate the code.
---

# Comments

## Write a comment when
- The reason isn't visible in the code: a workaround, a constraint, a past bug,
  a surprising choice.
- A public API needs a contract: inputs, outputs, errors, side effects.
- A non-obvious algorithm or invariant needs a pointer or a name.

## Don't
- Restate what the code says (`// increment i`).
- Leave commented-out code. Git has it.
- Reference the task, ticket, or "added for X". That belongs in the commit.
- Leave `TODO` without a clear next step. Never invent one to fill space.

## Style
- Explain why, not what. If a comment explains what, rename or extract instead.
- Keep it short. One or two lines beats a paragraph.
- Update or delete a comment when the code under it changes. A stale comment is
  worse than none.
- Match the language's doc-comment convention (Go: starts with the name; TS:
  TSDoc where the repo uses it).

## Reviewing
Flag stale, misleading, or noisy comments. Don't rewrite style across files
unasked.
