# battery left in % 
function battery () {
	ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%.2f%%\n", $10/$5 * 100)}'
}
alias bat="battery"


function ql () {
	#Display the Quick Look preview for the given file.
	if [ -z "$1" ] ; then
	echo "Usage: ql "
	exit 1
	fi
	 qlmanage -p $1 >& /dev/null &
}

alias qlr="qlmanage -r"


function dict () {
	 open dict:///"$@" ; 
}

alias hda="hdiutil attach"
alias hdd="hdiutil detach"

alias o.="open ."
