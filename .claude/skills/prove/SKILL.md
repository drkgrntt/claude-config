---
name: prove
description: Use when a change is built and tests pass, and you need proof it works in a real dev environment before calling it done. Runs a regression check, verifies the contract, probes edge cases, and for UI drives Playwright at several screen sizes with screenshots.
---

# Prove it works in a dev environment

Passing unit tests are not proof. This is the pass after them. It scales with
the ticket: a small fix gets a short pass, a new feature gets all of it.

## Rules
- Dev or test environments only. Never production, never real user data.
- Deploying to dev needs my explicit OK first, every time. Ask, then wait.
- My running local dev server is mine. Don't start, stop, or hit it unless I say.
- Read-only against shared data unless the change itself is the write. Any
  script with an `-apply` style flag runs dry-run first.
- Never print `.env` values. See the Secrets rules in `CLAUDE.md`.

## Steps
1. **Scope.** Re-read the ticket or task. List the acceptance criteria and the
   code paths the diff touches. Say which of the steps below apply.
2. **Target.** Find the dev env and deploy command in the repo's `CLAUDE.md` or
   docs. Not documented? Ask me. Don't guess a URL.
3. **Deploy (ask first).** After my OK, deploy to dev. Confirm it landed: logs,
   migration applied, version or commit visible on the live URL.
4. **Regression.** Exercise the existing behavior near the change, not just the
   new path. Run the repo's e2e or integration suite against dev if it has one.
5. **Contract.** Check requests and responses against the documented contract
   (OpenAPI, types, schema, ticket). Status codes, field names, types, error
   shapes, auth. Note any drift, even if it looks harmless.
6. **Edge cases.** Empty, max, invalid, duplicate, unauthorized, wrong owner,
   concurrent, slow or failed dependency. Pick the ones this change can break.
7. **UI (if any).** Drive it with Playwright. Use what's already installed
   (Playwright MCP, `claude-in-chrome`, or the repo's own Playwright). Don't add
   a dependency without saying why.
   - Walk the real user flow, not just the landing page.
   - Check at least mobile (~375px), tablet (~768px), and desktop (~1280px).
   - Watch for overflow, clipped text, overlapping elements, broken nav, console
     errors, and failed network calls.
   - Screenshot each size at the key states. Save to the scratchpad, and give me
     the full absolute paths.

## Report
Short and skimmable:
- Verdict first: **proven**, **found issues**, or **couldn't verify**.
- A small table: check, result, evidence (path, log line, screenshot).
- Issues with `path:line` or URL where known.
- Say plainly what you skipped or couldn't reach.
- Never claim proven for a step you didn't run.
