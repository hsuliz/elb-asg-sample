package handlers

import (
	"github.com/gin-gonic/gin"
	"log"
	"myserver/dto"
	"myserver/utils"
	"net/http"
)

func GetOutboundIP(c *gin.Context) {
	log.Println("[GetOutboundIP] got request from " + c.ClientIP())
	c.JSON(http.StatusOK, gin.H{"outbound-ip": utils.GetOutboundIP()})
}

func PostHighLoad(c *gin.Context) {
	log.Println("[PostHighLoad] got request from " + c.ClientIP())
	var body dto.PostHighLoadRequest

	err := c.ShouldBindJSON(&body)
	if err != nil {
		c.Abort()
		c.JSON(http.StatusBadRequest, c.Error(err))
		return
	}

	if body.Power <= 0 {
		c.Abort()
		c.JSON(http.StatusBadRequest, c.Error(err))
		return
	}

	utils.HighLoad(body.Power, body.NumberOfCPU)
}
