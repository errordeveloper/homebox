FROM linuxkit/alpine:3683c9a66cd4da40bd7d6c7da599b2dcd738b559 AS mirror

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --no-cache --initdb -p /out \
    alpine-baselayout \
    busybox \
    ca-certificates \
    musl \
    && true
RUN mv /out/etc/apk/repositories.upstream /out/etc/apk/repositories

# also: transmission-cli?
RUN apk add --no-cache -p /out \
    transmission-daemon \
    && true

RUN useradd --create-home --gid 100 --uid 1000 transmission

FROM scratch
ENTRYPOINT []
WORKDIR /
# COPY etc/ /etc/
COPY --from=mirror /out/ /
CMD ["transmission-daemon", "--foreground"]
