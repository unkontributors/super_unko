# vim: tw=0:
FROM alpine:3.9 AS build-stage

RUN echo -e $'\n\
＿人人人人人人人人人人人人人人人人人人人人人人＿\n\
＞　super_unkoイメージを今からビルドするよ！　＜\n\
＞　これには少し時間がかかるよ！　　　　　　　＜\n\
￣Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^￣\n\
　　　　　　👑\n\
　　　　（💩💩💩）\n\
　　　（💩👁💩👁💩）\n\
　　（💩💩💩👃💩💩💩）\n\
　（💩💩💩💩👄💩💩💩💩）'

ENV DIR_PREFIX /usr/local
ENV SRC_DIR $DIR_PREFIX/src
ENV BIN_DIR $DIR_PREFIX/bin

RUN apk --no-cache add \
      git \
      bash \
      perl \
      make \
      automake \
      autoconf \
      pkgconfig \
      gcc \
      musl-dev \
      libcaca-dev \
      figlet \
    && git clone https://github.com/fumiyas/home-commands.git $SRC_DIR/home-commands \
    && install -m 0755 $SRC_DIR/home-commands/echo-sd $BIN_DIR/ \
    && git clone https://github.com/schacon/cowsay.git $SRC_DIR/cowsay \
    && (cd $SRC_DIR/cowsay && ./install.sh) \
    && git clone https://github.com/cacalabs/toilet $SRC_DIR/toilet \
    && cd $SRC_DIR/toilet \
    && ./bootstrap \
    && ./configure \
    && make \
    && install -m 0755 ./src/toilet $BIN_DIR \
    && mkdir /usr/local/share/figlet/ \
    && install -m 0644 ./fonts/*.tlf /usr/local/share/figlet/
COPY . ${SRC_DIR}/super_unko
RUN ${SRC_DIR}/super_unko/install.sh

FROM alpine:3.9 AS exec-stage
RUN apk add --no-cache \
      bash \
      perl \
      libcaca-dev \
      bc \
      ncurses
COPY --from=build-stage /usr/local/bin/* /usr/local/bin/
COPY --from=build-stage /usr/local/src/toilet/fonts/* /usr/local/share/figlet/
COPY --from=build-stage /usr/local/lib/super_unko /usr/local/lib/super_unko

RUN echo -e $'\n\
＿人人人人人人人人人人人人人人人人人人人人人人人人＿\n\
＞　super_unkoイメージのビルドが無事完了したよ！　＜\n\
￣Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^￣\n\
　　　　　　👑\n\
　　　　（💩💩💩）\n\
　　　（💩👁💩👁💩）\n\
　　（💩💩💩👃💩💩💩）\n\
　（💩💩💩💩👄💩💩💩💩）'
