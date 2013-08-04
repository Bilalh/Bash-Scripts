#!/bin/bash
call(){
	ack --essence -f | parallel -j+0 "echo -e '\n***  {}  ***'; source ~/.bash/conjure_bash_funcs.sh;  ca df {}; srf {}; csf {}; exit "
}

cf(){
	local _dir="${1:-`gf`}"
	local _limit="--limit-models 3"
	local _extra="${2:- ${_limit} }"
	ca ${3:-df-no-channelling} $_dir "${_extra}"; srf $_dir; csf $_dir;
}

function ca(){
	local _sdir="${2:-`gf`}"
	local __sdir=""
	if [[ ${_sdir: -7} == ".eprime" || ${_sdir: -9} == ".solution" ||  ${_sdir: -6} == ".param" ]]; then
		__sdir="`dirname ${_sdir}`";
	else
	  __sdir="${_sdir%.*}"
	fi
	
	local __name="$(basename $__sdir)"
	__essence="$(dirname $__sdir )/${__name}.essence"
	local __eprime="${__sdir}/0001.eprime"
	local _mode=${1:-compact}
	local _out="${__eprime}"
	if [ "${_mode:0:2}" = "df" ]; then
		_out="${__sdir}"
	fi

	echo "${__essence}"
	rm -rf "${__sdir}"
	mkdir -p "${__sdir}"
	set -x
	{ set -x; time conjure --mode ${_mode} \
		         --in-essence "$__essence"\
		         --out "${_out}" ${3} +RTS -M10G -s 
	} 2> "${__sdir}/ stats.txt"
	set +x
	cat  "${__sdir}/ stats.txt"
	#if [ "${_mode}" = "df" ]; then 
		#mv "${__sdir}-df"/* "${__sdir}";
		#rmdir "${__sdir}-df";
	#fi
}

#Run SR on the essence file and minion on all the generated eprime files.
#   Works on the essence file or the directory and automatic uses a param file if needed
function srf(){
	local _sdir="${1:-`gf`}"
	local __sdir=""
	if [[ ${_sdir: -7} == ".eprime" || ${_sdir: -9} == ".solution" ||  ${_sdir: -6} == ".param" ]]; then
		__sdir="`dirname ${_sdir}`";
	else
	  __sdir="${_sdir%.*}/"
	fi
	echo ${__sdir};
	
	local _base="$(basename ${__sdir} )"
	local _param=""
	if [ -f "$__sdir/${_base}.param" ]; then
		_param=" -in-param \"${__sdir}/${_base}.param\""
	fi
	ls -1 "${_sdir%.*}/"*.eprime | parallel -j+0 "echo -e '\n***  {}  ***'; savilerow -in-eprime '{}' -out-minion '{}.minion' -out-solution '{}.solution'  ${_param}"
}

# Converts all the eprime solutions back to essence.
function csf(){
	local _sdir="${1:-`gf`}"
	ls -1 ${_sdir%.*}/*.eprime.solution | parallel -j+0  'echo -e "\n***	{}	***";  conjure-solution.sh {}'
}

function csfo(){
	local _sdir="`gf`"
	ls -1 ${_sdir%.*}/*.eprime.solution | parallel -j+0  'echo -e "\n***	{}	***";  conjure-solution-Old.sh {}'
}


# Make a param file in the selected directory.
function mkp(){
	local _sdir="`gf`"
	if [[ ${_sdir: -7} == ".eprime" || ${_sdir: -9} == ".solution" ||  ${_sdir: -6} == ".param" ]]; then
		local __sdir="`dirname ${_sdir}`";
	else
		local __sdir="${_sdir%.*}/"
	fi
	local _base="$(basename ${__sdir} )"
	mkparam "$@" > "${__sdir}/${_base}.param"
	# echo "${__sdir}/${_base}.param"
}

function mk2(){
	local _sdir="`gf`"
	if [[ ${_sdir: -7} == ".eprime" || ${_sdir: -9} == ".solution" ||  ${_sdir: -6} == ".param" ]]; then
		__sdir="`dirname ${_sdir}`";
	else
		__sdir="${_sdir%.*}/"
	fi
	local _base="$(basename ${__sdir} )"
	mkparam2 "$@" > "${__sdir}/${_base}.param"
	# echo "${__sdir}/${_base}.param"
}

# Others

function srp(){
	savilerow -in-eprime "${1}" -in-param "${2}" -out-minion "${1%.*}-${2%.*}.minion" -out-solution "${1%.*}-${2%.*}.eprime-solution"
}

function csol(){
	ls -1 $PWD/*.eprime.solution | parallel -j+0 'echo -e "\n***  {}  ***"; conjure-solution.sh {}'
}

function tp(){
	ghci -isrc src/Language/E/Parser.hs -XOverloadedStrings
}

function upp(){
	upt $@ | unescapelines.rb
}

function upt(){
	date +'%a %d %b %Y %k:%M:%S %z'
	hg log -r . --template '{latesttagdistance}-{node|short}\n'
	g c ./scripts/run/up-tests.sh "$@"
}

function gh(){
	g c; ghci -isrc "src/Language/E/Up/testing/Debuging.hs" -XOverloadedStrings -XTemplateHaskell -XQuasiQuotes -DUP_DEBUG $*
}

function gr(){
	g c; ghci -isrc src/Language/E/GenerateRandomParam.hs -XOverloadedStrings -XTemplateHaskell -XQuasiQuotes -DUP_DEBUG $*
}

function gp(){
	ghci -i/Users/bilalh/CS/conjure/src /Users/bilalh/CS/conjure/src/Language/E/GenerateParams.hs -XOverloadedStrings -XTemplateHaskell -XQuasiQuotes -DUP_DEBUG $*
}

function addEssenceToEmpty(){
	for fp in `find . -maxdepth 10 -size 0`; do 
		echo "language Essence 1.3" > $fp; 
	done
}
