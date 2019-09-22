FROM ubuntu:19.04 AS build-stage

ARG SH_VERSION=default

# Install bash-x.x
COPY ./install_bash.sh /tmp/install_bash.sh
RUN apt update -yqq \
    && apt install -y --no-install-recommends build-essential curl \
    && /tmp/install_bash.sh ${SH_VERSION}

FROM ubuntu:19.04 AS exec-stage

RUN apt update -yqq \
    && apt install -y --no-install-recommends toilet figlet bc bats \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build-stage /bin/bash /bin/bash
