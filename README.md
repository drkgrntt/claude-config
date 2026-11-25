# claude-config

Personal [Claude Code](https://docs.claude.com/en/docs/claude-code) user-level
config: working-style rules, settings, and reusable skills. Files mirror their
path under `$HOME`.

## Contents

- `.claude/CLAUDE.md` - global working preferences, loaded in every project
- `.claude/settings.json` - global defaults (model, theme, plugins, statusline)
- `.claude/statusline-command.sh` - status line script
- `.claude/skills/`, `agents/`, `commands/` - reusable workflows (as added)
- `.claude/hooks/check-staged-secrets.sh` - blocks `git commit` when staged
  files look like secrets. Link it to `~/.claude/hooks/` and add the
  `PreToolUse` entry from `settings.json`.

Project-specific facts belong in each repo's own `CLAUDE.md`, not here.

## Install

Link the files you want into `~/.claude`. `CLAUDE.md` is the one that matters:

```sh
git clone https://github.com/drkgrntt/claude-config.git ~/projects/claude-config
ln -s ~/projects/claude-config/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/projects/claude-config/.claude/statusline-command.sh ~/.claude/statusline-command.sh
```

Update later with `git pull`. Edits to `~/.claude/CLAUDE.md` go straight into
the repo, since it's a symlink.

**`settings.json` is a template, not a symlink.** Claude Code rewrites that
file and adds machine-specific data, which would flow back into this public
repo. Copy it by hand where useful. The statusline needs `oh-my-posh` and `jq`.

## Rules for this repo

- Keep it generic and public-safe: no hostnames, internal project details,
  tokens, or anything from `.credentials.json` / `settings.local.json`.
- `.gitignore` is an allowlist; add new tracked paths to it deliberately.
- Keep `CLAUDE.md` short. Only write rules Claude wouldn't follow by default.
