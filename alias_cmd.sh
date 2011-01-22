# Commands alias



alias hidetex="SetFile -a V *.pdfsync *.log *.bbl *.aux *.blg  *.synctex* *.fdb* *.out *.toc"
alias showtex="SetFile -a V *.pdfsync *.log *.bbl *.aux *.blg  *.synctex* *.fdb* *.out *.toc"

alias cleart="printf %b '\033c'"
alias consoleapp='/Applications/Utilities/Console.app/Contents/MacOS/Console &'
alias eject='drutil tray eject'
alias ip="ifconfig | grep -P '\b(?:\d{1,3}\.){3}\d{1,3}\b ' -om 2 | tail -rn 1"
alias q7="open -a QuickTime\ Player\ 7"
alias qlr="qlmanage -r"
alias r19="irb19 --readline"
alias scrsrdesk='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
alias tmrl="osascript -e 'tell app \"TextMate\" to reload bundles'"
