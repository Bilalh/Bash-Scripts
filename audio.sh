#!/bin/bash


function artists(){
	for i in $1; do  
		mediainfo "$i" | grep 'Performer' | sed -e 's/.*: //'  ; 
	done
}

function nn(){
	num=${1:-3}
	www "zselect${num}"
}

function www (){
	IFS=,; 
	select opt in "Cancel" `albums.applescript $1`; do 
		if [ "${opt}" != "Cancel" ]; then 
			echo "itunes.sh" @ album "${opt/ /}";
			itunes.sh shuffle off
			itunes.sh @ album ${opt/ /}; 
			break;
		fi; 
		break; 
	done; 
	unset IFS
}

function bit_rates (){
	IFS=$'\x0a'; 
	for i in `ack_music  --music -g .`; do 
		afinfo "$i" | grep 'bit rate'; 
	done; 
	unset IFS
}

function avg_bit_rate(){
	bit_rates | awk '\
	{sum+=$3; if(min==""){min=max=$3}; if($3>max) {max=$3} else if($3< min) {min=$3};  \
		if($3>325000){lossless++} else if($3>256000){n320++} else if($3>192000){n256++} else if($3 >160000){n192++} else if($3 > 128000){n160++} else{nless++ }  }\
	END {printf "    Total: %d\n Bitrates: \033[0m\033[32mAverage\033[0m %.0f kbps  \033[0m\033[32mMax\033[0m %0.f kbps  \033[0m\033[32mMin\033[0m %0.f kbps\
    Types: 320+: %d 320: %d 256: %d 192: %d 160: %d 160-: %d \n",\
		NR, sum/NR/1000,max/1000, min/1000,\
		lossless, n320, n256, n192, n160, nless\
	}'
}


function af(){
	afinfo "`gf`" 
}

function afr(){
	afinfo "`gf`" | grep 'bit rate'
}


# bit rate of every audio file in a directory
function brd () {
	IFS=$'\x0a';	
	for i in `ack_music --music -g .` ; do
	unset IFS
		printf "\033[0m\033[34m%-65s\033[0m \033[0m\033[32m" "$i";
		info="`mediainfo \"$i\" | grep -A12 '^Audio' | egrep -i '^Bit rate( mode)?'`"
		a="`echo \"$info\" | egrep -o '\d+.*' `"
		printf "%s " "$a"
		# echo "$info" | egrep -o '\d+'
		printf "\033[0m\n"
	done
	echo
}


function aac_to_mp3(){
	faad -o - "$1" | lame - "${1%.m4a}.mp3"
}

function itunes_sync () {
	cd "/Users/bilalh/Programming/Projects/Audio-Sync/" 
	macruby itunes_sync.rb $*
	cd "$OLDPWD"
}
