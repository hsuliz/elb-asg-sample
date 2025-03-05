package main

import (
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

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
