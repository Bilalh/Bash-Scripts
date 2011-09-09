alias xcodeThemes='cd ~/Library/Developer/Xcode/UserData/FontAndColorThemes/'

function fmj () {
	s=~/Programming/Java/setting/org.eclipse.jdt.core.prefs
	if [ -n "${2}" ]
	then
		s=${2}
	fi
	cd /
	./Applications/Eclipse/Eclipse.app/Contents/MacOS/eclipse -vm java -application org.eclipse.jdt.core.JavaCodeFormatter -verbose -config "${s}" ${1}
 	cd "$OLDPWD"
}
