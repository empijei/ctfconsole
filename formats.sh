#HEX
hex2dec(){     
	HEX=$(echo $1 | sed 's/0x//g')
    echo "obase=10;ibase=16;$HEX" | bc    
}                  
                   
hex2ascii(){              
	HEX=$(echo $1 | sed 's/0x//g')
	#This is to even the odds with a leading 0
	echo $HEX | grep '^\(..\)*.$' > /dev/null && HEX="0$HEX" || HEX="$HEX"
    printf $(echo $HEX | sed -r 's/(..)/\\x\1/g')    
}                         
                          
hex2bin(){                
	HEX=$(echo $1 | sed 's/0x//g')
    echo "obase=2;ibase=16;$HEX" | bc     
}                                      
                          
hex2all(){                
    echo Dec:         
    hex2dec $1            
    echo Bin:          
    hex2bin $1                                          
    echo ASCII:                                         
    hex2ascii $1                                        
} 
#DEC
dec2hex(){
	printf '%x' "$1"
}
dec2bin(){
	echo "obase=2;$1" | bc
}
dec2ascii(){
	#TODO
	echo NOT IMPLEMENTED YET
}
dec2all(){
	echo Hex:
	dec2hex $1
	echo Bin:
	dec2bin $1
	echo ASCII:
	dec2ascii $1
}

#BIN
bin2hex(){
	echo "obase=16;ibase=2;$1" | bc
}
bin2dec(){
	echo "obase=10;ibase=2;$1" | bc
}
bin2ascii(){
	#TODO
	echo NOT IMPLEMENTED YET
}
bin2all(){
	echo Hex:
    bin2hex $1
	echo Dec:
	bin2dec $1
	echo ASCII:
	bin2ascii $1
}

#ASCII
ascii2hex(){
	#TODO
	echo NOT IMPLEMENTED YET
}
ascii2bin(){
	#TODO
	echo NOT IMPLEMENTED YET
}
ascii2dec(){
	#TODO
	echo NOT IMPLEMENTED YET
}
ascii2all(){
	echo Hex:
	ascii2hex $1
	echo Bin:
	ascii2bin $1
	echo ASCII:
	ascii2dec $1
}
