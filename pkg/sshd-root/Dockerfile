FROM linuxkit/alpine:3683c9a66cd4da40bd7d6c7da599b2dcd738b559 AS mirror

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --no-cache --initdb -p /out \
    alpine-baselayout \
    apk-tools \
    busybox \
    ca-certificates \
    musl \
    openssh-server \
    tini \
    util-linux \
    zfs \
    && true
RUN mv /out/etc/apk/repositories.upstream /out/etc/apk/repositories

FROM scratch
ENTRYPOINT []
WORKDIR /
COPY --from=mirror /out/ /
COPY etc/ /etc/
RUN mkdir -p /root/.ssh && chmod 0700 /root/.ssh
CMD ["/sbin/tini", "/etc/ssh/sshd.sh"]
