alias ls="ls -la"

analyze(){
	FILE=`file "$1"`
	echo File:
	echo $FILE
	echo "$1" > fileinfo.log
	echo \n--BINWALK-- >> fileinfo.log
	echo $FILE >> fileinfo.log
	echo \nBinWalk:
	binwalk "$1" | tee -a fileinfo.log
	if [[ $FILE == *"ELF"* ]]
	then
		echo \nCheckSec:
		echo \n--CHECKSEC-- >> fileinfo.log
		checksec --file "$1" | tee -a fileinfo.log
		echo \n--STRINGS-- >> fileinfo.log
		strings "$1" >> fileinfo.log
	else
		echo \n--STRINGS-- >> fileinfo.log
		echo \nStrings:
		strings "$1"
	fi

}
#TODO
ctf(){

}

#TODO improve creating a filder in the root of a ctf
challenge(){
	mkdir "$@"
	cd "$@"
}

#TODO
help(){

}
