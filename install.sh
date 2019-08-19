#!/bin/bash
set -ue

readonly THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%N}}")" && pwd)"
readonly BINMODE=755
readonly LIBMODE=644
readonly PREFIX="${1:-/usr/local}"
readonly PREFIX_BIN="${PREFIX}/bin"
readonly PREFIX_LIB="${PREFIX}/lib/super_unko"

install -d "${PREFIX_BIN}"
install -m "${BINMODE}" "${THIS_DIR}"/bin/* "${PREFIX_BIN}"
install -d "${PREFIX_LIB}"
install -m "${LIBMODE}" "${THIS_DIR}"/lib/super_unko/* "${PREFIX_LIB}"
