# ls
alias lsa="ls -laoh"
alias lsl="ls -loh"
alias ll="ls -loh"

alias lstree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
