#!/bin/sh
# PATHS
export PATH=~/bin:$PATH

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
