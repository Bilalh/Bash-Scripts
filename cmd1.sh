# Commands 1
#---------------------------------------------------------------------#


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

function bcalc() { echo "${*}"|bc -l; } 

function count () {
	echo "$*" | wc
}
