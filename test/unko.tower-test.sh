#!/bin/bash

source util.sh

readonly CMD=../bin/unko.tower

start_test unko.tower

assert_eq "引数なしのときは3段" "$(echo -e "　　　　　人\n　　　（　　　）\n　　（　　　　　）\n　（　　　　　　　）")" "$($CMD)"
assert_eq "引数を指定 2" "$(echo -e "　　　　人\n　　（　　　）\n　（　　　　　）")" "$($CMD 2)"
assert_eq "引数を指定 3" "$(echo -e "　　　　　人\n　　　（　　　）\n　　（　　　　　）\n　（　　　　　　　）")" "$($CMD 3)"
assert_eq "引数を指定 4" "$(echo -e "　　　　　　人\n　　　　（　　　）\n　　　（　　　　　）\n　　（　　　　　　　）\n　（　　　　　　　　　）")" "$($CMD 4)"
assert_eq "-sオプション 中を繰り返した文字列で埋める" "$(echo -e "　　　　　人\n　　　（あいあ）\n　　（いあいあい）\n　（あいあいあいあ）")" "$($CMD -s あい)"
assert_eq "-mオプション 先頭から文字列を埋めていく。繰り返しはしない。" "$(echo -e "　　　　　人\n　　　（あいう）\n　　（　　　　　）\n　（　　　　　　　）")" "$($CMD -m あいう)"

end_test
