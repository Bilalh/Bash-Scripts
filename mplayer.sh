#!/bin/bash

alias mp="mpv -really-quiet"
alias mpg='mp "`gf`"' # play select finder item

# control mplayer though the pipe 
function mc (){
    echo "$*" > ~/.mplayer/pipe
}

alias p='mc pause'

function n(){
	amount=${1:-1}
	mc pt_step $amount; audio_info_display.rb
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

function mpo(){
	export USE_TAGINFO=true
	#trap "unset USE_TAGINFO; return" SIGHUP SIGINT SIGTERM
	local conf=~/.mpv/input_with_last_fm.conf
	local pipe=~/.mplayer/pipe
	echo "mpv -quiet -input conf=${conf}  -input file=${pipe} $@ 2>&1  | tee ~/.mplayer/output | grep '^#' " 
	mpv -quiet -input conf=${conf}  -input file=${pipe} "$@" 2>&1  | tee ~/.mplayer/output | grep '^# ' 
	unset USE_TAGINFO
}

# Newer version of mpn allow shuffling, mplayer options and previous/next track
# Allows the user to choice a director to play music from
# also scrobble to last.fm 
# works with unicode and whitespace
# can not be a script since it will not display more then one column
function mpm(){
	local dir=${MPM_DIR:-$HOME/Movies/add/}
	[ ! -d "$dir" ] && echo "'$dir' does not exist" && return  
	pushd "$dir" 
	export USE_TAGINFO=true
	export DISPLAY_TRACK_INFO=false
	export USE_INCREMENT=true
	trap "popd; unset LC_ALL; unset IFS; unset USE_TAGINFO; unset DISPLAY_TRACK_INFO;unset USE_INCREMENT; return" SIGHUP SIGINT SIGTERM 

	killall last_fm_scrobble_on_mplayer_played_50_with_info &> /dev/null

	export LC_ALL='C';
	IFS=$'\x0a';
	select OPT in `ls | egrep -ve 'cover| ?\ςbz| ?zoff alias| Renaming|.*txt' | sort -bf` "." ". -shuffle" "Cancel"; do
		unset LC_ALL
		if [ "${OPT}" != "Cancel" ]; then
			name=""; args=""
			if [ "x${OPT}" = "x -shuffle" ]; then 
				args="-shuffle"; 
			else
				name=${OPT};
			fi 
    		last_fm_scrobble_on_mplayer_played_50_with_info &
			local conf=~/.mpv/input_with_last_fm_for_audio.conf
			trap "popd; unset IFS; mend; unset USE_TAGINFO; unset DISPLAY_TRACK_INFO;unset USE_INCREMENT; return" SIGHUP SIGINT SIGTERM 
			mpo "$@" ${args} --no-video -input conf=${conf}  -playlist <(find "$PWD/$name/"* \
			\( -iname "*\.mp3" -o -iname "*\.m4a"  -o -iname "*\.flac" -o -iname "*\.ogg"  -o -iname "*\.wma"  \) )
		fi
		break;
	done
	unset IFS;
	popd
	unset USE_TAGINFO
	unset DISPLAY_TRACK_INFO
	unset USE_INCREMENT
}

function mpi () {

	trap "unset IFS; unset LC_ALL; return" SIGHUP SIGINT SIGTERM 
    num=${1:-23}
	export LC_ALL='C';
	IFS=',';
	
	select OPT in `random_albums.applescript ${num} | sed -e 's/, /,/g'` "Cancel"; do
		unset LC_ALL
		if [ "${OPT}" != "Cancel" ]; then		
		 	play_album.applescript "$OPT"
		fi
		break;
	done
	unset IFS;
	current_song.applescript
}


function mpma(){
	 MPM_DIR="$HOME/Movies/add/add"
	trap "unset MPM_DIR;" SIGHUP SIGINT SIGTERM
	 mpm $@
	 unset MPM_DIR;
}

function mpmgf(){
	 MPM_DIR="`gf`"
	 trap "unset MPM_DIR;" SIGHUP SIGINT SIGTERM
	 mpm $@
	 unset MPM_DIR;
}

alias m4='m 3'
alias m3='m 3'
alias m2='m 2'
alias m1='m 1'
alias m0='m 0'
function m(){
	num=${1:-4}
	shift
	MPM_DIR="$HOME/Movies/cache/${num}"
	export PLAYCOUNT_FILE="/Users/bilalh/Music/itunes_playcount.yaml"
	trap "unset MPM_DIR; unset PLAYCOUNT_FILE" SIGHUP SIGINT SIGTERM
	mpm $@
	unset MPM_DIR; unset PLAYCOUNT_FILE;
}

if [ -n "$BASH_VERSION" ]; then
	
function _mlist(){
	_comp_dir="$HOME/Movies/cache/"
	ls ${_comp_dir}	
}

function _mcomp {
	local curw
	COMPREPLY=()
	curw=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=($(compgen -W '`_mlist`' -- $curw))
	return 0
}

#  Completion for n comand
shopt -s progcomp
complete -F _mcomp m
fi

alias mstart='last_fm_scrobble_on_mplayer_played_50'
function mend(){
    killall last_fm_scrobble_on_mplayer_played_50 last_fm_scrobble_on_mplayer_played_50_with_info
    kill $(ps aux | grep lastfmsubmitd | grep -v grep  | awk '{print $2}');
	trap - SIGHUP SIGINT SIGTERM;
}
