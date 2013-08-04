# ls
alias lsa="ls -laoh"
alias lsl="ls -loh"
alias ll="ls -loh"
alias lss='lsa `find . -maxdepth 1 -type l -print`'

alias lstree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
