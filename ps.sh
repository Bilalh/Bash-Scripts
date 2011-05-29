
function findPid () {
	/usr/sbin/lsof -t -c "$@" ; 
}

function sudoFindPid () {
	 sudo /usr/sbin/lsof -t -c "$@" ; 
}



#find and list processes matching a case-insensitive partial-match string
function fp () { 
	ps Ao pid,comm \
	| awk '{match($0,/[^\/]+$/); print substr($0,RSTART,RLENGTH)": "$1}'\
	| grep -i $1\
	| grep -v grep
}

function fk () { # build menu to kill process
	IFS=$'\n'
	PS3='Kill which process? '
	select OPT in $(fp $1) "Cancel"; do
		if [ $OPT != "Cancel" ]; then
			kill $(echo $OPT|awk '{print $NF}')
		fi
		break
	done
	unset IFS
}