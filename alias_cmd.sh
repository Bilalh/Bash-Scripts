# Commands alias

alias hidetex="SetFile -a V *.pdfsync *.log *.bbl *.aux *.blg  *.synctex.* *.fdb* *.out *.toc *.bbl *.blg"
alias showtex="SetFile -a v *.pdfsync *.log *.bbl *.aux *.blg  *.synctex.* *.fdb* *.out *.toc *.bbl *.blg"
alias rm_tex="rm *.pdfsync *.log *.bbl *.aux *.blg  *.synctex* *.fdb* *.out *.toc"


alias ip="ifconfig | grep -P '\b(?:\d{1,3}\.){3}\d{1,3}\b ' -om 2 | tail -rn 1"

alias cleart="printf %b '\033c'"

alias fix_names="fix_names.rb --excludes=' Renaming, ςbz, appb.app, Move.app, op.app, Renaming.app'"
alias fix_video_names="fix_names '*.mkv'"

alias get_subs='java -jar ~/bin/googlesub/Google2SRT.jar'
