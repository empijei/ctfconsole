#FORMATS CONVERTER
export CTFHELP=$CTFHELP"
formats converter:
informat2outformat <string> will convert from the input format to the output one.
					supported input/output formats: hex dec bin ascii
					example: hex2ascii 0x41 → A 
					(works even without the leading '0x')
					
					you can also type 'informat2all' that will convert to all 
					out format supported for the given input.
					example: hex2all 41 → Dec: 'Dec: 65 Bin: 1000001 ASCII:A'

					depends on xxd, grep, sed, bc"
#HEX
hex2dec(){     
	for var in `echo "$@"`
	do
		local HEX=$(echo $var | sed 's/0x//g')
		echo "obase=10;ibase=16;$HEX" | bc    
	done
}                  
                   
hex2ascii(){              
	for var in `echo "$@"`
	do
		local HEX=$(echo $var | sed 's/0x//g')
		echo $HEX | grep '^\(..\)*.$' > /dev/null && HEX="0$HEX" || HEX="$HEX"
		printf $(echo $HEX | sed -r 's/(..)/\\x\1/g')" " 
	done
}                         

hex2bin(){                
	for var in `echo "$@"`
	do
		local HEX=$(echo $var | sed 's/0x//g')
		echo "obase=2;ibase=16;$HEX" | bc     
	done
}                                      

hex2all(){                
	echo Dec:         
	hex2dec $@            
	echo Bin:          
	hex2bin $@                                          
	echo ASCII:                                         
	hex2ascii $@                                        
} 
#DEC
dec2hex(){
	for var in `echo "$@"`
	do
		printf '%x\n' "$var"
	done
}
dec2bin(){
	for var in `echo "$@"`
	do
		echo "obase=2;$var" | bc
	done
}
dec2ascii(){
	for var in `echo "$@"`
	do
		hex2ascii $(dec2hex $var)
	done
}
dec2all(){
	echo Hex:
	dec2hex $@
	echo Bin:
	dec2bin $@
	echo ASCII:
	dec2ascii $@
}

#BIN
bin2hex(){
	for var in `echo "$@"`
	do
		echo "obase=16;ibase=2;$var" | bc
	done
}
bin2dec(){
	for var in `echo "$@"`
	do
		echo "obase=10;ibase=2;$var" | bc
	done
}
bin2ascii(){
	for var in `echo "$@"`
	do
		hex2ascii "$(bin2hex $var)"
	done
}
bin2all(){
	echo Hex:
	bin2hex $@
	echo Dec:
	bin2dec $@
	echo ASCII:
	bin2ascii $@
}

#ASCII
ascii2hex(){
	for var in "$@"
	do
		local length="${#var}"
		for (( i = 0; i < length; i++ ))
		do
			local c="${var:$i:1}"
			echo -n "$c" | xxd | cut -d" " -f 2
		done
	done
}
ascii2bin(){
	hex2bin "$(ascii2hex $@)"
}
ascii2dec(){
	hex2dec "$(ascii2hex $@)"
}
ascii2all(){
	echo Hex:
	ascii2hex $@
	echo Bin:
	ascii2bin $@
	echo Dec:
	ascii2dec $@
}

