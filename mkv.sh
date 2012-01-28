#!/bin/bash
function chapters_info(){
	name=${1:-chapters.xml}
	grep 'ChapterString' chapters.xml | grep -Eo '>[^<]+'
	grep 'ChapterTimeStart' ${name} | grep -oE '[0-9:.]+'
}

function chapters_times(){
	name=${1:-chapters.xml}
	grep 'ChapterTimeStart' ${name} | grep -oE '[0-9:.]+'
}
