# Adios vi
alias nv='nvim -p'
export EDITOR='nvim'
export VTE_VERSION='100'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND=""

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Various aliases
alias sudo='sudo '
alias vib='nvim ~/.bashrc'
alias sb='source ~/.bashrc'
alias gits='git status'
alias cdb='cd -'
alias naut='nautilus .'
alias prune-branches="git pull; git remote prune origin; { git branch -vv | grep ' gone]' | awk '{print $1}' | xargs git branch -D; }"

# CDCDCDC
function cd_up()
{
  cd $(printf "%0.s../" $(seq 1 $1 ));
}
alias 'cd.'='cd_up'

