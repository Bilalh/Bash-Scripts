#!/bin/bash
function letter_frequencies(){
	cat "$1" | 
	    awk -vFS="" '{for(i=1;i<=NF;i++){ if($i~/[a-zA-Z]/) { w[tolower($i)]++} } }END{for(i in w) print i,w[i]}' | 
	    sort |
	    cut -c 3- |
	    spark
}

function ss(){
	num=${1:-2}
	ruby -e "print '%s ' * ${num}" | pbcopy
	pbpaste
	echo
}

function count_source(){
  wc `ack --ignore-dir=dist -f $@` 2> /dev/null	
}
