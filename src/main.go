package main

import (
	"flag"
	"fmt"
	"log"
	"net"
	"net/http"
)

func getOutboundIP() string {
	conn, err := net.Dial("udp", "8.8.8.8:80")
	if err != nil {
		log.Fatal(err)
	}

	defer func(conn net.Conn) {
		_ = conn.Close()
	}(conn)

	localAddr := conn.LocalAddr().(*net.UDPAddr)
	return localAddr.IP.String()
}

func handler(w http.ResponseWriter, _ *http.Request) {
	fmt.Fprintf(w, "Hi there! I'm from ip: %s", getOutboundIP())
}

func parseFlags() string {
	serverPort := flag.String("serverPort", "8080", "Server port")
	flag.Parse()
	return *serverPort
}

func main() {
	serverPort := parseFlags()

	http.HandleFunc("/", handler)

	err := http.ListenAndServe(":"+serverPort, nil)
	if err != nil {
		log.Fatal(err)
	}
	log.Println("Server started on port " + serverPort)
}
