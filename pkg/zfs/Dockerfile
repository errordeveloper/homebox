FROM linuxkit/alpine:3683c9a66cd4da40bd7d6c7da599b2dcd738b559 AS mirror

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --no-cache --initdb -p /out \
    alpine-baselayout \
    busybox \
    ca-certificates \
    musl \
    && true
RUN mv /out/etc/apk/repositories.upstream /out/etc/apk/repositories

RUN apk add --no-cache -p /out \
    zfs \
    && true

RUN adduser -D -g 100 -u 1000 user

FROM scratch
ENTRYPOINT []
COPY --from=mirror /out/ /
