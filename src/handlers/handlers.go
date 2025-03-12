package handlers

import (
	"github.com/gin-gonic/gin"
	"log"
	"myserver/utils"
	"net/http"
)

func GetOutboundIP(c *gin.Context) {
	log.Println("Got request from " + c.ClientIP())
	c.JSON(http.StatusOK, gin.H{"outbound-ip": utils.GetOutboundIP()})
}
