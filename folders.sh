#!/bin/bash

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias back='cd "$OLDPWD"'

alias open.="open ."
alias open..="open .."


function rcd {
	num="`ls -d */ | egrep -i \"$1\" -c`"
	if [ $num -eq 1 ]; then
		cd "`ls -d */ | egrep -i \"$1\" `"
		pwd
	elif [ $num -eq 0 ]; then
		echo ""
	elif [ $num -lt 30 ]; then
		select NAME in `ls -d */ | egrep -i "$1" | sed 's/ /§/'`; do
			cd "${NAME/§/ }"
			pwd
			break	
		done
	else 
		echo "Too many items - $num"
	fi
}

alias gd="grepdir"
function grepdir () {
	grep -Pn "$1" *
}

alias tmp="cd /tmp"
