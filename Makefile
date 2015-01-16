.PHONY: build run test clean

BINARY := bigquery-download
BUILDFILES := main.go
IMPORT_BASE := github.com/alphagov
IMPORT_PATH := $(IMPORT_BASE)/bigquery-download

build: _vendor
	gom build -o $(BINARY) $(BUILDFILES)

run: _vendor
	gom run $(BUILDFILES)

test: _vendor build
	gom test -v

clean:
	rm -f $(BINARY)

_vendor: Gomfile _vendor/src/$(IMPORT_PATH)
	gom install
	touch _vendor

_vendor/src/$(IMPORT_PATH):
	rm -f _vendor/src/$(IMPORT_PATH)
	mkdir -p _vendor/src/$(IMPORT_BASE)
	ln -s $(CURDIR) _vendor/src/$(IMPORT_PATH)
