#!/bin/sh
# PATHS
export PATH=~/bin:$PATH
# COLORS
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
L_YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
NO_COLOUR="\[\033[0m\]"
CYAN="\[\033[0;36m\]"
PURPLE="\[\033[0;35m\]"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

export CLICOLOR=YES
alias ll="ls -lah"

# JUMP JUMP
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
alias j="jump"
export MARKPATH=$HOME/.marks

if [ ! -d $MARKPATH ]; then
	mkdir $MARKPATH;
fi

function jump { 
	cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark { 
	mkdir -p "$MARKPATH"; ln -sf "$(pwd)" "$MARKPATH/$1"
}

function unmark { 
	rm -i "$MARKPATH/$1"
}

function m {
	ls -l "$MARKPATH" | awk '/^l/ {print $9 " -> " $11}' | column -t
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(gfind $MARKPATH -type l -printf "%f \n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks j jump unmark


# PROMPT SETUP
function parse_git_branch () {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function set_git_branch () {
	# Capture the output of the "git status" command.
	git_status="$(git status 2> /dev/null)"
	# Set color based on clean/staged/dirty.
	if [[ ${git_status} =~ .*"working directory clean".* ]]; then
		B_STATE="${GREEN}"
	elif [[ ${git_status} =~ .*"Changes to be committed".* ]]; then
		B_STATE="${YELLOW}"
	else
		B_STATE="${RED}"
	fi
}

prompt_cmd () {
	PS1="\u@\h $L_YELLOW[\W]: ${B_STATE}\$(parse_git_branch)$NO_COLOUR$ "
}

PROMPT_COMMAND=prompt_cmd
