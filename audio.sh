#!/bin/bash
alias ww="'${HOME}/scripts/itunes.sh' shuffle off; \`www zselect1\` "
alias w2="'${HOME}/scripts/itunes.sh' shuffle off; \`www zselect2\` "
alias wo="'${HOME}/scripts/itunes.sh' shuffle off; \`www zselect0\`"
function www (){
	IFS=,; 
	select opt in `${HOME}/scripts/albums.applescript $1` " Cancel" ; do 
		if [ "${opt}" != "Cancel" ]; then 
			echo "${HOME}/scripts/itunes.sh" @ album "${opt}";
			#"${HOME}/scripts/itunes" @ album ${opt}; 
			break;
		fi; 
		break; 
	done; 
	unset IFS
}

function bit_rates (){
	IFS=$'\x0a'; 
	for i in `ack --music -g .`; do 
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
	#info="`afinfo \"$(gf)\" `"
	afinfo "`gf`"
}
