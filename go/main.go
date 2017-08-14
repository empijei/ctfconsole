package main

/*
errordecode
dmesg-readable
informat2outformat § hex dec bin ascii
url(en|de)code
tokens § jwt saml
*/

var kernelErrorEnum = [][2]string{
	[2]string{"No page found", "Protection fault"},
	[2]string{"Read Access", "Write access"},
	[2]string{"Kernel mode access", "User mode access"},
	[2]string{"", "Use of reserved bit detected"},
	[2]string{"", "Fault during instruction fetch"},
}

func errordecode(errorcode int) []string {
	out := make([]string, 0, 5)
	for i, val := range kernelErrorEnum {
		out = append(out, val[(errorcode>>uint(i))%2])
	}
	return out
}
