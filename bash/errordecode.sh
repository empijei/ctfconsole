export CTFHELP=$CTFHELP"
errordecode <value> will print a human readable interpretation of a given dmesg
					error.

					example: errordecode 14 
								Error:01110
								No page found
								Write access
								User-mode access
								Use of reserved bit detected


					depends on xxd, bc, grep"

errordecode(){
	BITMASK=$(printf "%05d" "$(echo "obase=2;$1" | bc)")
	echo $BITMASK
	echo $BITMASK | grep -e '....1' > /dev/null && echo "Protection fault" || echo "No page found"
	echo $BITMASK | grep -e '...1.' > /dev/null && echo "Write access" || echo "Read Access"
	echo $BITMASK | grep -e '..1..' > /dev/null && echo "User mode access" || echo "Kernel mode access"
	echo $BITMASK | grep -e '.1...' > /dev/null && echo "Use of reserved bit detected"
	echo $BITMASK | grep -e '1....' > /dev/null && echo "Fault during instruction fetch"
}

export CTFHELP=$CTFHELP"
dmesg-readable 		will call dmesg, tail the last line and decode the error.
					if pwntools are installed it will try to look up the IP 
					with the 'cyclic -l' command.
	
 					depends on xxd, grep, [pwntools]"

dmesg-readable(){
	MESSAGE=$(dmesg | tail -1)
	echo $MESSAGE
	echo
	echo $MESSAGE | grep "error" > /dev/null &&
	ERRORCODE=$(echo $MESSAGE | cut -d' ' -f 11) && 
	errordecode $ERRORCODE
	echo
	echo $MESSAGE | grep "segfault" > /dev/null &&
	IP=$(echo $MESSAGE | cut -d' ' -f 5) &&
	CYCLIC=$(cyclic -l "0x$IP" 2>&1) 
	echo $CYCLIC  | grep -e 'CRITICAL' > /dev/null ||
	echo "Cyclic at: $CYCLIC"
}
