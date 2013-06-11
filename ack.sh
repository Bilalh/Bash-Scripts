alias ack_music='ack --type-set=music=.mp3,.m4a,.flac,.ac3,.ogg,.aiff,.m4b,.aac,.wav,.wmv,.ape,.mka --type-set=lossless=.flac,.m4a  --type-set=flac=.flac -g'
alias ack_images='ack --type-set=images=.jpg,.png,.gif,.jp2,.tiff,.jpeg,.svg,.pdf,.bmp,.icns,.ico,.cur,.mng,webp --images -g'

function ackf(){

	local ft=$1;
	shift;
	ack  --type-set _ts=${ft} --_ts  "$*" -l;

}
