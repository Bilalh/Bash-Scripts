#!/bin/bash
function texcountDir(){
	shopt -s extglob
	texcount [^_]*tex
}
