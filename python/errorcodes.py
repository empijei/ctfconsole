#!/bin/python2.7
"""
From the linux sources:
    http://lxr.free-electrons.com/source/arch/x86/mm/fault.c?v=3.15#L27
    fault.c file:
	 26 /*
	 27  * Page fault error code bits:
	 28  *
	 29  *   bit 0 ==    0: no page found       1: protection fault
	 30  *   bit 1 ==    0: read access         1: write access
	 31  *   bit 2 ==    0: kernel-mode access  1: user-mode access
	 32  *   bit 3 ==                           1: use of reserved bit detected
	 33  *   bit 4 ==                           1: fault was an instruction fetch
	 34  */
"""

def decode_error(errorcode):
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
    return out
