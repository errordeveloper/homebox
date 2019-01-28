FROM linuxkit/alpine:3683c9a66cd4da40bd7d6c7da599b2dcd738b559 AS mirror

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --no-cache --initdb -p /out \
    alpine-baselayout \
    busybox \
    ca-certificates \
    musl \
    openssh-server \
    rsync \
    util-linux \
    && true
RUN mv /out/etc/apk/repositories.upstream /out/etc/apk/repositories

FROM scratch AS build
WORKDIR /
COPY --from=mirror /out/ /
COPY etc/ /etc/
RUN adduser -D -g 100 -u 1000 user
ENV HOME=/home/user
WORKDIR $HOME
RUN mkdir -p $HOME/.ssh
RUN chmod 0700 $HOME/.ssh
RUN chown 1000:100 $HOME/.ssh

FROM scratch
ENTRYPOINT []
WORKDIR /
COPY --from=build / /
ENV HOME=/home/user
WORKDIR $HOME
ENV PORT=2200
CMD ["/etc/ssh/sshd.sh"]
