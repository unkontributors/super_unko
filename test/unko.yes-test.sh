#!/bin/bash

source util.sh

readonly CMD=../bin/unko.yes

start_test unko.yes

assert_eq "1つ目の文字列は💩" 💩 "$($CMD | head -n 1)"
assert_eq "2つ目の文字列は💩" "$(echo -e "💩\n💩")" "$($CMD | head -n 2)"

end_test
