


alias mp="mplayer"
alias mm="mkvmerge"
alias mpp="mplayer -profile"

alias mpf="cdf; mplayer *"
alias mpfl="cdf;ls; mplayer *"

alias mpg='mplayer "`gf`"'

alias mpt="mplayer -profile t"
alias mfs="mplayer -profile fs"
alias mpl="mplayer -playlist"
alias mgg="mplayer -geometry 0:0 -xy"

alias gmkv="cd ~/Desktop/joinMkv/"

alias mpnl="mpn -l"
function mpn () {
	cd "/Users/bilalh/Movies/add/"
	IFS=$'\x0a';
	select OPT in `ls -tr | grep -vP 'cover|ςbz|zoff alias| Renaming'` "Cancel"; do
		if [ "${OPT}" != "Cancel" ]; then
			if [ $# -gt 0 ]; then ls "${OPT}"; fi;
			mplayer "${OPT}"/*
		fi
		break
	done
	unset IFS
}


