#!/bin/bash


alias mp="mplayer"
alias mpp="mplayer -profile"

alias mpf="cdf; mplayer *"
alias mpfl="cdf;ls; mplayer *"

alias mpg='mplayer "`gf`"'

alias mpt="mplayer -profile t"
alias mfs="mplayer -profile fs"
alias mpl="mplayer -playlist"
alias mgg="mplayer -geometry 0:0 -xy"

alias gmkv="cd ~/Desktop/joinMkv/"

alias mpnl="mpn -l"
alias mpns="mpn -shuffle"
function mpn () {
	export LC_ALL='C';
	IFS=$'\x0a';
	cd "$HOME/Movies/add/" 

	select OPT in `ls -tr | grep -vP 'cover|ςbz|zoff alias| Renaming' | sort -bf` "." "Cancel"; do
		unset LC_ALL
		if [ "${OPT}" != "Cancel" ]; then
			if [ "$1x" == "-lx" ]; then ls -R "${OPT}"; shift; fi;
			find "${OPT}" \( -iname "*\.mp3" -o -iname "*\.flac"  -o -iname "*\.m4a" -o -iname "*\.ogg" -o -iname "*\.ac3" -o -iname "*\.wma" \) -exec mplayer $* '{}' +
		fi
		break;
	done
	unset IFS;
	cd $OLDPWD	
}


