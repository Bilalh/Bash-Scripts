if [ -n "$BASH_VERSION" ]; then
alias whence=declare
alias spilt_on_new_line="IFS=$'\x0a';"
alias reset_split='unset IFS'
alias reload=". ${HOME}/.bashrc"
fi

function qpython(){
	export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH 
	nohup /usr/local/bin/ipython qtconsole --matplotlib --colors=linux $* & 
	unset PYTHONPATH	
}

function qpython3(){
	(export PATH=/Users/bilalh/.local/anaconda/bin:$PATH
	export PYTHONPATH=/Users/bilalh/.local/anaconda/lib/python3.3/site-packages:$PYTHONPATH
	source activate py3
	ipython qtconsole --matplotlib --colors=linux $* &)
}

function jpython3(){
	export PATH=/Users/bilalh/.local/anaconda/bin:$PATH
	export PYTHONPATH=/Users/bilalh/.local/anaconda/lib/python3.3/site-packages:$PYTHONPATH
	source activate py3
	ipython $*  --colors=linux

}


function jpython(){
	(PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH; 
	 /usr/local/bin/ipython --colors=linux $*;
    )
}

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


function npath(){
	echo "${PATH//:/$'\n'}"
}

function teeDate() {
	tee "$@-`date +%F_%H-%M_%s`"
}

function record(){
    if [[ -z "${1}" || -z "${2}" ]]; then
	    echo "$0 name  command"
    else
	    name="$1"
	    shift
	    if [ "`basename \"${name}\"`" != "${name}" ]; then
		    mkdir -p "`dirname \"${name}\"`"
		fi
	    fp="${name}-`date +%F_%H-%M_%s`"
	    echo "$@" > "${fp}.cmds"
	    $@ 2>&1 | tee "${fp}.log"
    fi
}