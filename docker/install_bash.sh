#!/bin/bash

set -eu

SCRIPT_NAME="$(basename "${BASH_SOURCE:-$0}")"
readonly SCRIPT_NAME

usage() {
  cat << EOS
$SCRIPT_NAME は指定のバージョンのBashを/bin/bashにインストールします。
インストール前のBashは同じディレクトリにbash.oldとしてバックアップされます。

Usage:
    $SCRIPT_NAME -h | --help
    $SCRIPT_NAME <version>      [default: default]

Available version:
    default
    3.2
    4.0
    4.1
    4.2
    4.3
    4.4
    5.0
EOS
}

case $1 in
  -h | --help)
    usage
    return
    ;;
esac

readonly TMPDIR=/tmp/bash
readonly SH_VERSION=${1:-default}

mkdir -p $TMPDIR

if [[ "$SH_VERSION" != "default" ]]; then
  (
    cd "$TMPDIR"
    curl -s --retry 3 "http://ftp.gnu.org/gnu/bash/bash-${SH_VERSION}.tar.gz" | tar xvz
    cd bash*
    ./configure
    make
    make install
    mv /bin/bash{,.old}
    cp -p ./bash /bin/bash
  )
fi

bash --version
