---
name: docs-sync
description: Use after finishing a change in a repo that has a CLAUDE.md, README, or docs/ folder. Finds claims in those docs that the change made stale, and fixes them in the same change.
---

# Keeping docs in sync

Only where the repo already has docs. Don't create new doc files or folders.

## Steps
1. Read the diff. List what changed that docs might describe:
   - Added, removed, or renamed packages, files, or commands.
   - New or changed env vars, routes, or features.
   - Changed setup, build, or test steps.
2. Check each doc (`CLAUDE.md`, `README.md`, `docs/`) for mentions of those
   things. Search for the old names, not just the new ones.
3. Check that every command and path the docs cite still exists.
4. Fix what's stale, in the same change. Keep edits short.

## Rules
- Point to docs instead of copying them. Don't paste the same fact into two
  places.
- Keep `CLAUDE.md` lean. Only add what Claude couldn't learn from the code.
- Leave docs alone that the change didn't affect.

## Report
One line per doc: updated, or "no change needed". Flag anything you couldn't
verify.
