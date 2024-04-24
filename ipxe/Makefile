ISO_FILE := ipxe-multiarch.iso

.PHONY: build iso

BUILD_THREADS := 4
ifeq ($(shell uname -m),arm64)
include ../Makefile.arm64
endif

build:
	docker build $(PLATFORM) -t $(IPXE_DOCKER_IMAGE) --build-arg="BUILD_THREADS=$(BUILD_THREADS)" .

iso: build
	$(eval TEMP := $(shell mktemp -d))
	docker run --rm $(PLATFORM) -v "$(TEMP):/output" $(IPXE_DOCKER_IMAGE) cp /tmp/$(ISO_FILE) /output/$(ISO_FILE)
	cp $(TEMP)/$(ISO_FILE) ../bin/$(ISO_FILE)
	rm -rf $(TEMP)
