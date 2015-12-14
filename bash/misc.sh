alias la="ls -la"

export CTFHELP=$CTFHELP"
analyze <file> 		will print useful informations about the given file and will
					also create a fileinfo.log with the same informations.

					commands called:
						file
						binwalk
						trid
						extract
						on ELF files:
							checksec
							strings (this will only be written to the log)
						on the other files:
							strings

					depends on the commands above"

analyze(){
	FILE=`file "$1"`
	echo File:
	echo $FILE
	echo "$1" > fileinfo.log
	echo $FILE >> fileinfo.log
	echo \n--BINWALK-- >> fileinfo.log
	echo \nBinWalk:
	binwalk "$1" | tee -a fileinfo.log
	echo \n--TRID-- >> fileinfo.log
	echo \nTrid:
	trid "$1" | tee -a fileinfo.log
	echo \n--EXTRACT-- >> fileinfo.log
	echo \nExtract:
	extract "$1" | tee -a fileinfo.log
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
		strings "$1" | tee -a fileinfo.log
	fi

}

#TODO
help(){
	#format conversion
	#cyclic from pwn
	#ropper
	#
	#
	echo $CTFHELP
}

#TODO
#ctf(){

#}

#TODO improve creating a folder in the root of a ctf
challenge(){
	mkdir "$@"
	cd "$@"
}
