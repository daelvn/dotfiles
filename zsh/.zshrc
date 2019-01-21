# dot | 07.05.208
# By daelvn
# Zshrc

## OMZ ##
# Path to OMZ
export ZSH=/home/daelvn/dot/zsh/oh
# Plugins
plugins=(
  git
)
# Theme
ZSH_THEME="avit"
# Load
source $ZSH/oh-my-zsh.sh

## Aliases ##
eval `dircolors`
. $HOME/dot/zsh/aliases

## Path ##
[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver
. $HOME/dot/zsh/programs >/dev/null
. $HOME/dot/zsh/path

## History ##
. $HOME/dot/zsh/history

## SSH ##
. $HOME/dot/zsh/ssh

## Host ##
HOSTNAME="`hostname`"

## Editor ##
EDITOR="nvim"

## Functions ##
. $HOME/dot/zsh/fn

## Wine ##
export WINE32=/home/daelvn/wine/32
export WINE64=/home/daelvn/wine/64

## Completion ##
zstyle -e ':completion:*:(|all-|globbed-)files' ignored-patterns '[[ $PWD/ == $HOME/dev/* ]] && reply=( "*.lua" )'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
