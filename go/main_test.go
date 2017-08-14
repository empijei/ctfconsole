package main

import (
	"testing"
)

func TestErrordecode(t *testing.T) {
	for i := 0; i < 32; i++ {
		out := errordecode(i)
		for j, val := range out {
			if val != kernelErrorEnum[j][(i>>uint(j))%2] {
				t.Errorf("Error not decoded correctly")
			}
		}
	}
}
