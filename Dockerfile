FROM ubuntu:19.04

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
ENV PATH $PATH:/usr/games

RUN apt update -y \
    && apt install -y git toilet cowsay figlet \
    && git clone https://github.com/unkontributors/super_unko.git $SRC_DIR/super_unko \
    && $SRC_DIR/super_unko/install.sh \
    && git clone https://github.com/fumiyas/home-commands.git $SRC_DIR/home-commands \
    && install -m 0755 $SRC_DIR/home-commands/echo-sd $BIN_DIR/
WORKDIR $SRC_DIR/super_unko

RUN echo -e $'\n\
＿人人人人人人人人人人人人人人人人人人人人人人人人＿\n\
＞　super_unkoイメージのビルドが無事完了したよ！　＜\n\
￣Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^￣\n\
　　　　　　👑\n\
　　　　（💩💩💩）\n\
　　　（💩👁💩👁💩）\n\
　　（💩💩💩👃💩💩💩）\n\
　（💩💩💩💩👄💩💩💩💩）'
