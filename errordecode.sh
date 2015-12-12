errordecode(){
	BITMASK=$(printf "%05d" "$(echo "obase=2;$1" | bc)")
	echo $BITMASK
	echo $BITMASK | grep -e '....1' > /dev/null && echo "Protection fault" || echo "No page found"
	echo $BITMASK | grep -e '...1.' > /dev/null && echo "Write access" || echo "Read Access"
	echo $BITMASK | grep -e '..1..' > /dev/null && echo "User mode access" || echo "Kernel mode access"
	echo $BITMASK | grep -e '.1...' > /dev/null && echo "Use of reserved bit detected"
	echo $BITMASK | grep -e '1....' > /dev/null && echo "Fault during instruction fetch"
}

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
