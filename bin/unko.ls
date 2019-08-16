#!/bin/bash
# Jot down any expression that means 💩.

THIS_DIR=$(
  cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd
)
readonly THIS_DIR

LIB_DIR="${THIS_DIR}/../lib/super_unko"
readonly LIB_DIR

awk -F , '1<NR{print $1}' "${LIB_DIR}/unko.csv"
