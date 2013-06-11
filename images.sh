#!/bin/bash
function resampleHeight(){
	size=$1
	shift
	sips --resampleHeight $size "$@"
}

function resample(){
	quality=$1
	shift
	mogrify -format jpg  -quality $quality "$@"
}

function cover(){
	filename="`gf`"
	[ $(getImageHeight) -gt 1536 ] && resampleHeight 1536 "$filename"
	resample 80 "$filename"
}


function coverBatch(){
	resampleHeight 1536 "$@"
	resample 80 "$@"
}

function getImageHeight(){
	filename=""
	if [ $# -lt 1 ]; then 
		filename="`gf`"
	else
		filename="$1"
	fi
	sips -g pixelHeight  "$filename" | tail -n1 |  egrep -o '[0-9]+'
}
