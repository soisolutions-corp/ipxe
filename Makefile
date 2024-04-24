.DEFAULT_GOAL := bin/ipxe-multiarch.iso
.PHONY: clean nuke
export
IPXE_DOCKER_IMAGE = soi-ipxe-localbuild

bin/ipxe-multiarch.iso:
	$(MAKE) -C ipxe iso

clean:
	git clean -f -X bin/

nuke: clean
	docker image rm $(IPXE_DOCKER_IMAGE)
