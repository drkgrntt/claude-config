# claude-config

Personal [Claude Code](https://docs.claude.com/en/docs/claude-code) user-level
config: working-style rules, settings, and reusable skills. Files mirror their
path under `$HOME` and are symlinked in with GNU Stow.

## Contents

- `.claude/CLAUDE.md` - global working preferences, loaded in every project
- `.claude/settings.json` - global defaults (model, theme, plugins, statusline)
- `.claude/statusline-command.sh` - status line script
- `.claude/skills/`, `agents/`, `commands/` - reusable workflows (as added)

Project-specific facts belong in each repo's own `CLAUDE.md`, not here.

## Install

```sh
git clone https://github.com/<user>/claude-config.git ~/projects/claude-config
cd ~/projects && stow --no-folding -t ~ claude-config
```

`--no-folding` is required: it symlinks individual files instead of the whole
`~/.claude` directory, which also holds credentials, transcripts, and caches.
Move any existing `~/.claude/settings.json` aside first, or Stow will refuse.

## Rules for this repo

- Keep it generic and public-safe: no hostnames, internal project details,
  tokens, or anything from `.credentials.json` / `settings.local.json`.
- `.gitignore` is an allowlist; add new tracked paths to it deliberately.
- Keep `CLAUDE.md` short. Only write rules Claude wouldn't follow by default.
