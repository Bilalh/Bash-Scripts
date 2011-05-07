# Commands alias

alias hidetex="SetFile -a V *.pdfsync *.log *.bbl *.aux *.blg  *.synctex* *.fdb* *.out *.toc"
alias showtex="SetFile -a V *.pdfsync *.log *.bbl *.aux *.blg  *.synctex* *.fdb* *.out *.toc"
alias rmtex="rm *.pdfsync *.log *.bbl *.aux *.blg  *.synctex* *.fdb* *.out *.toc"


alias ip="ifconfig | grep -P '\b(?:\d{1,3}\.){3}\d{1,3}\b ' -om 2 | tail -rn 1"
alias r19="irb19 --readline"

alias qt7="open -a QuickTime\ Player\ 7"
alias consoleapp='/Applications/Utilities/Console.app/Contents/MacOS/Console &'

alias cleart="printf %b '\033c'"
alias eject='drutil tray eject'
alias tmrl="osascript -e 'tell app \"TextMate\" to reload bundles'"

alias scrsrdesk='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'


alias get_subs='java -jar ~/bin/googlesub/Google2SRT.jar'
alias todo="less ~/Desktop/TODO.txt"
