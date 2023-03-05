# Statically linked Curl

Statically linked [Curl] container image with [Bash]

> ~ 5.5M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-curl:latest
ghcr.io/awesome-containers/static-curl:7.88.1

docker.io/awesomecontainers/static-curl:latest
docker.io/awesomecontainers/static-curl:7.88.1
```

Slim statically linked [Curl] container image with [Bash] packaged with [UPX]

> ~ 2,6M (578K bash)

```bash
ghcr.io/awesome-containers/static-curl:latest-slim
ghcr.io/awesome-containers/static-curl:7.88.1-slim

docker.io/awesomecontainers/static-curl:latest-slim
docker.io/awesomecontainers/static-curl:7.88.1-slim
```

[Curl]: https://curl.se/
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_CURL_IMAGE="$image" \
  --build-arg STATIC_CURL_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
