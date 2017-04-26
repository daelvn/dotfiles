#!/bin/bash
# .bashrc, modified by daelvn
# Soon in https://github.com/daelvn/dotfiles

#== Needed variables for the rc ==#
#--> Check if using interactive shell <--#
IFLAG=$(expr index "$-" i)
export CHPS=2

#== Sourced aliases and scripts ==#
#--> Source global definitions <--#
[ -f /etc/bashrc ] && . /etc/bashrc

#== Binds ==#
#--> Disable the bell <--#
if [[ $IFLAG > 0 ]]; then bind "set bell-style visible"; fi
#--> Show auto-completion list automatically <--#
if [[ $IFLAG > 0 ]]; then bind "set show-all-if-ambiguous on"; fi

#== shopts ==#
#--> Check the window size after each command and update lines and columns number <--#
shopt -s checkwinsize
#--> Append history instead of overwriting file <--#
shopt -s histappend
PROMPT_COMMAND='history -a'
#--> [Ctrl]+[R] for history navigation <--#
stty -ixon

#== Exports ==#
#--> Expand the history size <--#
export HISTFILESIZE=10000
export HISTSIZE=500
#--> Ignore duplicated lines or those that start with space <--#
export HISTCONTROL=erasedups:ignoredups:ignorespace
#--> Set editor preferences <--#
export EDITOR=vim
export VISUAL=vim
#--> GNU's LS_COLORS <--#
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#--> Manpage tweaks for coloring <--#
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
#--> Custom exports <--#
export Pantheon='/home/daelvn/Projects/Galaxi/Pantheon'


#== Aliases ==#
 # Dotfile utils
 alias dotls="tree -aI 'Color|.git'"
 alias dot-mklink="ln -sf"
 alias dot-unlink="rm"
 alias dot-cplink="cp -H"
 # Mount ISO
 alias mountiso="mount -o loop"
 # Date and time
 alias da="date '+%a %d/%b/%Y %T'"
 # Add arguments to other commands
 alias ftpfs="curlftpfs -o allow_other"
 alias cp="cp -r"
 alias rmrf="rm -rfv"
 alias mkdir="mkdir -p"
 alias ps="htop"
 alias top="htop"
 alias ping="ping -c 6"
 alias grep="grep --color=auto"
 alias less="more"
 alias pacman="yaourt"
 alias satan="sudo"
 alias photo="cd Pictures/Scrot && scrot && cd $HOME"
 alias cc="bash ~/Projects/bin/cc.sh"
 alias urn="cd ~/Projects/urn && lua5.1 ~/Projects/urn/run.lua"
 alias magicavoxel="wine ~/Projects/MagicaVoxel/MagicaVoxel-win.exe"
 # Directory aliasing
 alias up="cd .."
 alias uup="cd ../.."
 alias uuup="cd ../../.."
 alias uuuup="cd ../../../.."
 alias uuuuup="echo 'Wait wha' && cd /"
 alias bd='cd "$OLDPWD"'
 # ls aliases
 alias la='ls -a'             # Show hidden files
 alias ls='ls --color=always' # Just use colors
 # alias chmod commands
 alias mkexec='chmod a+x'
 alias mkperm-none='chmod -R 000'
 alias mkperm644='chmod -R 644'
 alias mkperm666='chmod -R 666'
 alias mkperm755='chmod -R 755'
 alias mkperm-full='chmod -R 777'
 # Search with grep
 alias hgrep="history | grep"
 alias pgrep="ps aux | grep"
 alias cgrep="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
 alias fgrep="find . | grep"
 alias ogrep="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"
 # Check command type
 alias commandck="type -t"
 # Aliases for safe and forced reboots
 alias sreboot='sudo shutdown -r now'
 alias freboot='sudo shutdown -r -n now'
 # Aliases for shutdown
 alias turnoff='shutdown -P now'
 # Aliases to how disk space and space used in a folder
 alias diskck="du -S | sort -n -r |more"
 alias spaceck='du -h --max-depth=1'
 # Alias's for archives
 alias mktar='tar -cvf'
 alias mkbz2='tar -cvjf'
 alias mkgz='tar -cvzf'
 alias untar='tar -xvf'
 alias unbz2='tar -xvjf'
 alias ungz='tar -xvzf'

