# vim: tw=0:
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

ENV LANG ja_JP.UTF-8
RUN apt update -yqq \
    && apt install -y --no-install-recommends \
       toilet \
       figlet \
       bc \
       cowsay \
       curl \
       ca-certificates \
       locales \
    && locale-gen ja_JP.UTF-8 \
    && rm -rf /var/lib/apt/lists/*
COPY . /usr/local/src/super_unko
WORKDIR /usr/local/src/super_unko
RUN ./install.sh
RUN curl --retry 3 https://raw.githubusercontent.com/fumiyas/home-commands/master/echo-sd > /usr/local/bin/echo-sd
RUN chmod +x /usr/local/bin/echo-sd

RUN echo -e $'\n\
＿人人人人人人人人人人人人人人人人人人人人人人人人＿\n\
＞　super_unkoイメージのビルドが無事完了したよ！　＜\n\
￣Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^￣\n\
　　　　　　👑\n\
　　　　（💩💩💩）\n\
　　　（💩👁💩👁💩）\n\
　　（💩💩💩👃💩💩💩）\n\
　（💩💩💩💩👄💩💩💩💩）'
