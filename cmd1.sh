
function dotc () {
	mkdir -p pdf
	for i in *.dot
	do
		a=`echo ${i} |sed 's/.dot//g'`
		dot -Tpdf $i -o  pdf/$a.pdf 
	done
}
