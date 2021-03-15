#!/bin/bash

# Prompt
parse_git_branch()
{
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[35m\]\w\[\033[34m\]\$(parse_git_branch)\[\033[00m\]$ \[\e[m\]"

# Adios vi
alias nv='rm -f /tmp/nvimsocket && NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim -p'
export EDITOR='nvim'
export VTE_VERSION='100'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND=""

# I ain't need this
stty -ixon

# CDCDCDC
function cd_up()
{
  cd "$(printf "%0.s../" $(seq 1 "${1:-1}" ))" || return
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

alias prune-branches="git pull; git remote prune origin; { git branch -vv | grep ' gone]' | awk '{print \$\1}' | xargs git branch -D; }"
alias gits='git status'
alias gitc='git commit'
alias gitp='git stash && git pull --rebase && git submodule update && git stash pop'
alias gitd='git diff'
alias gitl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gita='cd "$(git rev-parse --show-toplevel)" && git add . && git commit && git push; cd -'

alias p3='python3'
alias gdb='gdb -tui'

DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export DISPLAY
export LIBGL_ALWAYS_INDIRECT=1
