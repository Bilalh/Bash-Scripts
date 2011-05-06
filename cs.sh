# scp files * to $1 dir on cs 
function csp(){
	dir="$1"
	shift
	scp -r "$*" "bh246@host-bh246.cs.st-andrews.ac.uk:/cs/home/bh246/${dir}" 
}

# rsync $1 to $2 
function rsync_cs () {
	rsync -e ssh -acvrz --exclude '.svn' --exclude '.git' --delete  \
	"/Users/bilalh/Uni/CS/JH/$1"                                    \
	bh246@host-bh246.cs.st-andrews.ac.uk:jh/$2
}

# alias db2="rsync_cs CS3101-DB/Practicals/CS3101-P2/ CS3101/CS3101-P2"

alias ws="cd /Users/bilalh/Uni/CS/JH/ws/"

alias stp="ssh cs3099userb@host-cs3099userb.cs.st-andrews.ac.uk"
alias cs="ssh bh246@host-bh246.cs.st-andrews.ac.uk"
alias csmount="sshfs bh246@host-bh246.cs.st-andrews.ac.uk: /Users/bilalh/Uni/CS/mount"

alias sqlt='ssht 3306 3306'

function ssht(){
	ssh -N -L $1:localhost:$2 bh246@host-bh246.cs.st-andrews.ac.uk	
}

# project
alias jh="cd /Users/bilalh/Uni/CS/JH/ws/development/"

alias rg='reportg'
function reportg(){
	pushd "/Users/bilalh/Desktop/jhreport/"  > /dev/null
	google docs get --title "Final Poker Report" --dest=temp.txt && figures/tex.rb temp.txt  > report.tex && pdflatex -interaction=batchmode report.tex; 
	popd > /dev/null
}


function jhgd(){
	cs "cd /cs/home/cs3099userb/git/development/; git ld" | less -R
}

function jhgp(){
	cs "cd /cs/home/cs3099userb/git/development/; git lg $1" | less -R
}

function jr(){
	cs "cd /cs/home/cs3099userb/git/development/; git lg -n 15 $1"
	echo
}

alias sstate='less -SI "`ls | tail -n 11 | grep "state" | tail -n 1`"'
alias ssmsg='less -SI "`ls | tail -n 11 | grep "Message" | tail -n 1`"'
alias sssys='less -SI "`ls | tail -n 11 | grep "System" | tail -n 1`"'

alias otests='jh; open tests_output/index.html'

# alias ws="open -a X11;cd /Applications/Wireshark.app/Contents/MacOS;sudo ./Wireshark"
