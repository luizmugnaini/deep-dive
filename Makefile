export SHELL := /bin/bash

.PHONY: build

watch:
	latexmk -pvc -auxdir=build
build:
	latexmk -auxdir=build
