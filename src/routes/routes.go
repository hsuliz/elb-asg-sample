package routes

import (
	"github.com/gin-gonic/gin"
	"myserver/handlers"
)

func RegisterRoutes(router *gin.Engine) {
	router.GET("/outbound-ip", handlers.GetOutboundIP)
	router.POST("/high-load", handlers.PostHighLoad)
}
