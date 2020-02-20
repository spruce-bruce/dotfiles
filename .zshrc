# Custom prompt, without git info
PROMPT="%F{green}%m%f:%F{yellow}%~"$'\n'" %F{yellow}%n%f$ "

# turn on ls colors, etc
export CLICOLOR=1

# -2 forces tmux to assume 256 color support
alias tmux='tmux -2'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
