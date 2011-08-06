# Commands 2


function cleanh () {
	cat .bash_history | grep -vP "^(op|ax|ml|mal|mai|ax|mp|mm|cr|cadd|sadd|pgui|ls|man|aes|hd|hfind|hget|geth|nums)(.*)?" >.bash_history
}

function dhist () {
	cd ~
	rm .bash_history
	>.bash_history
 	cd "$OLDPWD"
}

# get rid of blank lines
alias fixh="awk '!x[$0]++' .bash_history > .bash.tmp && mv -f .bash.tmp .bash_history"



