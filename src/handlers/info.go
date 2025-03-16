package handlers

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"os"
	"runtime"
)

var Version string

type infoResponse struct {
	Version  string `json:"version"`
	OS       string `json:"os"`
	Arch     string `json:"arch"`
	Hostname string `json:"hostname"`
}

func GetInfo(c *gin.Context) {
	log.Println("[GetInfo] got request from " + c.ClientIP())

	hostname, err := os.Hostname()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	response := infoResponse{
		Version:  Version,
		OS:       runtime.GOOS,
		Arch:     runtime.GOARCH,
		Hostname: hostname,
	}

	c.JSON(http.StatusOK, response)
}
