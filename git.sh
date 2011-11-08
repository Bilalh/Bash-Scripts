

function glg(){
    git log --graph --pretty="%ai %an - %s"
}

function glp(){
    git log $* --pretty="%ai %an - %s" |\
    awk '{printf  $1 " " $2; i=4; s=""; while ($i != "-"){ s= s " " $i; i++ };  \
    printf "%15s", s;  while ($i != $NF){ printf " %s", $i; i++; }  print " " $NF }'
}

function git_config_settings() {
	git config user.name  "Bilal Hussain"
	git config alias.b    branch
	git config alias.lg   "log --graph --pretty=format:'%Cred%an%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --date=relative"
	git config alias.ld   "log --graph --pretty=format:'%Cred%an%Creset -%C(yellow)%d%Creset %s %Cgreen(%ai)%Creset'"
	git config alias.pom  'push origin master'
	git config alias.w    whatchanged
	git config alias.p    push
	git config alias.c    commit 
	git config alias.ca   'commit -am'
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
    git add .
    git commit -am first\ commit
}


