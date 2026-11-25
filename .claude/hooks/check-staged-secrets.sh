#!/usr/bin/env bash
# PreToolUse hook (Bash): block `git commit` when staged files look like secrets.
# Reads the hook JSON on stdin. Exit 2 blocks the call and shows stderr to Claude.
# Prints file names and line numbers only, never the secret values.

cmd=$(jq -r '.tool_input.command // empty' 2>/dev/null)
case "$cmd" in
  *"git commit"*) ;;
  *) exit 0 ;;
esac

# Honor `git -C <dir> commit` and a leading `cd <dir> &&`.
dir=$(printf '%s' "$cmd" | sed -nE 's/.*git -C ([^ ]+) commit.*/\1/p')
[ -z "$dir" ] && dir=$(printf '%s' "$cmd" | sed -nE 's/^cd ([^ &;]+) *(&&|;).*/\1/p')
[ -n "$dir" ] && cd "$dir" 2>/dev/null

git rev-parse --git-dir >/dev/null 2>&1 || exit 0

bad=""

# 1. Risky file names (templates like .env.example are fine).
names=$(git diff --cached --name-only --diff-filter=ACM | grep -E \
  '(^|/)\.env($|\.)|(^|/)(id_rsa|id_ed25519)($|\.)|\.(pem|key|p12|pfx)$|(^|/)(credentials|\.credentials)\.json$|(^|/)settings\.local\.json$' \
  | grep -vE '\.(example|sample|template)$')
[ -n "$names" ] && bad+=$'Risky file names staged:\n'"$names"$'\n'

# 2. Secret-looking content in added lines (file:line only).
pat='(AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9]{36,}|sk-[A-Za-z0-9_-]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|(api[_-]?key|secret|token|password)[A-Za-z0-9_]*[ ]*[:=][ ]*["'\'']?[A-Za-z0-9/+_=.-]{16,})'
hits=$(git diff --cached -U0 --no-color | awk -v pat="$pat" '
  /^\+\+\+ b\// { file = substr($0, 7); next }
  /^@@/ { match($0, /\+[0-9]+/); line = substr($0, RSTART + 1, RLENGTH - 1) - 1; next }
  /^\+/ { line++; if (tolower($0) ~ tolower(pat)) print file ":" line }
')
[ -n "$hits" ] && bad+=$'Secret-looking content at:\n'"$hits"$'\n'

if [ -n "$bad" ]; then
  {
    echo "BLOCKED: staged files may contain secrets."
    printf '%s' "$bad"
    echo "Unstage or fix, then tell the user. If it is a false positive, ask the user before committing."
  } >&2
  exit 2
fi
exit 0
