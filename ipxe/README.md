```bash
docker build --platform linux/amd64 -t localbuild .
docker run --rm --platform linux/amd64 -v "$(pwd)/output:/output" localbuild cp /tmp/ipxe-multiarch.iso /output/ipxe-multiarch.iso
```