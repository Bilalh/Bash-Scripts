

function glg(){
    git log --graph --pretty="%ai %an - %s"
}

function glp(){
    git log $* --pretty="%ai %an - %s" |\
    awk '{printf  $1 " " $2; i=4; s=""; while ($i != "-"){ s= s " " $i; i++ };  \
    printf "%15s", s;  while ($i != $NF){ printf " %s", $i; i++; }  print " " $NF }'
}

function git_config_settings() {
	git config user.name  "Bilal Syed Hussain"
	git config alias.b    branch
	git config alias.lg   "log --graph --pretty=format:'%Cred%an%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --date=relative"
	git config alias.ld   "log --graph --pretty=format:'%Cred%an%Creset -%C(yellow)%d%Creset %s %Cgreen(%ai)%Creset'"
	git config alias.pom  'push origin master'
	git config alias.w    whatchanged
	git config alias.p    push
	git config alias.c    commit 
	git config alias.ca   'commit -am'
	git config alias.cam  'commit --amend -am'
	git config alias.s    status
	git config alias.d    describe
	
	git config apply.whitespace fix
	git config core.ignorecase  true
	git config core.pager       'less -FRSX'
}

alias cp_gitignore='cp  ~/.gitignore .'

function git_init () {
    git init
	git_config_settings
	git config user.email bh246@st-andrews.ac.uk
    git add .
    git commit -am first\ commit
}

alias gi='vim .gitignore'

function gitio(){
	curl -i http://git.io -F "url=$1"  -F "code=$2"
}

function git_date(){
	git ca "`ndatestamp`"
}

function ggi() { 
	curl http://gitignore.io/api/$@ ;
}
