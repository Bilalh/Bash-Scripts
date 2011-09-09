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
