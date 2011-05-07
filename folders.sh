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


# cdf: cd's to frontmost window of Finder
cdf (){
	
currFolderPath=$( /usr/bin/osascript <<APPLESCRIPT
tell application "Finder"
try
set currFolder to (folder of the front window as alias)
on error
set currFolder to (path to desktop folder as alias)
end try
POSIX path of currFolder
end tell
APPLESCRIPT
)
	# echo "pushd to \"$currFolderPath\""
	pushd "$currFolderPath" &> /dev/null
	pwd

}

alias tmp="cd /tmp"
