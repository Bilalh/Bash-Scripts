# battery left in % 
function battery () {
	ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%.2f%%\n", $10/$5 * 100)}'
}


function ql () {
	#Display the Quick Look preview for the given file.
	if [ -z "$1" ] ; then
	echo "Usage: ql "
	exit 1
	fi
	 qlmanage -p $1 >& /dev/null &
}

alias qlr="qlmanage -r"


function cdf (){
	# cdf: cd's to frontmost window of Finder
	local currFolderPath="$( /usr/bin/osascript <<-APPLESCRIPT
	tell application "Finder"
	try
	set currFolder to (folder of the front window as alias)
	on error
	set currFolder to (path to desktop folder as alias)
	end try
	POSIX path of currFolder
	end tell
	APPLESCRIPT
	)"
	# echo "pushd to \"$currFolderPath\""
	pushd "$currFolderPath" &> /dev/null
	pwd
}




function where(){
	which $1 | pbcopy && open -R `pbpaste`
}

function sysprofile(){
  /usr/sbin/system_profiler -detailLevel full -xml >mymachine.spx
}
