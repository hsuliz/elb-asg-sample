package main

import (
	"flag"
	"github.com/gin-gonic/gin"
	"myserver/routes"
)

func parseFlags() string {
	serverPort := flag.String("serverPort", "8080", "Server port")
	flag.Parse()
	return *serverPort
}

func main() {
	serverPort := parseFlags()
	router := gin.Default()

	routes.RegisterRoutes(router)

	router.Run(":" + serverPort)
}
