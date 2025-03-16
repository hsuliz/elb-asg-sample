package utils

import "testing"

func BenchmarkHighLoad(b *testing.B) {
	for i := 0; i < b.N; i++ {
		HighLoad(10)
	}
}
