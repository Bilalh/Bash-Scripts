# Commands 2

function battery () {
	ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%.2f%%\n", $10/$5 * 100)}'
}
function cleanh () {
	cat .bash_history | grep -vP "^(op|ax|ml|mal|mai|ax|mp|mm|cr|cadd|sadd|pgui|ls|man|aes|hd|hfind|hget|geth|nums)(.*)?" >.bash_history
}
alias fixh="awk '!x[$0]++' .bash_history > .bash.tmp && mv -f .bash.tmp .bash_history"

function dict () {
	 open dict:///"$@" ; 
}

function findPid () {
	/usr/sbin/lsof -t -c "$@" ; 
}
function sudoFindPid () {
	 sudo /usr/sbin/lsof -t -c "$@" ; 
}

function fixLines () {
	# fixlines: edit files in place to ensure Unix line-endings
	perl -pi~ -e 's/\r\n?/\n/g' "$@" ; 
}
function grepdir () {
	grep -Pn "$1" *
}

function labelRecursiveH () {
	labelRecursive '.' "${1}"
}
function labelRecursive () {
	find "${1}"  \! -name ".DS_Store" -exec setLabel "${2}" '{}' \; -print
}
function readDir () {
	labelRecursive "${1}" blue
}
function readF () {
	readDir "`gf`"
}


alias readH="labelRecursiveH blue";
alias bat="battery"
alias gd="grepdir"
