PROMPT="%F{green}%m%f:%F{yellow}%~"$'\n'" %F{yellow}%n%f$ "
export CLICOLOR=1
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
