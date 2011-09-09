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

# Allows the user to choice a director to play music from
# also scrobble to last.fm 
# works with unicode and whitespace
# Ctrl-\ to quit
# can be a script since it will not display more then one column
function mpn () {
	scrobber=${MPLAYER_LASTFM:-mplayerlastfm.sh}	
	dir=${MPN_DIR:-$HOME/Movies/add/}
	cd "$dir" 
	trap "" INT

	export LC_ALL='C';
	IFS=$'\x0a';
	select OPT in `ls | grep -vP 'cover|ςbz|zoff alias| Renaming' | sort -bf` "." "Cancel"; do
		unset LC_ALL
		if [ "${OPT}" != "Cancel" ]; then
			if [ "$1x" == "-lx" ]; then ls -R "${OPT}"; shift; fi;
			find "${OPT}" \( -iname "*\.mp3" -o -iname "*\.flac"  -o -iname "*\.m4a" -o -iname "*\.ogg"  -o -iname "*\.wma" \) -exec ${scrobber}  $* '{}' +
		fi
		break;
	done
	unset IFS;
	cd "$OLDPWD"
}
