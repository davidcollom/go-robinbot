
.DEFAULT_GOAL: get


get:
	go get -v

build: build_darwin build_windows build_linux build_arm

.PHONY: build_darwin
build_darwin: get
	GOOS=darwin go build -v -o robinbot.darwin
  # shasum robinbot.darwin > robinbot.darwin.sha

.PHONY: build_windows
build_windows: get
	GOOS=windows GOARCH=386 go build -v -o robinbot.exe
  # shasum robinbot.exe > robinbot.exe.sha

.PHONY: build_linux
build_linux: get
	GOOS=linux GOARCH=amd64 go build -v -o robinbot.linux
  # shasum robinbot.linux > robinbot.linux.sha

.PHONY: build_arm
build_arm: get
	GOOS=linux GOARCH=arm GOARM=7 go build -v -o robinbot.arm
  # shasum robinbot.arm > robinbot.arm.sha

.PHONY: check
check: format lint

.PHONY: format
format:
	go fmt ./ ./cmd

.PHONY: lint
lint:
	golint ./
