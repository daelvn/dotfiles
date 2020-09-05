# dot | 07.05.208
# By daelvn
# Zshrc

## OMZ ##
# Path to OMZ
export ZSH=/home/dael/dot/zsh/oh
# Plugins
plugins=(
  git
  sudo
  docker
  extract
  colorize
  cp
  vi-mode
  themes
)
# Theme
ZSH_THEME="robbyrussell"
# Dircolors fix
eval "$(dircolors -p | \
      sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
          dircolors /dev/stdin)"
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
export NOTIFYKIT_DIR="/home/dael/pad/reminders"

## Editor ##
export EDITOR="nvim"

## Functions ##
. $HOME/dot/zsh/fn

## Wine ##
export WINE32=/home/dael/wine/32
export WINE64=/home/dael/wine/64

## Java ##
export _JAVA_AWT_WM_NONREPARENTING=1

## GPG ##
# [ -z $(pgrep gpg-agent) ] && eval $(gpg-agent --homedir $HOME/.gnupg --daemon --pinentry-program /mnt/c/Users/crimu/Repos/pinentry-wsl-ps1.sh)

## Completion ##
zstyle -e ':completion:*:(|all-|globbed-)files' ignored-patterns '[[ $PWD/ == $HOME/dev/* ]] && reply=( "*.lua" )'

# Dircolors fix
eval "$(dircolors -p | \
      sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
          dircolors /dev/stdin)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
