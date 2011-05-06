#!/bin/bash
alias ww="\`www\`"
function www (){
	IFS=,; 
	select opt in `${HOME}/scripts/albums.applescript` "Cancel" ; do 
		if [ "${opt}" != "Cancel" ]; then 
			echo "${HOME}/scripts/itunes @ album ${opt}";
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
		if($3>325000){lossless++} else if($3>290000){n320++}else if($3>225000){n256++}else if($3 >175000){n192++}else if($3 > 145000){n160++} else{nless++ }  }\
	END {printf "    Total: %d\n Bitrates: Average %.0f kbps Max %0.f kbps Min %0.f kbps\n    Types: 320+: %d 320: %d 256: %d 192: %d 160: %d 160-: %d \n",\
		NR, sum/NR/1000,max/1000, min/1000,\
		lossless, n320, n256, n192, n160, nless}'
}

