package utils

import (
	"log"
	"math"
	"math/rand/v2"
	"runtime"
	"sync"
)

func HighLoad(power int, numberOfCPU int) {
	if numberOfCPU == 0 {
		numberOfCPU = runtime.NumCPU() / 2
	}
	randomNumbers := int(math.Pow(5, float64(power)))
	log.Printf("Using %d CPU cores\n", numberOfCPU)
	log.Printf("Calculating %d random number\n", randomNumbers)

	var wg sync.WaitGroup
	wg.Add(numberOfCPU)

	for i := 0; i < numberOfCPU; i++ {
		go func() {
			defer wg.Done()
			for j := 0; j < randomNumbers; j++ {
				_ = rand.Float64() * rand.Float64()
			}
		}()
	}
	wg.Wait()
}
