---
name: db-migration
description: Use when creating or changing a database schema migration, adding a column or index, or changing stored data. Keeps migrations safe, reversible where possible, and ordered correctly against the deploy.
---

# Writing a migration safely

## Before writing
- Find the repo's migration tool and folder. Match its naming and style.
- Find how migrations run: automatically at startup, or as a manual step. This
  decides the safe order.

## Rules
- **Never edit a migration that already shipped.** Add a new one.
- **Additive first.** Add the new column or table before any code depends on
  it. Remove old things in a later migration, after nothing uses them.
- **Old code must still work against the new schema.** The app and the schema
  are never updated at the exact same moment.
- **Destructive changes** (drop, rename, type change, data rewrite) need my
  explicit OK first. State what's lost and how to undo it.
- **Backfills** go in their own step, separate from the schema change.
- **Indexes.** Add one for any new column used in a query filter or join. On big
  tables, use the non-blocking form (for Postgres, `CREATE INDEX CONCURRENTLY`).
- **Defaults and NOT NULL.** Adding a NOT NULL column to existing rows needs a
  default or a backfill first.

## Prove it
1. Run it on a local or dev database. Never production.
2. If the repo supports rollback, run the down migration too.
3. Run the tests against the new schema.

## Deploy
Running against production needs my explicit go-ahead. Say where in the deploy
it runs: before the app restarts, or on startup.

## Report
What changed, whether it's reversible, and what I need to do.
