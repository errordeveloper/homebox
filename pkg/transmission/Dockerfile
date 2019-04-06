FROM linuxkit/alpine:3683c9a66cd4da40bd7d6c7da599b2dcd738b559 AS mirror

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --no-cache --initdb -p /out \
    alpine-baselayout \
    busybox \
    ca-certificates \
    musl \
    tini \
    && true
RUN mv /out/etc/apk/repositories.upstream /out/etc/apk/repositories

# also: transmission-cli?
RUN apk add --no-cache -p /out \
    transmission-daemon \
    && true

RUN adduser -D -g 100 -u 1000 user

FROM scratch
ENTRYPOINT []
COPY --from=mirror /out/ /
COPY config/ /home/user/.config/transmission-daemon/
ENV HOME=/home/user
WORKDIR $HOME
CMD ["/sbin/tini" "/usr/bin/transmission-daemon", "--foreground"]
