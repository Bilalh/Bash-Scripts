
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


function vbr(){
	mif | grep -A22 '^Video' | grep -Pi "^Format\s{2,}|Width|Height|Writing library|Duration|Bit rate( mode)?" | grep -v 'AAC'
}



