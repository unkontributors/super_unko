#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="../bin/unko.grep"

@test "unko.grepはうんことマッチする" {
  run "$TARGET_COMMAND" <<< "$(echo -e 'うんこ\nあ')"
  [ "$status" -eq 0 ]
  [ "$output" = うんこ ]
  coverage "$TARGET_COMMAND" <<< "$(echo -e 'うんこ\nあ')"
}

@test "unko.grepはうんこ(2行)とマッチする" {
  run "$TARGET_COMMAND" <<< "$(echo -e 'うんこ\nうんち')"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = うんこ ]
  [ "${lines[1]}" = うんち ]
  coverage "$TARGET_COMMAND" <<< "$(echo -e 'うんこ\nうんち')"
}

@test "unko.grepは💩とマッチする" {
  run "$TARGET_COMMAND" <<< "💩"
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
  coverage "$TARGET_COMMAND" <<< "💩"
}
