---
name: new-endpoint
description: Use when adding or changing a route, endpoint, or handler that serves requests. Checks auth, ownership, input validation, and failure-case tests so a new route doesn't ship unprotected.
---

# Adding an endpoint safely

## Before writing
- Find how routes are registered and how auth is applied. If auth is opt-in per
  route group, a new route is open until you add it.
- Match the existing handler pattern in the repo.

## Checklist
1. **Auth.** The route requires the right level of login. Public routes are a
   deliberate choice, and you say so.
2. **Ownership.** If it touches a user's or tenant's data, scope the query by
   the identity from the session. Never take the owner ID from a form field,
   param, or body.
3. **Input.** Validate everything external at the boundary. Reject bad input
   with a clear 4xx.
4. **Errors.** Responses and logs must not leak secrets, tokens, personal data,
   or internals like stack traces and SQL.
5. **Tests.** Cover the happy path plus:
   - Unauthenticated request.
   - Authenticated as the wrong owner.
   - Invalid input.
6. **Docs.** Update any route list or README that names routes.

## Prove it
Send a request with no auth and one as the wrong user. Confirm both are
rejected. Don't just read the code and assume.

## Report
One line per checklist item: done, or why not applicable.
