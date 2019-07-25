#!/bin/bash
# Jot down any expression that means 💩.

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%N}}")"; pwd)"
LIB_DIR="${THIS_DIR}/../lib/super_unko"

awk -F , '1<NR{print $1}' "${LIB_DIR}/unko.csv"
