#!/bin/bash

source test_util.sh

readonly CMD=../bin/unko.grep

start_test unko.grep

assert_eq "うんことマッチ" うんこ "$(echo -e "うんこ\nあ" | $CMD)"
assert_eq "うんことマッチ(2行)" "$(echo -e "うんこ\nうんち")" "$(echo -e "うんこ\nあ\nうんち" | $CMD)"
assert_eq "💩とマッチ" 💩 "$(echo -e "💩" | $CMD)"

end_test
