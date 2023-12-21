export SHELL := /bin/bash

.PHONY: build

watch:
	latexmk -pvc -auxdir=build
build:
	latexmk -auxdir=build
format:
	fd . --type=f --extension=tex --exec latexindent --silent --local --cruft=build --overwriteIfDifferent {}
