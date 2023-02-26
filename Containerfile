# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15

FROM ghcr.io/awesome-containers/alpine-build-essential:3.17 AS build

# hadolint ignore=DL3018
RUN apk add --no-cache \
    clang openssl-dev openssl-libs-static \
    nghttp2-dev nghttp2-static libssh2-dev libssh2-static zlib-static

# https://curl.se/download/
ARG CURL_VERSION=7.88.1

WORKDIR /src/curl
RUN set -xeu; \
    curl -#Lo curl.tar.gz \
        "https://curl.se/download/curl-$CURL_VERSION.tar.xz"; \
    tar -xvf curl.tar.gz --strip-components=1; \
    rm -f curl.tar.gz

ARG CC=clang
ARG LDFLAGS="-static -all-static"
ARG PKG_CONFIG="pkg-config --static"

ARG CFLAGS='-Wno-pointer-bool-conversion -w -g -Os -static'
RUN set -xeu; \
    export CC; \
    LDFLAGS="$LDFLAGS" PKG_CONFIG="$PKG_CONFIG" ./configure \
        --with-ssl --with-libssh2 \
        --enable-static --enable-ipv6 --enable-unix-sockets --enable-websockets \
        --disable-shared --disable-ldap; \
    make -j"$(nproc)"; \
    chmod -cR 755 src/curl; \
    chown -cR 0:0 src/curl; \
    ! ldd curl && :; \
    ./src/curl -V

# static Curl image
FROM ghcr.io/awesome-containers/static-bash:$STATIC_BASH_VERSION
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build /src/curl/src/curl /bin/curl
