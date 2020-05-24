FROM unkontributors/super_unko:latest

ARG SH_VERSION=default

# Install bash-x.x
COPY ./install_bash.sh /tmp/install_bash.sh
RUN apt update -yqq \
    && apt install -y --no-install-recommends build-essential bats byacc \
    && rm -rf /var/lib/apt/lists/* \
    && /tmp/install_bash.sh ${SH_VERSION} \
    && ./install.sh
