#!/usr/bin/env bats

readonly TARGET_COMMAND="../bin/unko.grep"

@test "unko.grepはうんことマッチする" {
  run bash -c "echo -e 'うんこ\nあ' | $TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "$output" = うんこ ]
}

@test "unko.grepはうんこ(2行)とマッチする" {
  run bash -c "echo -e 'うんこ\nうんち' | $TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = うんこ ]
  [ "${lines[1]}" = うんち ]
}

@test "unko.grepは💩とマッチする" {
  run bash -c "echo -e "💩" | $TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
}

