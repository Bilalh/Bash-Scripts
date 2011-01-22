# AES
alias aesenc="aes -e"
alias aesdec="aes -d"
function aes () {
	enc=""
	if [ -n "${3}" ]
	then
		a="${2}"
		b="${3}"
		
		if [[ "${1}" = "-e"  || "${1}" = "-d" ]]
		then
			enc="${1}"
		else 
			echo "use -e for Encrypt or -d for Decrypt"
			return
		fi
		
	fi
	openssl enc ${enc} -aes256 -base64 -in "${a}" -out "${b}"
}

alias aesfile="aeso -d"
function aeso () {
	enc=""
	if [ -n "${2}" ]
	then
		a="${2}"
		
		if [[ "${1}" = "-e"  || "${1}" = "-d" ]]
		then
			enc="${1}"
		else 
			echo "use -e for Encrypt or -d for Decrypt"
			return
		fi
		
	fi
	openssl enc ${enc} -aes256 -base64 -in "${a}"
	printf "\n"
}
alias aeswrite="aesw -e"
function aesw () {
	enc=""
	if [ -n "${2}" ]
	then
		a="${2}"
		
		if [[ "${1}" = "-e"  || "${1}" = "-d" ]]
		then
			enc="${1}"
		else 
			echo "use -e for Encrypt or -d for Decrypt"
			return
		fi
		
	fi
	openssl enc ${enc} -aes256 -base64 -out "${a}"
	printf "\n"
}

function aest () {
	if [ -n "${2}" ]
	then
		aesfile "${1}" > temp.${2}
		open temp.${2}
		rm temp.${2}
	fi
}

alias aesread="aesr"
alias aesre="aesr -e"
alias aesrd="aesr -d"
function aesr () {
	enc=""
		
	if [[ "${1}" = "-e"  || "${1}" = "-d" ]]
	then
		enc="${1}"
	else 
		echo "use -e for Encrypt or -d for Decrypt"
		return
	fi
	openssl enc ${enc} -aes256 -base64
}
