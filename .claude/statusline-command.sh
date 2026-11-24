#!/bin/bash
# Status line matching the actual terminal prompt. ~/.bashrc sets PS1, but
# then immediately overrides it with `eval "$(oh-my-posh init bash)"`, so
# oh-my-posh's default theme (no custom config -- POSH_CONFIG is unset) is
# what really renders. This renders that same theme via `oh-my-posh print`
# rather than reconstructing colors from the now-unused raw PS1 string.

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# --pwd renders segments (path, git, etc.) for the given directory without
# needing to actually cd there. --escape=false skips bash-specific `\[`/`\]`
# wrapping, which is only needed when the output is embedded in a real PS1.
prompt=$(oh-my-posh print primary --pwd "$cwd" --shell bash --escape=false 2>/dev/null |
  # Strip OSC sequences (hyperlinks on the path segment, terminal title) --
  # only the OSC-8 hyperlinks would be an odd fit in a status line and the
  # title-set escape has no meaning there; keep the CSI color codes.
  perl -pe 's/\x1b\][^\x07\x1b]*(\x07|\x1b\\)//g')

# Append context-window usage percentage plus the raw token count, dimmed so
# it doesn't compete with the oh-my-posh segments. Omitted entirely if the
# field isn't present yet (e.g. before the first API response of a session).
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
if [ -n "$remaining" ]; then
  used=$(echo "$remaining" | awk '{print 100 - $1}')
  used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
  window_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
  # Compact k/M formatting (e.g. 12.3k, 1.2M) so the count stays short.
  fmt_tokens() {
    awk -v n="$1" 'BEGIN {
      if (n >= 1000000) printf "%.1fM", n / 1000000;
      else if (n >= 1000) printf "%.1fk", n / 1000;
      else printf "%d", n;
    }'
  }
  if [ -n "$used_tokens" ] && [ -n "$window_size" ]; then
    tokens_str="$(fmt_tokens "$used_tokens")/$(fmt_tokens "$window_size")"
    ctx=$(printf '\033[2m %s tokens (%.0f%% ctx used)\033[0m' "$tokens_str" "$used")
  else
    ctx=$(printf '\033[2m %.0f%% ctx used\033[0m' "$used")
  fi
fi

printf '%s%s\n' "$prompt" "$ctx"
