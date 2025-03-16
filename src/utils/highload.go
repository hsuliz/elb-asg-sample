package utils

import (
	"log"
	"math"
	"math/rand/v2"
)

func HighLoad(power int) {
	randomNumbers := int(math.Pow(2, float64(power)))
	log.Printf("Calculating %d random number\n", randomNumbers)

	for i := 0; i < randomNumbers; i++ {
		_ = rand.Float64() * rand.Float64()
	}
}
