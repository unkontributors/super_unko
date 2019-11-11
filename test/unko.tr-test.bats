#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="../bin/unko.tr"

@test "unko.trでうんこは💩になる" {
  run "$TARGET_COMMAND" <<< うんこ
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
  coverage "$TARGET_COMMAND" <<< うんこ
}

@test "unko.trでうんちは💩になる" {
  run "$TARGET_COMMAND" <<< うんち
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
  coverage "$TARGET_COMMAND" <<< うんち
}

@test "unko.trで下痢は💩になる" {
  run "$TARGET_COMMAND" <<< 下痢
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
  coverage "$TARGET_COMMAND" <<< 下痢
}

@test "unko.trで💩は💩になる" {
  run "$TARGET_COMMAND" <<< 💩
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
  coverage "$TARGET_COMMAND" <<< 💩
}
