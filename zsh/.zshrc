# dot | 07.05.208
# By daelvn
# Zshrc

## OMZ ##
# Path to OMZ
export ZSH=/home/daelvn/dot/zsh/oh
# Plugins
plugins=(
  git,
  sudo,
  docker,
  extract,
  colorize,
  cp,
  vi-mode,
  themes
)
# Theme
ZSH_THEME="robbyrussell"
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

## NotifyKit ##
export NOTIFYKIT_DIR="/home/daelvn/pad/reminders"

## Editor ##
export EDITOR="nvim"

## Functions ##
. $HOME/dot/zsh/fn

## Wine ##
export WINE32=/home/daelvn/wine/32
export WINE64=/home/daelvn/wine/64

## Java ##
export _JAVA_AWT_WM_NONREPARENTING=1

## Completion ##
zstyle -e ':completion:*:(|all-|globbed-)files' ignored-patterns '[[ $PWD/ == $HOME/dev/* ]] && reply=( "*.lua" )'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
