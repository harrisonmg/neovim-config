# Prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[35m\]\w\[\033[34m\]\$(parse_git_branch)\[\033[00m\]$ \[\e[m\]"

# Adios vi
alias nv='nvim -p'
export EDITOR='nvim'
export VTE_VERSION='100'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND=""

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# CDCDCDC
function cd_up()
{
  cd $(printf "%0.s../" $(seq 1 $1 ));
}
alias 'cd.'='cd_up'

# Fix dir bg (WSL)
LS_COLORS=$LS_COLORS:'ow=1;34:' ; export LS_COLORS

# Various aliases
alias sudo='sudo '

alias vib='nvim ~/.bashrc'
alias sb='source ~/.bashrc'

alias cdb='cd -'
alias cdd='cd ~/dotfiles'
alias naut='nautilus .'

alias prune-branches="git pull; git remote prune origin; { git branch -vv | grep ' gone]' | awk '{print $1}' | xargs git branch -D; }"
alias gits='git status'
alias gitc='git commit'
alias gitp='git push'
alias gitd='git diff'
