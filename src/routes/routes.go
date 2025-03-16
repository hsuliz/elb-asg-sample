package routes

import (
	"github.com/gin-gonic/gin"
	"myserver/handlers"
)

func RegisterRoutes(router *gin.Engine) {
	router.GET("/", handlers.GetInfo)
	router.POST("/high-load", handlers.PostHighLoad)
}
