# Makefile for Go runtime environs
GOPATH=$(shell go env GOPATH)
GOBIN=$(shell go env GOBIN)
ifeq ($(GOBIN),)
GOBIN=$(GOPATH)/bin
endif

develop:
	git config --global url."https://bowdata:$(AZURE_DEVOPS_PAT)@dev.azure.com/bowdata".insteadOf "https://bowdata@dev.azure.com/bowdata"
	go mod edit -replace bowdata.sandbox.python_package/pkg=../pkg
	go mod edit -replace bowdata.sandbox.python_package/cmd=../cmd
	go clean -i -cache -modcache
	go get -u ./...

lint:
	go mod edit -replace bowdata.test.go_module_template/pkg=../pkg
	go mod edit -replace bowdata.test.go_module_template/cmd=../cmd
	go vet -json ./...
	go install honnef.co/go/tools/cmd/staticcheck@latest && $(GOPATH)/bin/staticcheck ./...

test:
	go mod edit -replace bowdata.test.go_module_template/pkg=../pkg
	go mod edit -replace bowdata.test.go_module_template/cmd=../cmd
	go clean -testcache
	go test ./...

setup_version:
	go mod init bowdata.sandbox.python_package

build:
	go clean -i -cache -modcache
	go mod tidy
	go build -o $(GOBIN)/bowdata/sandbox/python_package

release:
	go mod edit -dropreplace=bowdata.sandbox.python_package/pkg
	go mod edit -dropreplace=bowdata.sandbox.python_package/cmd

.PHONY: setup_version develop lint test build release