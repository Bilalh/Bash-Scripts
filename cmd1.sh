# Commands 1
#---------------------------------------------------------------------#
function spacesToUnderscore () {
	find . -name '* *' | while read file;
	do
	target=`echo "$file" | sed 's/ /_/g'`;
	echo "Renaming '$file' to '$target'";
	mv "$file" "$target";
	done;
}
function ql () {
	#Display the Quick Look preview for the given file.
	if [ -z "$1" ] ; then
	echo "Usage: ql "
	exit 1
	fi
	 qlmanage -p $1 >& /dev/null &
}
function dotc () {
	mkdir -p pdf
	for i in *.dot
	do
		a=`echo ${i} |sed 's/.dot//g'`
		dot -Tpdf $i -o  pdf/$a.pdf 
	done
}
function cbzc () {
	for i in *; do
		 zip -rq "$i".cbz "$i"  ; 
	done;
}
function cbzr () {
	for j in *; do 
		cd "$j";  
		for i in *; do
			 zip -rq "$i".cbz "$i"  ; 
		done; 

		cd $OLDPWD; 
	done;
}
function extract() {
     if [ -f ""$1"" ] ; then
         case ""$1"" in
             *.tar.bz2)   tar xvjf "$1"     ;;
             *.tar.gz)    tar xvzf "$1"     ;;
             *.bz2)       bunzip2 "$1"      ;;
             *.rar)       unrar x "$1"      ;;
             *.gz)        gunzip "$1"       ;;
             *.tar)       tar xvf "$1"      ;;
             *.tbz2)      tar xvjf "$1"     ;;
             *.tgz)       tar xvzf "$1"     ;;
             *.zip)       unzip "$1"        ;;
             *.Z)         uncompress "$1"   ;;
             *.7z)        7z x "$1"         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
function dhist () {
	cd ~
	rm .bash_history
	>.bash_history
 	cd "$OLDPWD"
}
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
function ip2 () {
	ifconfig | sed -n '/en0/,/media/p' | grep -v inet6 | grep inet | awk '{print $2}'
}
function findword () {
	/usr/bin/grep ^"$@"$ /usr/share/dict/words ; 
}

# calc 
function bcalc() { echo "${1}"|bc -l; } 

alias ext="extract"
alias graphc="dotc"
