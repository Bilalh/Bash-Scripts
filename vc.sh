alias gitc="git clone git://"
alias gs="git status"
alias gl="git log"

function glg(){
	git log --graph --pretty="%ai %an - %s" 	
}

function glp(){
	git log --pretty="%ai %an - %s" |\
	awk '{printf  $1 " " $2; i=4; s=""; while ($i != "-"){ s= s " " $i; i++ };  \
	printf "%15s", s;  while ($i != $NF){ printf " %s", $i; i++; }  print " " $NF }'
}

function git_init () {
	git init
	git add .
	git commit -am first\ commit
}

function git_init_b (){
	git init
	git config user.email bhterra@gmail.com
	git add .
	git commit -am first\ commit
}

# Puts the git on the server
function git_cs(){
	
	if [ $# -ne 1  ]; then
		echo "Run on a git repo"
		return 
	fi
	
	prj="$1"
	prj_git="$1.git"
	cs_dir="/cs/home/bh246/jh/git"
	
	git clone --bare ${prj} ${prj_git}
	scp -r ${prj_git} bh246@host-bh246.cs.st-andrews.ac.uk:${cs_dir}
	
	cd ${prj}
	git remote add master ssh://bh246@shell.cs.st-andrews.ac.uk${cs_dir}/${prj_git}
	git remote add origin ssh://bh246@shell.cs.st-andrews.ac.uk${cs_dir}/${prj_git}
	cd ${OLDPWD}
	rm ${prj_git}
}

alias svne="svn export"
