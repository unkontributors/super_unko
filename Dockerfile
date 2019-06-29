FROM ubuntu:19.04

ENV DIR_PREFIX /usr/local
ENV SRC_DIR $DIR_PREFIX/src
ENV BIN_DIR $DIR_PREFIX/bin
ENV PATH $PATH:/usr/games

RUN apt update -y \
    && apt install -y git toilet cowsay figlet \
    && git clone https://github.com/unkontributors/super_unko.git $SRC_DIR/super_unko \
    && $SRC_DIR/super_unko/install.sh \
    && git clone https://github.com/fumiyas/home-commands.git $SRC_DIR/home-commands \
    && install -m 0755 $SRC_DIR/home-commands/echo-sd $BIN_DIR/
WORKDIR $SRC_DIR/super_unko
