
function addext(){
	for i in *; do mv "$i" "${i}.${1}"; done	
}

alias mi="mediainfo"
function mif () {
	mediainfo "`gf`"
}

# audio tracks bit rate of selected finder item
function br () {
	mif | grep -A12 '^Audio' | grep -iP "Format\s{2,}|Duration|Bit rate( mode)?|Sampling rate"
}

# audio track bit rate of a file
function gbr () {
	mi "$1" | grep -A12 '^Audio' | grep -iP "Format\s{2,}|Duration|Bit rate( mode)?|Sampling rate"
}

function brn(){
	gbr "$1" | grep -P 'Bit rate\s+:' | grep -Po '\d+.*'
}


# bit rate of every audio file in a directory
function brd () {
	IFS=$'\x0a';	
	for i in `ack --music -g .` ; do
	unset IFS
		printf "\033[0m\033[34m%-60s\033[0m \033[0m\033[32m" "$i";
		info="`mediainfo \"$i\" | grep -A12 '^Audio' | grep -iP '^Bit rate( mode)?'`"
		a="`echo \"$info\" | grep -oP '\d+.*' `"
		printf "%s " "$a"
		echo "$info" | grep -oP '\w+ (?=Bit rate)'
		printf "\033[0m\n"
	done
	echo
}


function vbr(){
	mif | grep -A22 '^Video' | grep -Pi "^Format\s{2,}|Width|Height|Writing library|Duration|Bit rate( mode)?" | grep -v 'AAC'
}

N900="/Volumes/NOKIA_N900"
function n900_sync (){
	itunes_sync "${N900}/Music/" | tee "${N900}/Music/_logs/`date +'%Y-%m-%d_%s.log'`"
}

function itunes_sync () {
	cd "/Users/bilalh/Programming/Ruby/itunes_sync/"
	macruby itunes_sync.rb $*
	cd "$OLDPWD"
}

