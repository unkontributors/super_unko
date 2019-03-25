#!/bin/bash
set -ue

readonly THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%N}}")" && pwd)"
readonly BINMODE=755
readonly PREFIX="${1:-/usr/local}"
readonly PREFIX_BIN="${PREFIX}/bin"

install -d "${PREFIX_BIN}"
install -m "${BINMODE}" "${THIS_DIR}"/bin/* "${PREFIX_BIN}"
