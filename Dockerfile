FROM python:3.13.0a4-alpine

ARG BUILD_DATE

# first, a bit about this container
LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.authors="Mr. Ingenious" \
      org.opencontainers.image.documentation=https://github.com/mr-ingenious/docker-periodicrunner

# install usual packages
RUN apk add --no-cache tzdata curl bash jq python3 py3-pip

RUN mkdir /etc/periodic/5min \
 && mkdir /etc/periodic/1min \
 &&  mkdir /etc/periodic/30min \
 &&  mkdir /opt/additional

# script for configuration/startup
COPY assets/startup.sh /bin/startup

# marking volumes that need to be writable
VOLUME /etc/periodic
VOLUME /opt/additional
VOLUME /opt/startup

# script to run after start
ENTRYPOINT [ "/bin/startup" ]
