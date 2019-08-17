#!/bin/bash

readonly BLUE=$'\x1b[34m'
readonly RESET=$'\x1b[m'

cd test

for test_script in ./*-test.bats; do
  echo -e "${BLUE}${test_script:2}${RESET}"
  "$test_script"
  echo
done
