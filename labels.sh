function labelRecursiveH () {
	labelRecursive '.' "${1}"
}
function labelRecursive () {
	find "${1}"  \! -name ".DS_Store" -exec setLabel "${2}" '{}' \; -print
}
function hideExtensionRecursive () {
	find "${1}"  -exec hide_extension.applescript '{}' \; -print
}


function readDir () {
	labelRecursive "${1}" blue
}
function readF () {
	readDir "`gf`"
}

function watchedDir () {
	labelRecursive "${1}" orange  
}
function watchedF () {
	watchedDir "`gf`"
}

alias readH="labelRecursiveH blue";
alias watchedH="labelRecursiveH orange";