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
	echo \nTrid:
	trid "$1" | tee -a fileinfo.log
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

errordecode(){
python -c '
'"errorcode=$1"'
errorcode=str(bin(errorcode))[2:].rjust(5,"0")
out="Error:" + errorcode + "\n"
out+=("Protection fault" if errorcode[4]=="1" else "No page found")
out+="\n"
out+=("Write access" if errorcode[3]=="1" else "Read access")
out+="\n"
out+=("User-mode access" if errorcode[2]=="1" else "Kernel-mode access")
out+="\n"
if errorcode[1] =="1":
	out+="Use of reserved bit detected\n"
if errorcode[0] =="1":
	out+="Fault during instruction fetch\n"
print(out)
'  
}

formats(){
python -c '
import binascii
import code

#HEXADECIMAL

def hex2ascii(strin):
	out=""
	if( " " in strin):
		for block in strin.split(" "):
			out+=str(binascii.unhexlify(block))[2:-1]
	else:
		for x in range(0,len(strin),2):
			out+=str(binascii.unhexlify(strin[x:x+2]))[2:-1]
	return out

def ascii2hex(strin):
	out=""
	for char in strin:
		out+=hex(ord(char))[2:].rjust(2,"0") + " "
	return out

def hex2bin(strin):
	out=""
	if( " " in strin):
		for block in strin.split(" "):
			out+=str(bin(int(block,16)))[2:].rjust(8,"0") +" "
	else:
		for x in range(0,len(strin),2):
			out+=str(bin(int(strin[x:x+2],16)))[2:].rjust(8,"0") +" "

	return out
	
#TODO raise exception if %8!=0
def bin2hex(strin):
	out=""
	if(" " in strin):
		for block in strin.split(" "):
			out+=hex(int(block,2))[2:] + " "
	else:
		for x in range(0,len(strin),8):
			out+=hex(int(strin[x:x+8],2))[2:] + " "
	return out

def hex2dec(strin):
	out=""
	if( " " in strin):
		for block in strin.split(" "):
			out+=str(int(block,16))[2:].rjust(3,"0") +" "
	else:
		for x in range(0,len(strin),2):
			out+=str(int(strin[x:x+2],16))+" "
	return out

def dec2hex(strin):
	out=""
	if(" " in strin):
		for block in strin.split(" "):
			out+=hex(int(block))[2:]+" "
	else:
		for x in range(0,len(strin),3):
			out+=hex(int(strin[x:x+3]))[2:]
	return out

#ASCII
def ascii2bin(strin):
	out=""
	for char in strin:
		out+= bin(ord(char))[2:].rjust(8,"0") + " "
	return out

def bin2ascii(strin):
	out=""
	if(" " in strin):
		for block in strin.split(" "):
			out+=chr(int(block,2))
	else:
		for x in range(0,len(strin),8):
			out+=chr(int(strin[x:x+8],2))
	return out

def ascii2dec(strin):
	out=""
	for char in strin:
		out+= str(ord(char)) +" "
	return out

def dec2ascii(strin):
	out=""
	if(" " in strin):
		for block in strin.split(" "):
			out+=chr(int(block))
	else:
		for x in range(0,len(strin),3):
			out+=chr(int(strin[x:x+3]))
	return out

#BIN
def bin2dec(strin):
	out=""
	if(" " in strin):
		for block in strin.split(" "):
			out+=str(int(block,2))+" "
	else:
		for x in range(0,len(strin),8):
			out+=str(int(strin[x:x+8],2)) +" "
	return out

def dec2bin(strin):
	out=""
	if(" " in strin):
		for block in strin.split(" "):
			out+=str(bin(int(block)))[2:-1]+" "
	else:
		for x in range(0,len(strin),3):
			out+=bin(int(strin[x:x+3]))[2:-1]+" "
	return out
	return bin(int(strin))

import sys
sys.ps1 = "formats>"
print("Supported formats: hex, ascii, bin, decimal")
code.interact("To convert between values, i.e hex and bin type: hex2bin(\"9F\")", None,locals())
'}

hex2dec(){
	echo "obase=10;ibase=16;$1" | bc
}

hex2ascii(){
	#TODO warn if odd length
	printf $(echo $1 | sed -r 's/(..)/\\x\1/g')
}

hex2bin(){
	echo "obase=2;ibase=16;$1" | bc
}

hex2all(){
	echo Decimal:
	hex2dec $1
	echo Binary:
	hex2bin $1
	echo ASCII:
	hex2ascii $1
}



#TODO
help(){
	#format conversion
	#cyclic from pwn
	#ropper
	#
	#
}

#TODO
ctf(){

}

#TODO improve creating a filder in the root of a ctf
challenge(){
	mkdir "$@"
	cd "$@"
}
