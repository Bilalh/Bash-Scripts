
function mediah(){
	hashfile="/Users/bilalh/Library/Application Support/Media/zzhash"
	dir="$1";
	shift;
	media "$dir" --hashlocation "${hashfile}" $*
}

alias mg='mediaf'
function mediaf(){
	full="`gf`";

	name=`basename "${full}"`;
	ext="${name##*.}"

	search="";
	dir=${full};
	
	extra="";
	if [ ${#ext} -lt ${#name} ]; then
		search=${name%.*};
		dir="`dirname \"${full}\"`";
		extra='--no-hash'
	fi

	mediah "${dir}" "${search}" ${extra} --audio --out --mplayer $*

}

alias  ax='mediah --ax --out --colour-ep --label-watched'
alias  ay='ax --mplayer'
alias  ml='ay --last'
alias mll='ml --none --dot-default'
alias mlg='ml --dot-default --menu --top '

alias op='mediah --op --out --mplayer'
alias opp='op --none --dot-default'
alias opr="op --top --169 --rnd --framedrop --fast --no-out --dot-default"

alias shash='shash "/Users/bilalh/Library/Application Support/Media/zzhash"'
alias numsfs='numss'
alias on='ongoing'
alias onm='histm'

function hget () {
	shash "$1"
	shash "$1" v | pbcopy
}

function hadd() {
	
	hashfile="/Users/bilalh/Library/Application Support/Media/zzhash"
	
	if [ $#  -ne 2  ]; then
		echo "hadd key val"
	elif [[ ${#1} -lt 10 && ${#1} -gt 0 && ${#2} -gt 0 ]]; then
		key=$1
		val=$2
		printf "%d %2d ${key}\t${val}\n" ${#key} ${#val}  >> "${hashfile}";
	else 
		echo "len(key) < 10 and > 0  len(val) > 0"
	fi
}

alias mdb='open -a base /Users/bilalh/Library/Application\ Support/Media/Media.db'

alias au="ax -u"
alias mu="ml -u"
alias mlu="mll -u"
alias opu='op -u'
alias oppu='opp -u'

get_mal(){
curl -u bhterra:bhterramai\#  "http://myanimelist.net/api/anime/search.xml?q=$1" | grep -P 'title|id|episodes|english|synonyms'
}

