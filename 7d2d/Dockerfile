FROM debian:stretch
LABEL maintainer="suzukenz"

ENV HOME /root
ENV STEAMCMD_ROOT ${HOME}/steamcmd
# You need to create and mount the volume on this path to persist game data
ENV APP_ROOT /7d2d

# Setup dependencies
RUN apt-get update && apt-get install -y \
  lib32stdc++6 \
  lib32gcc1 \
  curl  \
  telnet \
  expect \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create app root dir
RUN mkdir -p ${APP_ROOT}
VOLUME ["${APP_ROOT}"]

# Install steamcmd
RUN mkdir -p ${STEAMCMD_ROOT} && cd ${STEAMCMD_ROOT} && \
  curl -o steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" && \
  tar zxf steamcmd_linux.tar.gz && \
  rm steamcmd_linux.tar.gz

WORKDIR ${HOME}

# Add resources
COPY run.sh run.sh
COPY stop.sh stop.sh
COPY update.sh update.sh
COPY install.txt install.txt
COPY serverconfig-default.xml serverconfig-default.xml

# For control startup order on running by compose
COPY wait-for-save.sh wait-for-save.sh

# Change the ports according to the ones set in your arkmanager.cfg file.
EXPOSE 26900/TCP 26900-26903/udp

ENTRYPOINT ["./run.sh"]
