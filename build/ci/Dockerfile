FROM unkontributors/super_unko:latest

ARG SH_VERSION=default

RUN apk --no-cache add bats curl
RUN apk --no-cache add gcc \
      automake \
      autoconf \
      pkgconfig \
      musl-dev
RUN apk --no-cache add make

COPY ./install_bash.sh /tmp/install_bash.sh
RUN /tmp/install_bash.sh ${SH_VERSION}
