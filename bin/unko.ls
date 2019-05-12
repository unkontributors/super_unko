#!/bin/bash
# Jot down any expression that means 💩.

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%N}}")"; pwd)"

awk -F , '1<NR{print $1}' "$THIS_DIR/unko.csv"
