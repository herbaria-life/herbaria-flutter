# Makefile to automate some commands

tests:
	flutter test

lint:
	flutter format ./lib/

analyze:
	flutter analyze

all: lint analyze tests
