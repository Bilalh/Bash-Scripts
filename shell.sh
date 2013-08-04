if [ -n "$BASH_VERSION" ]; then
alias whence=declare
alias spilt_on_new_line="IFS=$'\x0a';"
alias reset_split='unset IFS'
alias reload=". ${HOME}/.bashrc"
fi

function spacesToUnderscore () {
	find . -name '* *' | while read file;
	do
	target=`echo "$file" | sed 's/ /_/g'`;
	echo "Renaming '$file' to '$target'";
	mv "$file" "$target";
	done;
}

uni (){
     export LC_CTYPE=en_GB.UTF-8
     export LANG=en_GB.UTF-8
}

# fixlines: edit files in place to ensure Unix line-endings
function fixLines () {
	perl -pi~ -e 's/\r\n?/\n/g' "$@" ; 
}

updateTimestamps(){
	find .  -exec touch '{}' +
}

dot_files(){
	ls -aF | grep  -v '/$' | grep '^\.'
}

bid(){
  get_bundle_id.sh "`gf`"
}

whichv(){
	which $1 | pbcopy && vim `pbpaste`
}

rnd(){
	num=${1:-50}
	$[($RANDOM %  $num) +1]
}
