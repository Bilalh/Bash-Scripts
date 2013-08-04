#!/bin/bash

# get rid of blank lines
alias fixh="awk '!x[$0]++' .bash_history > .bash.tmp && mv -f .bash.tmp .bash_history"

function most_used(){
	cat ~/.bash_history  | grep 'sudo' | sed -E  's/sudo( +--?[a-z]+)/sudo/g' | awk '{print $2}' | cat ~/.bash_history | grep -v 'printf %b' | grep -v 'cd.*clear; pwd' | awk '{print $1}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -n | tail -n${1:-22} | sort -nr
}

function most_usedz(){
	cat ~/.zsh_history  | grep 'sudo' | sed -E  's/sudo( +--?[a-z]+)/sudo/g' | awk '{print $2}' | cat ~/.zsh_history |  psed -e 's/: [0-9]*:.;//g' | grep -v 'printf %b' | grep -v 'cd.*clear; pwd' | awk '{print $1}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -n | tail -n${1:-22} | sort -nr
}


function most_used_recent(){
	history |grep -v 'printf %b'|grep -v 'cd.*clear; pwd'|awk '{print $2}'|awk 'BEGIN {FS="|"}{print $1}'|sort|uniq -c|sort -n|tail|sort -nr
}

