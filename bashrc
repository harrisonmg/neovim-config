#!/bin/bash

# Prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[35m\]\w\[\033[34m\]\$(parse_git_branch)\[\033[00m\]$ \[\e[m\]"

# Adios vi
alias nv='nvim -p'
export EDITOR='nvim'
export VTE_VERSION='100'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND=""

#if [[ ! "$PATH" == */home/harrison/.fzf/bin* ]]; then
  #[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#fi

# CDCDCDC
function cd_up()
{
  cd $(printf "%0.s../" $(seq 1 $1 ))
}
alias 'cd.'='cd_up'

# Fix dir bg (WSL)
export LS_COLORS=$LS_COLORS:'ow=1;34:'

# Improve command history
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Various aliases
alias sudo='sudo '

alias vib='nvim ~/dotfiles/bashrc'
alias vibm='nvim ~/.bashrc'
alias sb='source ~/.bashrc'

alias cdb='cd -'
alias cddf='cd ~/dotfiles'
alias cddl='cd /mnt/c/Users/Harrison/Downloads'
alias cddc='cd /mnt/c/Users/Harrison/Documents'
alias naut='nautilus .'
alias exp='explorer.exe .'

alias prune-branches="git pull; git remote prune origin; { git branch -vv | grep ' gone]' | awk '{print $1}' | xargs git branch -D; }"
alias gits='git status'
alias gitc='git commit'
alias gitp='git pull'
alias gitd='git diff'
alias gitl='git log'
alias gita='cd "$(git rev-parse --show-toplevel)" && git add . && git commit && git push; cd -'

alias p3='python3'
alias gdb='gdb -tui'

export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
