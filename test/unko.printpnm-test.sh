#!/bin/bash

readonly RUN_TEST=true

source ../bin/unko.printpnm
source util.sh

start_test unko.printpnm

assert_eq "max_stage_col 正常系" 13 $(max_stage_col 1)
assert_eq "max_stage_row 正常系" 8 $(max_stage_row 1)
assert_eq "max_value 正常系" 3 $(max_value 1 2 3)
assert_eq "max_value 正常系(逆)" 3 $(max_value 3 2 1)
assert_eq "max_value 2桁の整数" 10 $(max_value 10 2 3)
assert_eq "repeat 正常系" 111 $(repeat 3)
assert_eq "repeat 正常系 出力文字指定" 000 $(repeat 3 0)
assert_eq "align_center 正常系" "$(echo -e '010\n111')" "$(echo -e "1\n111" | align_center 0)"
assert_eq "align_center 正常系 幅が偶数" "$(echo -e '0100\n1111')" "$(echo -e "1\n1111" | align_center 0)"

end_test
