package main

import (
    "os"
    log "github.com/sirupsen/logrus"
    "bowdata.sandbox.python_package/cmd"
)


func init() {
	log.SetOutput(os.Stdout)
	log.SetFormatter(&log.JSONFormatter{})
    logLevel, err := log.ParseLevel(os.Getenv("LOGLEVEL"))
	if err != nil {
		logLevel = log.InfoLevel
	}
	log.SetLevel(logLevel)
}

func main() {
	cmd.Execute()
}
