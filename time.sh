timestamp(){
	t="`date +%F_%H-%M_%s`"
	echo "$t"
	echo "$t" | pbcopy 
}
datestamp(){
	t="`date +%F`"
	echo "$t"
	echo "$t" | pbcopy 
}