#== Functions ==#
#--> Extract any kind of archive <--#
extract () {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}
#--> Show current network information <--#
netinfo ()
{
	echo "--------------- Network Information ---------------"
	/sbin/ifconfig | awk /'inet addr/ {print $2}'
	echo ""
	/sbin/ifconfig | awk /'Bcast/ {print $3}'
	echo ""
	/sbin/ifconfig | awk /'inet addr/ {print $4}'

	/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
	echo "---------------------------------------------------"
}
#--> For some reason, rot13 pops up everywhere <--#
rot13 () {
	if [ $# -eq 0 ]; then
		tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	else
		echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	fi
}
#--> Trim leading and trailing spaces (for scripts) <--#
trim()
{
	local var=$@
	var="${var#"${var%%[![:space:]]*}"}"  # remove leading whitespace characters
	var="${var%"${var##*[![:space:]]}"}"  # remove trailing whitespace characters
	echo -n "$var"
}
#== PS Prompts ==#
alias PS_CPU="grep 'cpu ' /proc/stat | awk '{usage=(\$2+\$4)*100/(\$2+\$4+\$5)} END {print usage}' | awk '{printf(\"%.1f\n\", \$1)}'"
function __setprompt
{
	local LAST_COMMAND=$?

	# Define colors
	local LIGHTGRAY="\033[0;37m"
	local WHITE="\033[0;37m"
	local BLACK="\033[0;30m"
	local DARKGRAY="\033[0;30m"
	local RED="\033[0;31m"
	local LIGHTRED="\033[0;31m"
	local GREEN="\033[0;32m"
	local LIGHTGREEN="\033[0;32m"
	local BROWN="\033[0;33m"
	local YELLOW="\033[0;33m"
	local BLUE="\033[0;34m"
	local LIGHTBLUE="\033[0;34m"
	local MAGENTA="\033[0;35m"
	local LIGHTMAGENTA="\033[0;35m"
	local CYAN="\033[0;36m"
	local LIGHTCYAN="\033[0;36m"
	local NOCOLOR="\033[0m"

	# Show the error code if the last command failed
	if [[ $LAST_COMMAND != 0 ]]; then
		PS1="\[${WHITE}\](\[${LIGHTRED}\]Error!\[${WHITE}\] ${LAST_COMMAND} - "
		if [[ $LAST_COMMAND == 1 ]]; then
			PS1+="General error"
		elif [ $LAST_COMMAND == 2 ]; then
			PS1+="Missing keyword, command, or permission problem"
		elif [ $LAST_COMMAND == 126 ]; then
			PS1+="Permission problem or command is not an executable"
		elif [ $LAST_COMMAND == 127 ]; then
			PS1+="Command not found"
		elif [ $LAST_COMMAND == 128 ]; then
			PS1+="Invalid argument to exit"
		elif [ $LAST_COMMAND == 129 ]; then
			PS1+="Fatal error signal 1"
		elif [ $LAST_COMMAND == 130 ]; then
			PS1+="Script terminated by Control-C"
		elif [ $LAST_COMMAND == 131 ]; then
			PS1+="Fatal error signal 3"
		elif [ $LAST_COMMAND == 132 ]; then
			PS1+="Fatal error signal 4"
		elif [ $LAST_COMMAND == 133 ]; then
			PS1+="Fatal error signal 5"
		elif [ $LAST_COMMAND == 134 ]; then
			PS1+="Fatal error signal 6"
		elif [ $LAST_COMMAND == 135 ]; then
			PS1+="Fatal error signal 7"
		elif [ $LAST_COMMAND == 136 ]; then
			PS1+="Fatal error signal 8"
		elif [ $LAST_COMMAND == 137 ]; then
			PS1+="Fatal error signal 9"
		elif [ $LAST_COMMAND -gt 255 ]; then
			PS1+="Exit status out of range"
		else
			PS1+="Unknown error code"
		fi
		PS1+=")\n"
	else
		PS1=""
	fi

	if [ $CHPS == 0 ]; then
		# PS1 is the main bash prompt
		PS1="\[${CYAN}\][\[${LIGHTCYAN}\]\u\[${BLUE}\]@\[${LIGHTBLUE}\]\h\[${CYAN}\]]\[${BLUE}\]:\w$\[${WHITE}\] "
		# PS2 is used to continue a command using the \ character
		PS2="\[${DARKGRAY}\]>\[${NOCOLOR}\] "
		# PS3 is used to enter a number choice in a script
		PS3='Please enter a number from above list: '
		# PS4 is used for tracing a script in debug mode
		PS4='\[${DARKGRAY}\]+\[${NOCOLOR}\] '
	elif [ $CHPS == 1 ]; then
		PS1="\[${LIGHTGREEN}\]⊙ \[${MAGENTA}\]\u@\h\[\033[0m\033[0;32m\] ⊙ \[\033[0;32m\]$PWD\[\033[0;32m\] \[\033[0;32m\]⊙ \$\[\033[0m\] "
		PS2="\[${LIGHTCYAN}\]->\[${WHITE}\] "
		PS3="\[${LIGHTCYAN}\]))\[${WHITE}\] "
		PS4="\[${LIGHTCYAN}\]>>\[${WHITE}\] "
	elif [ $CHPS == 2 ]; then
		PS1="\[${MAGENTA}\]\u@\h\[\033[0m\033[0;32m\] \[\033[0;32m\]\W/ \$\[\033[0m\] "
		PS2="\[${LIGHTCYAN}\]->\[${WHITE}\] "
		PS3="\[${LIGHTCYAN}\]))\[${WHITE}\] "
		PS4="\[${LIGHTCYAN}\]>>\[${WHITE}\] "
	fi
}
PROMPT_COMMAND='__setprompt'
unset GREP_OPTIONS

#== Path ==#
export PATH=$PATH:$HOME/Projects/bin:$HOME/Public/ftp.rf.gd

#== Evals ==#
eval "$(thefuck --alias)"
