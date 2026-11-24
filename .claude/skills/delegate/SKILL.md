---
name: delegate
description: Use before spawning a subagent, or when deciding whether to delegate work. Covers which agent type fits, how to write the spec, and what to keep direct.
---

# Delegating to subagents

Delegate deliberately, not by default. Each spawn re-derives context from its
prompt alone and costs real tokens. If one or two reads or edits would settle
it, do it directly.

## Pick the type by phase
| Phase | Agent |
|---|---|
| Find out where things live, or what pattern exists | **Explore** (read-only) |
| Turn an open-ended problem into a concrete spec | **planner** (custom), or built-in **Plan** |
| Build something fully specified and self-contained | **general-purpose**, in a worktree |
| Independent check of a finished diff | **reviewer** (custom, read-only) |

These are phases of one task, not competing options.

## Spec for a build agent
The agent remembers nothing, so write all of it:
- Goal.
- Exact files to touch, and files not to touch.
- Existing patterns to match.
- Constraints from the repo's CLAUDE.md.
- How to verify, and what not to do.

If the spec can't be written without back-and-forth, don't delegate it.

## After it returns
- Review the diff against the spec.
- Resolve overlaps between pieces.
- Run the build and tests yourself.

## Keep these direct
- Iterative debugging and "still broken, try this" loops.
- Git workflow.
- Small edits and doc changes.
- Anything touching secrets.
- Verification that mutates a live external system.

## Never delegate
Product decisions, commits, pushes, merges, or deploys.
