FROM debian:stretch-slim AS build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update 

RUN apt-get -qqy install \
    apt-transport-https \
    ca-certificates \
    curl \
    procps \
    tzdata \
    uuid-runtime \
    && true

COPY pms.list /etc/apt/sources.list.d/pms.list

# We import the key manually, so that we don't need to install curl and gpg2 before running
# other apt-get commands, and it's more reliable this way anyway.
# curl --silent --location https://downloads.plex.tv/plex-keys/PlexSign.key > pms.asc
COPY pms.asc /etc/apt/trusted.gpg.d/pms.asc

RUN apt-get -qqy update 

RUN apt-get -qqy install \
    plexmediaserver \
    && true

# Alternative option:
# RUN apt-get -qqy install \
#     ca-certificates \
#     curl \
#     xmlstarlet \
#     && true
# RUN curl --silent --location \
#   "$(curl --silent --location 'https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&distro=ubuntu&channel=16' \
#     | xmlstarlet sel --template --value-of 'string(/MediaContainer/Release/Package/@url)' -)" \
#     --output /var/tmp/pms.deb && dpkg --install /var/tmp/pms.deb

RUN apt-get -qqy autoclean

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.dropbox

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini

# We could use `useradd -s /usr/sbin/nologin`, but that makes container hard to debug
# and it's not very clear if we will have to do that a lot or not. If we forbid logins,
# we should probably get rid of the Python CLI also.
RUN useradd --create-home --gid 100 --uid 1000 user
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/home/user/Library/Application Support"
RUN mkdir -p ${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}
#COPY Preferences.xml /etc/Preferences.xml
#RUN mv /etc/Preferences.xml /home/user/Library/Application\ Support/Plex\ Media\ Server/
RUN chown 1000:100 -R /home/user/Library

FROM scratch
ENTRYPOINT ["/sbin/tini", "--"]
COPY --from=build / /
ENV HOME=/home/user
ENV PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver
WORKDIR ${PLEX_MEDIA_SERVER_HOME}
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6
ENV PLEX_UID=1000
ENV PLEX_GID=100
ENV TMPDIR="/tmp"
ENV LD_LIBRARY_PATH="${PLEX_MEDIA_SERVER_HOME}"
CMD ["/usr/lib/plexmediaserver/Plex\ Media\ Server"]
