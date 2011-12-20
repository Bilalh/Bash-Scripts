alias spilt_on_new_line="IFS=$'\x0a';"
alias reset_split='unset IFS'
alias reload=". ${HOME}/.bashrc"

function spacesToUnderscore () {
	find . -name '* *' | while read file;
	do
	target=`echo "$file" | sed 's/ /_/g'`;
	echo "Renaming '$file' to '$target'";
	mv "$file" "$target";
	done;
}

# fixlines: edit files in place to ensure Unix line-endings
function fixLines () {
	perl -pi~ -e 's/\r\n?/\n/g' "$@" ; 
}

updateTimestamps(){
	find .  -exec touch '{}' +
}
