package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Hello, Jenkins from Go!")
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Server starting at :8080...")
	http.ListenAndServe(":8080", nil)
}
