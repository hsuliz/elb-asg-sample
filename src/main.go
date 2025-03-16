package main

import (
	"flag"
	"github.com/gin-gonic/gin"
	"log"
	"myserver/handlers"
	"myserver/routes"
)

var Version string

func parseFlags() string {
	serverPort := flag.String("serverPort", "8080", "Server port")
	flag.Parse()
	return *serverPort
}

func main() {
	serverPort := parseFlags()

	handlers.Version = Version

	router := gin.Default()
	routes.RegisterRoutes(router)
	log.Fatalln(router.Run(":" + serverPort))
}
