

function mif () {
	mediainfo "`gf`"
}

# audio tracks bit rate of selected finder item
function br () {
	mif | grep -A12 '^Audio' | ggrep -iP "Format\s{2,}|Duration|Bit rate( mode)?|Sampling rate"
}

# audio track bit rate of a file
function gbr () {
	mi "$1" | grep -A12 '^Audio' | ggrep -iP "Format\s{2,}|Duration|Bit rate( mode)?|Sampling rate"
}

function brn(){
	gbr "$1" | ggrep -P 'Bit rate\s+:' | ggrep -Po '\d+.*'
}


function vbr(){
	mif | grep -A22 '^Video' | ggrep -Pi "^Format\s{2,}|Width|Height|Writing library|Duration|Bit rate( mode)?" | grep -v 'AAC'
}


function length () {
	mediaInfo --Inform='Video;%Duration/String3%' "$1" | sed "s/\.[0-9][0-9]*$//"
}

function vif(){
	mif | ggrep  -P "Video\n" -A25  
}
