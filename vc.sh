alias gts="git status"
alias gl="git log"

function glg(){
	git log --graph --pretty="%ai %an - %s" 	
}

function glp(){
	git log $* --pretty="%ai %an - %s" |\
	awk '{printf  $1 " " $2; i=4; s=""; while ($i != "-"){ s= s " " $i; i++ };  \
	printf "%15s", s;  while ($i != $NF){ printf " %s", $i; i++; }  print " " $NF }'
}

function git_init () {
	git init
	#git config core.autocrlf true
	git config core.ignorecase true
	git config alias.ca 'commit -am'
	git config alias.lg "log --graph --pretty=format:'%Cred%an%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --date=relative"
	git add .
	git commit -am first\ commit
}

function git_init_b (){
	git init
	git config user.name 'Bilal Hussain'
	git config user.email bhterra@gmail.com
	#git config core.autocrlf true
	git config core.ignorecase true
	git config alias.ca 'commit -am'
	git config alias.lg "log --graph --pretty=format:'%Cred%an%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --date=relative"
	git add .
	git commit -am first\ commit
}

# Puts the git on the server
function git_cs(){
	
	if [ $# -ne 1  ]; then
		echo "Run on a git repo"
		return 
	fi

	user="bh246"
	prj="$1"
	prj_git="$1.git"
	cs_dir="/cs/home/${user}/jh/git"
	
	git clone --bare "${prj}" "${prj_git}"
	scp -r "${prj_git}" ${user}@host-${user}.cs.st-andrews.ac.uk:${cs_dir}
		
	cd "${prj}"
	git remote add origin "ssh://${user}@shell.cs.st-andrews.ac.uk${cs_dir}/${prj_git}"
	git config branch.master.remote origin
	git config branch.master.merge refs/heads/master
	cd "${OLDPWD}"
	rm -rf "${prj_git}"
}

alias svne="svn export"
