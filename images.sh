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
	resampleHeight 1200 "$filename"
	
	resample 75 "$filename"
}

function coverBatch(){
	resampleHeight 1200 "$@"
	resample 75 "$@"
}

function crop_tile(){
if [ $# -lt 1 ]; then 
	echo "crop_tile src [mask] [rst]"
	return 	
fi
	convert ${2:-mask.png} $1  -gravity center -compose atop -composite ${3:-${1%.*}-rst.png}
}

