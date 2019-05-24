#!/bin/bash

source test/util.sh

__TEST_COUNT=0
__FAILED_COUNT=0

run_test() {
  local exec_script="$1"

  __TEST_COUNT=$((__TEST_COUNT + 1))

  local ret
  "$exec_script"
  ret=$?

  if [ "$ret" -ne 0 ]; then
    __FAILED_COUNT=$((__FAILED_COUNT + 1))
    return 1
  fi
}

cd test
for test_script in *-test.sh; do
  run_test ./"$test_script"
done

if [ "$__FAILED_COUNT" -eq 0 ]; then
  echo -e "$(green [SUCCESS]) test.sh completed."
  exit 0
else
  echo -e "$(red [FAILURE]) test.sh failed."
  exit 1
fi
