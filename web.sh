alias wgetf="wget --input-file="

function getyoutube(){
	cd /tmp
	now=`date +"%F_%H-%M-%S_%s"`
	url="`osascript -e 'tell application \"Camino\"' -e 'set theURL to URL of current tab of front browser window as text' -e 'end tell'`"
	wget -O "${now}" "${url}" 
	ans="`syoutube.rb ${now} | tail -n 1`"
	echo ${ans} | pbcopy
	echo ${ans}
}
alias gety="getyoutube"
