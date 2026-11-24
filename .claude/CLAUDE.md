# Global working preferences

## Communication
I read best in short chunks. Optimize for skimmability and low effort.
- Lead with the answer or the action. Then stop. I'll ask if I want more.
- Keep paragraphs to 2-3 sentences. Prefer bullets, numbered steps, and small
  tables over prose. Never produce a wall of text.
- Use plain words and concrete examples. When I need something explained, make
  it simple and brief. Offer to go deeper in one line instead.
- Don't assume I followed. For anything that matters, say what it means for me
  in one line ("nothing to do" or "you need to X").
- End with a short recap: what changed, and what I need to do, if anything. Not
  a restatement of the diff.
- Ask one question at a time, and include a recommended default.

## Working with me
- I make the decisions. Give a recommendation, not a menu of options.
- If something failed, was skipped, or couldn't be verified, say so up front.
- Quality is not negotiable. Keep the communication short, not the checking.

## About me
Senior web developer (TypeScript, React, Go, Node). Don't explain programming
basics. When a concept is new to me (a new framework or domain), relate it to
web or backend concepts I already know, in a sentence or two.

## Quality
- Before saying work is done, run the repo's build and tests (check the
  Makefile or package.json) and report the result. Never claim it works without
  running it. For UI you can't see, say what you couldn't verify.
- Trust a real build or typecheck over IDE diagnostics, which lag on generated
  code.
- Passing tests don't authorize a merge or deploy. I still decide.
- After a deploy, confirm it worked: check logs, confirm any migration landed,
  and request the live URL.

## Tests
- Where a repo has a test suite, new behavior gets a test. For a bug, write a
  failing test first, then fix it. Match the existing test style.
- Where a repo has no tests, don't add test infrastructure unprompted. Suggest
  it.
- A test must be able to fail. After writing one, break the code on purpose (or
  revert the fix) and confirm the test goes red. Then restore it. A test that
  can't fail proves nothing.
- Test behavior, not implementation. Assert the specific expected result, not
  just "no error" or "is positive". Don't mock the thing being tested.
- Cover more than the happy path: boundaries (zero, empty, max), invalid input,
  and error and failure paths. For changed behavior, include a case that proves
  the old behavior is gone.
- Keep pure logic separate from the database and HTTP layers so it can be tested
  without them.
- Tests never hit live external services.

## Self-review before done
Read the diff once before reporting done. Check for leftover debug code,
unrelated changes, and performance red flags: N+1 queries, queries without a
limit, new query columns without an index, heavy work inside loops or hot paths.

Flag performance issues in one line each. Don't optimize without measuring, and
don't fix beyond obvious mistakes unless I ask. For a deeper pass on bigger
changes, suggest `/code-review` or `/simplify`.

## Security
- Every new route or endpoint gets an explicit auth check, and an ownership
  check where it touches a user's data. Where auth is opt-in per route group,
  confirm the new route is covered.
- Before a commit, check the staged files for `.env`, keys, and credentials.
- Don't add a new dependency without saying why.
- Report a security concern as soon as you see it, even if it's outside the
  current task. Don't fix it silently.

## Git and deploys
- Merge, push to a deploy branch, deploy, and delete a branch each need my
  explicit ask. Approval for one doesn't carry over to the next. Don't delete a
  branch as automatic cleanup.
- Anything that touches production is gated on my explicit go-ahead, every time.
- Keep changes commit-sized, and suggest a commit message when a step is done.
- Where a repo uses a PR flow: feature branch, PR via `gh`, merge, delete the
  branch, then deploy. Small or doc-only changes can commit straight to the
  working branch. Follow the repo's own CLAUDE.md. If it's silent, check
  `git log` for the existing convention.

## Secrets
- Never print a real `.env` file (`cat`, `tail`, etc.). It puts every value into
  the transcript, not just the one you meant to check.
- List keys with `grep -o '^[A-Z_]*=' .env`. Check whether a key has a value,
  without showing it, with `grep -c '^KEY_NAME=.\+$' .env`.
- Appending a new key (`printf ... >> .env`) is fine without reading the file.

## Scope
- Don't add features, systems, or dependencies I didn't ask for. Suggest them
  instead.
- Use an obvious placeholder (`TODO: ...`) instead of inventing content I didn't
  ask for.
- When unsure how a third-party API or service really behaves, verify it against
  a dev or test account, never production data. Docs have been wrong before.
- Treat my running dev server as mine. Don't start, stop, or hit it on my
  behalf unless I ask.

## Delegating to subagents
Delegate deliberately, not by default. Each spawn re-derives context from its
prompt alone and costs real tokens.
- **Explore** for read-only recon ("where does X live").
- **Plan** to turn an open-ended problem into a concrete spec.
- **general-purpose in a worktree** for a fully specified, self-contained build.
  Write a complete spec first: goal, files to touch and not touch, patterns to
  match, how to verify. Review the diff against the spec afterward.
- Keep these direct: iterative debugging, git workflow, small edits, doc
  changes, anything touching secrets, and verification that mutates a live
  external system.
- Subagents never decide product questions, commit, push, merge, or deploy.

## Efficiency
Prefer a quick first pass I can react to over a long upfront plan. For a change
spanning many files (migration, handler, view, styles), use plan mode to lay out
the steps first.

## Docs
Only where a repo already has a `CLAUDE.md` or `docs/` system: keep it current
as part of finishing a change that affects it. Don't create new docs files or
folders unprompted. Keep `CLAUDE.md` lean and point to docs instead of copying
them.
