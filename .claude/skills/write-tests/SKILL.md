---
name: write-tests
description: Use when writing, changing, or reviewing automated tests, or fixing a bug that needs a regression test. Makes sure tests can actually fail and cover failure cases, not just the happy path.
---

# Writing tests that prove something

## Before writing
- Find the repo's existing test style and match it. Don't add new frameworks or
  mocks.
- No test suite in this repo? Don't add infrastructure unprompted. Suggest it.
- Bug fix: write the failing test first, then fix the bug.
- New behavior with clear criteria: test first when practical. Red, minimal
  code to green, then clean up. Don't write the whole suite up front.

## Write
- One behavior per test. Name it for what it checks.
- Test behavior, not implementation. Assert the specific expected result, not
  just "no error" or "is positive".
- Don't re-implement the logic inside the test. Don't mock the thing under test.
- Cover more than the happy path:
  - Boundaries: zero, empty, max.
  - Invalid input.
  - Error and failure paths.
  - For changed behavior, a case proving the old behavior is gone.
- Keep pure logic apart from the database and HTTP layers so it tests without
  them.
- Never hit live external services.

## Prove it can fail
1. Break the code on purpose, or revert the fix.
2. Run the test. It must go red.
3. Restore the code. It must go green.

A test that can't fail proves nothing. If it stays green, fix the test.

## Report
One line: what's covered, and confirmation that each new test failed when the
code was broken.
