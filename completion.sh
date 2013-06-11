if [ -n "$BASH_VERSION" ]; then
_SSH_KNOWN_HOSTS=( $(cat ~/.ssh/known_hosts | \
  cut -f 1 -d ' ' | \
  sed -e s/,.*//g | \
  uniq | \
  egrep -v '[0-9]') )
_SSH_CONFIG_HOSTS=( $(cat ~/.ssh/config | grep "Host " | grep -v "*" | cut -f 2 -d ' ') )

complete -o default -W "${_SSH_KNOWN_HOSTS[*]} ${_SSH_CONFIG_HOSTS[*]}" ssh


function i(){
	itunes.sh "$@"
}

function _ilist(){
	itunes.sh commands
}

function _icomp(){
	local curw
	COMPREPLY=()
	curw=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=($(compgen -W '`_ilist`' -- $curw))
	return 0
}

#  Completion for itunes.sh
shopt -s progcomp
complete -F _icomp i
fi