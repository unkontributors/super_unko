#!/bin/bash
set -ue

THIS_DIR=$(
  cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd
)
readonly THIS_DIR
readonly PREFIX="${1:-/usr/local}"
readonly PREFIX_BIN="${PREFIX}/bin"
readonly PREFIX_LIB="${PREFIX}/lib/super_unko"

for cmd in "${THIS_DIR}"/bin/*; do
  rm -f "$PREFIX_BIN/$(basename "$cmd")"
done
rm -rf "$PREFIX_LIB"
