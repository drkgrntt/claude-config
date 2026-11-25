---
name: triangulate
description: Use when a bug's root cause isn't obvious, or a first fix attempt failed. Finds the cause from independent angles, confirms it with a failing test, and stops before editing product code.
---

# Find the root cause before fixing

Goal: one confirmed cause and one red test. No product code changes.

## Steps
1. **Reproduce.** Get the exact failure: input, output, error, environment. Can't
   reproduce it? Say so and stop.
2. **Hypotheses.** Write 2-3 distinct candidate causes. Make them genuinely
   different (data, logic, state, config, timing), not three flavors of one idea.
3. **Triangulate.** For each, find evidence that would confirm or rule it out
   (logs, a trace, a query, a bisect). Check at least two independent angles
   before trusting a cause.
4. **Red test.** Write the smallest test that fails because of the cause. Use the
   `write-tests` skill. Run it and show it red.
5. **Stop.** Report. Don't fix until I say go.

## Using subagents
Default: do this yourself. If the cause is truly ambiguous after step 3, a
second opinion is worth it. Use the `delegate` skill. Give each agent only the
symptom and repro, not your hypothesis, so they stay independent.

## Report
- Root cause in one line, and the evidence for it.
- The red test: path and the failing output.
- Hypotheses ruled out, one line each.
- Confidence, and anything you couldn't verify.
- Proposed fix in one line. Wait for my OK.
