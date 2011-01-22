# defaults write 
alias shidden="showh"
alias showhidden="showh"
function showh () {
	s=TRUE
	if [ -n "${1}" ]
	then
		s=FALSE
	fi
	defaults write com.apple.finder AppleShowAllFiles ${s}
	killall Finder
}
function hideh () {
	s=FALSE
	if [ -n "${1}" ]
	then
		s=TRUE
	fi
	defaults write com.apple.finder AppleShowAllFiles ${s}
	killall Finder
}
function sdash () {
	s=NO
	if [ -n "${1}" ]
	then
		s=YES
	fi
	defaults write com.apple.dashboard mcx-disabled -boolean ${s}
	killall Dock
}
function hdash () {
	s=YES
	if [ -n "${1}" ]
	then
		s=NO
	fi
	defaults write com.apple.dashboard mcx-disabled -boolean ${s}
	killall Dock
}
alias safaritabs="stabs"
function stabs () {
	s=true
	if [[ "${1}" = "false"  || "${1}" = "no" || "${1}" = "n" || "${1}" = "f"  ]]
	then
		s=false
	fi
	defaults write com.apple.Safari TargetedClicksCreateTabs -bool ${s}
}

function recentstack () {
	defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }'
	killall Dock
}