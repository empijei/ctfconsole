import binascii
#formats: hex, ascii, bin, decimal

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


test="ABCD"
print(ascii2hex(test))
print(ascii2bin(test))
print(ascii2dec(test))
print()
test="41424a4b"
print(hex2ascii(test))
print(hex2bin(test))
print(hex2dec(test))
print()
test="41 42 4a 4b"
print(hex2ascii(test))
print(hex2bin(test))
print(hex2dec(test))
print()
strin="1000001 1000010 1001010 1001011"
print(bin2hex(strin))
print(bin2ascii(strin))
print(bin2dec(strin))
print()
strin="0100000101000010010010101001011"
print(bin2hex(strin))
print(bin2ascii(strin))
print(bin2dec(strin))
print()
strin="65 66 74 75"
print(dec2ascii(strin))
print(dec2hex(strin))
print(dec2bin(strin))
print()
strin="065066074075"
print(dec2ascii(strin))
print(dec2hex(strin))
print(dec2bin(strin))
