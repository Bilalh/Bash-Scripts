#!/bin/bash

alias mp="mplayer -really-quiet"
alias mpp="mplayer -profile"

alias mpg='mp "`gf`"' # play select finder item

# control mplayer though the pipe 
function mc (){
    echo "$*" > ~/.mplayer/pipe
}

alias  p='mc pause'
alias mn='mc pt_step 1; audio_info_display.rb'
alias m5="mc seek -5" 
alias m0="mc seek -10" 

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
function mpo(){
	export USE_TAGINFO=true
	trap "unset USE_TAGINFO" SIGHUP SIGINT SIGTERM
	mplayer -input conf=input_with_last_fm.conf -input file=~/.mplayer/pipe "$@" 2>&1  | tee ~/.mplayer/output | grep '^# ' 
	unset USE_TAGINFO
}


alias mpf="cdf; mp *"
alias mpfl="cdf;ls; mp *"

alias mpt="mp -profile t"
alias mfs="mp -profile fs"
alias mpl="mp -playlist"
alias mgg="mp -geometry 0:0 -xy"


# Newer version of mpn allow shuffling, mplayer options and previous/next track
# Allows the user to choice a director to play music from
# also scrobble to last.fm 
# works with unicode and whitespace
# can not be a script since it will not display more then one column
function mpm(){
	dir=${MPM_DIR:-$HOME/Movies/add/}
	[ ! -d "$dir" ] && echo "'$dir' does not exist" && return  
	cd "$dir" 
	export USE_TAGINFO=true
	export DISPLAY_TRACK_INFO=false
	trap "unset IFS; mend; unset USE_TAGINFO; unset DISPLAY_TRACK_INFO;return" SIGHUP SIGINT SIGTERM 
		
	killall last_fm_scrobble_on_mplayer_played_50_with_info &> /dev/null

	export LC_ALL='C';
	IFS=$'\x0a';
	select OPT in `ls | grep -vP 'cover| ςbz|zoff alias| Renaming' | sort -bf` "." ". -shuffle" "Cancel"; do
		unset LC_ALL
		if [ "${OPT}" != "Cancel" ]; then
			name=""; args=""
			if [ "$1x" == "-lx" ]; then ls -R "${OPT}"; shift; fi;
			if [ "x${OPT}" == "x. -shuffle" ]; then 
				args="-shuffle"; 
			else
				name=${OPT};
			fi 
    		last_fm_scrobble_on_mplayer_played_50_with_info &
			mpo "$@" ${args} -input conf=input_with_last_fm_for_audio.conf  -playlist <(find "$PWD/$name/"* \
			\( -iname "*\.mp3" -o -iname "*\.flac"  -o -iname "*\.m4a" -o -iname "*\.ogg"  -o -iname "*\.wma"  \) )
		fi
		break;
	done
	unset IFS;
	cd "$OLDPWD"
}

alias n3='n 3'
alias n2='n 2'
alias n1='n 1'
alias n0='n 0'
function n(){
	num=${1:-3}
	shift
	MPM_DIR="$HOME/Movies/cache/${num}"
	trap "unset MPM_DIR" SIGHUP SIGINT SIGTERM
	mpm $@
	unset MPM_DIR
}

 
alias mstart='last_fm_scrobble_on_mplayer_played_50'
function mend(){
    killall last_fm_scrobble_on_mplayer_played_50 last_fm_scrobble_on_mplayer_played_50_with_info
    kill $(ps aux | grep lastfmsubmitd | grep -v grep  | awk '{print $2}');
}

function nm(){
	num=${1:-3}
	MPN_DIR="$HOME/Movies/cache/${num}/"
	trap "unset MPN_DIR" SIGHUP SIGINT SIGTERM
	mpn
	unset MPN_DIR
}

# Allows the user to choice a director to play music from
# also scrobble to last.fm 
# works with unicode and whitespace
# Ctrl-\ to quit
# can not be a script since it will not display more then one column
function mpn () {
	scrobber=${MPLAYER_LASTFM:-mplayerlastfm.sh}	
	dir=${MPN_DIR:-$HOME/Movies/add/}
	cd "$dir" 
	trap "" INT

	export LC_ALL='C';
	IFS=$'\x0a';
	select OPT in `ls | grep -vP 'cover| ςbz|zoff alias| Renaming' | sort -bf` "." "Cancel"; do
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
