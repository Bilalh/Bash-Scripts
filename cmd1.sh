# Commands 1
#---------------------------------------------------------------------#
function spacesToUnderscore () {
	find . -name '* *' | while read file;
	do
	target=`echo "$file" | sed 's/ /_/g'`;
	echo "Renaming '$file' to '$target'";
	mv "$file" "$target";
	done;
}

function fixLines () {
	# fixlines: edit files in place to ensure Unix line-endings
	perl -pi~ -e 's/\r\n?/\n/g' "$@" ; 
}

function dotc () {
	mkdir -p pdf
	for i in *.dot
	do
		a=`echo ${i} |sed 's/.dot//g'`
		dot -Tpdf $i -o  pdf/$a.pdf 
	done
}


function findword () {
	/usr/bin/grep ^"$@"$ /usr/share/dict/words ; 
}

function bcalc() { echo "${1}"|bc -l; } 

alias graphc="dotc"
