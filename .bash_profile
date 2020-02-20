source ~/.git-prompt.sh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=~/Library/Python/2.7/bin:$PATH
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/code/complexity
# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=1
PS1_PRE='\[\033[38;5;2m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;3m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n'
PS1_POST=' \[$(tput sgr0)\]\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]'
PROMPT_COMMAND='__git_ps1 "$PS1_PRE" "$PS1_POST"'
# export PS1='\[\033[38;5;2m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;3m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput sgr0)\]\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]'
set -o vi

alias tmux='tmux -2'

source ~/git-completion.bash

alias gbc='git fetch -p && git branch --merged | grep -v "\*" | grep -Ev "(\*|master|develop|staging)" | xargs -n 1 git branch -d'
alias gc='git commit -am "$1" && git push'
alias ex='docker-compose exec'
alias reindex='docker-compose exec api npm run reindex'
alias dck="docker-compose exec api node_modules/.bin/knex"
alias dcr="docker-compose restart api cron item-db-worker oidc"
alias dc="docker-compose"

alias rnm="adb shell input keyevent 82"
alias rni="react-native run-ios"
alias rna="react-native run-android"

alias camera="sudo killall VDCAssistant"
alias pixel="emulator -avd Pixel_API_23 -writable-system"
