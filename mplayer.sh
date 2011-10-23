#!/bin/bash

alias mp="mplayer -really-quiet"
alias mpp="mplayer -profile"

alias mpf="cdf; mplayer *"
alias mpfl="cdf;ls; mplayer *"

alias mpg='mp "`gf`"'

alias mpt="mp -profile t"
alias mfs="mp -profile fs"
alias mpl="mp -playlist"
alias mgg="mp -geometry 0:0 -xy"

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

function n(){
	num=${1:-3}
	MPN_DIR="$HOME/Movies/cache/${num}/"
	trap "unset MPN_DIR" SIGHUP SIGINT SIGTERM
	mpn
	unset MPN_DIR
}


# control mplayer though the pipe 
function mc (){
    echo "$*" > ~/.mplayer/pipe
}
 
function mo (){
    num=$1
    [ $# -lt 1 ] && num=5
    tail -n${num} ~/.mplayer/output
}
 
function mco(){
    mc "$*"
    sleep 0.2
    mo
}
 
alias mstart='last_fm_scrobble_on_mplayer_played_50'
function mend(){
    killall last_fm_scrobble_on_mplayer_played_50
	killall mplayer2
    kill $(ps aux | grep lastfmsubmitd | grep -v grep  | awk '{print $2}');
}
