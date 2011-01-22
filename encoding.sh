# Media Encoding 

#TODO check for types 
function mkv4 () {
	mkvvideoT "$1"
	mkvaudioT "$1"
	#Fps=`mkvinfo "$1" | awk '/[0-9.]\ fps/ { print $6 }' | awk -F\( '{ print $2 }' | tail -1`
	Fps=`MediaInfo "$1" | grep "Frame rate" | grep -oP "[\d.]+"`
	name=`echo ${1} | sed 's/.mkv//g'` #removes file ext
	MP4Box -add /tmp/temp.AAC -add /tmp/temp.AVC -fps $Fps "$name.mp4"
}

function mkvspilt () {
	mkvvideo "$1"
	mkvaudio "$1"
}

function mkvvideo () {
	Type=`mediainfo "$1" | grep -A 2 'Video' | grep 'Format' | head -n 1 | grep -oP '(?<=:).*' | grep -oP '\w+'`
	Video=`MediaInfo "$1" | grep -A 1 Video | grep ID | grep -oP "\d+"`
	name=`echo ${1} | sed 's/.mkv//g'` #removes file ext
	mkvextract tracks "$1" ${Video}:"${1%.*}.${Type}"
}

function mkvaudio () {
	Type=`mediainfo "$1" | grep -A 2 'Audio' | grep 'Format' | head -n 1 | grep -oP '(?<=:).*' | sed 's/MPEG Audio/mp3/g' | grep -oP '\w+'	`
	Audio=`MediaInfo "$1" | grep -A 1 Audio | grep ID | grep -oP "\d+"`
	mkvextract tracks "$1" ${Audio}:"${1%.*}.${Type}"
}


function mkvsub () {
	Subs=`MediaInfo "$1" | grep -A 1 Text | grep ID | head -n 1 | grep -oP "\d+"`
	mkvextract tracks "$1" ${Subs}:a.ssa
}

function aac () {
	mp4box -add "$1" "${1%.*}.m4a"
}

function aac_to_mp3(){
	faad -o - "$1" | lame - "${1%.m4a}.mp3"
}

function make_mkv(){
	mkvmerge "$1" -o "${1%.*}.mkv"
}

function mp4_to_aac(){
	mkvmerge "$1" -o "temp.mkv"
	Audio=`MediaInfo "temp.mkv" | grep -A 1 Audio | grep ID | grep -oP "\d+"`
	mkvextract tracks "temp.mkv" ${Audio}:"temp.aac"
	mp4box -add "temp.aac" "${1%.*}.m4a"
	trash temp.aac
	trash temp.mkv
}

function mp4_to_mp3(){
	mkvmerge "$1" -o "temp.mkv"
	Audio=`MediaInfo "temp.mkv" | grep -A 1 Audio | grep ID | grep -oP "\d+"`
	mkvextract tracks "temp.mkv" ${Audio}:"temp.audio"
	faad -o - "temp.audio" | lame -b 160 - "${1%.*}.mp3"
	trash temp.aac
	trash temp.mkv
}

function mp4get () {
	mp4box -single "${1}" "${2}"
}

function mkvaac () {
	mkvaudioT "$1"
	name=`echo ${1} | sed 's/\.mkv//g'` #removes file ext
	mp4box -add "/tmp/temp.aac" "${name}.m4a"
}

function mkvvideoT () {
	Type=`mediainfo "$1" | grep -A 2 'Video' | grep 'Format' | head -n 1 | grep -oP '(?<=:).*' | grep -oP '\w+'`
	Video=`MediaInfo "$1" | grep -A 1 Video | grep ID | grep -oP "\d+"`
	mkvextract tracks "$1" ${Video}:/tmp/temp.${Type}
}
function mkvaudioT () {
	Type=`mediainfo "$1" | grep -A 2 'Audio' | grep 'Format' | head -n 1 | grep -oP '(?<=:).*' | sed 's/MPEG Audio/mp3/g' | grep -oP '\w+'	`
	Audio=`MediaInfo "$1" | grep -A 1 Audio | grep ID | grep -oP "\d+"`
	mkvextract tracks "$1" ${Audio}:/tmp/temp.${Type}
}

function aacToMp3_old() {
	ffmpeg -i "$1" -acodec mp3 -ac 2 -ab 196608 "${1%.*}.mp3"
}

function audiotypeS () {
	mediainfo "$1" | grep -A 2 'Audio' | grep 'Format' | head -n 1 | grep -oP '(?<=:).*' | grep -oP '\w+'
}
function audiotype () {
	mediainfo "$1" | grep -A 2 'Audio' | grep 'Format' | head -n 2
}
function videotypeS () {
	mediainfo "$1" | grep -A 2 'Video' | grep 'Format' | head -n 1 | grep -oP '(?<=:).*' | grep -oP '\w+'
}
function videotype () {
	mediainfo "$1" | grep -A 2 'Video' | grep 'Format' | head -n 2
}

function trash () {
	if [ ! -d ".Trash" ]; then
		mkdir .Trash
	fi
	mv "$1" ".Trash/$1"
}
