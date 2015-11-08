#!/bin/bash
clone:
	./vendor.sh clone deps

update:
	./vendor.sh update deps

run:
	GO15VENDOREXPERIMENT=1 go run main.go