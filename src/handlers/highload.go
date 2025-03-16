package handlers

import (
	"github.com/gin-gonic/gin"
	"log"
	"myserver/utils"
	"net/http"
)

type PostHighLoadRequest struct {
	Power int `json:"power" binding:"required,min=1"`
}

func PostHighLoad(c *gin.Context) {
	log.Println("[PostHighLoad] got request from " + c.ClientIP())
	var body PostHighLoadRequest

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

	utils.HighLoad(body.Power)
}
