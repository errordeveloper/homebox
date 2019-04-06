FROM debian:stretch-slim AS build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update 

COPY dropbox.list /etc/apt/sources.list.d/dropbox.list

# We import the key manually, so that we don't need to install gpg2 before running
# other apt-get commands, and it's more reliable this way anyway.
# gpg2 --verbose --receive-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
# gpg2 --verbose --armour --output dropbox.asc --export 1C61A2656FB57B7E4DE0F4C1FC918B335044912E 
COPY dropbox.asc /etc/apt/trusted.gpg.d/dropbox.asc

RUN apt-get -qqy update 
RUN apt-get -qqy install \
    ca-certificates \
    dropbox \
    python-gpg \
    && true
RUN apt-get -qqy autoclean


RUN echo y | dropbox start -i && dropbox stop && mv /root/.dropbox-dist /opt/dropbox-dist

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.dropbox

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini

# We could use `useradd -s /usr/sbin/nologin`, but that makes container hard to debug
# and it's not very clear if we will have to do that a lot or not. If we forbid logins,
# we should probably get rid of the Python CLI also.
RUN useradd --create-home --gid 100 --uid 1000 user

FROM scratch
ENTRYPOINT ["/sbin/tini", "--"]
COPY --from=build / /
ENV HOME=/home/user
WORKDIR $HOME
CMD ["/opt/dropbox-dist/dropboxd"]
