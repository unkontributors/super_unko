#!/bin/bash

source util.sh

readonly CMD=../bin/unko.tr

start_test unko.tr

assert_eq "うんこ -> 💩" 💩 "$(echo うんこ | $CMD)"
assert_eq "うんち -> 💩" 💩 "$(echo うんち | $CMD)"
assert_eq "下痢 -> 💩" 💩 "$(echo 下痢 | $CMD)"
assert_eq "💩 -> 💩" 💩 "$(echo 💩 | $CMD)"

end_test
