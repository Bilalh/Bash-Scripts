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

alias mpnl="mpn -l"
alias mpns="mpn -shuffle"

function mpo(){
	export USE_TAGINFO=true
	trap "unset USE_TAGINFO" SIGHUP SIGINT SIGTERM
	mplayer -input conf=input_with_last_fm.conf -input file=~/.mplayer/pipe "$@" 2>&1  | tee ~/.mplayer/output | grep '^# ' 
	unset USE_TAGINFO
}
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

function mpm(){
	dir=${MPM_DIR:-$HOME/Movies/add/}
	cd "$dir" 
	export USE_TAGINFO=true
	export DISPLAY_TRACK_INFO=false
	trap "mend; unset USE_TAGINFO; unset DISPLAY_TRACK_INFO" SIGHUP SIGINT SIGTERM 
	
	killall last_fm_scrobble_on_mplayer_played_50_with_info &> /dev/null
    last_fm_scrobble_on_mplayer_played_50_with_info &

	export LC_ALL='C';
	IFS=$'\x0a';
	select OPT in `ls | grep -vP 'cover|ςbz|zoff alias| Renaming' | sort -bf` "." "Cancel"; do
		unset LC_ALL
		if [ "${OPT}" != "Cancel" ]; then
			if [ "$1x" == "-lx" ]; then ls -R "${OPT}"; shift; fi;
			#mpo -input conf=input_with_last_fm_for_audio.conf "`pwd`/${OPT}"/*
			mpo -input conf=input_with_last_fm_for_audio.conf  -playlist <(find "$PWD/$OPT" -type f \
			\( -iname "*\.mp3" -o -iname "*\.flac"  -o -iname "*\.m4a" -o -iname "*\.ogg"  -o -iname "*\.wma" \) )
		fi
		break;
	done
	unset IFS;
	cd "$OLDPWD"
}

alias n3='n 3'
alias n2='n 2'
alias n1='n 1'
alias n0='n 0
'
function n(){
	num=${1:-3}
	MPM_DIR="$HOME/Movies/cache/${num}"
	trap "unset MPM_DIR" SIGHUP SIGINT SIGTERM
	mpm
	unset MPM_DIR
}

function nm(){
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
    killall last_fm_scrobble_on_mplayer_played_50 last_fm_scrobble_on_mplayer_played_50_with_info
    kill $(ps aux | grep lastfmsubmitd | grep -v grep  | awk '{print $2}');
}
