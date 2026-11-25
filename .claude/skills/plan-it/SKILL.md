---
name: plan-it
description: Use when a request is vague, has open decisions, or has no clear definition of done. Interviews me one question at a time and ends with written acceptance criteria before any building starts.
---

# Close the ambiguity first

Use for fuzzy tasks. If the request is already specific, skip this and build.

## Steps
1. **Read first.** Check the code, docs, and `CLAUDE.md`. Never ask something you
   can look up.
2. **Interview.** One question at a time, each with a recommended default. Cover
   only what changes the build: scope, users, data, failure behavior, what's
   explicitly out. Stop when the answers stop changing the plan.
3. **Write acceptance criteria.** A short checklist. Each item observable and
   testable ("returns 403 for a non-owner"), not vague ("secure").
4. **Show it.** Criteria, out-of-scope list, and the files likely touched. Wait
   for my OK before building.

## Notes
- A change across many files: follow with plan mode for the step order.
- The criteria feed the tests (`write-tests`) and the final check (`prove`).
- Don't invent requirements. Unknown and not worth a question: mark it
  `TODO: ...` in the criteria.
