#!/usr/bin/env bats

readonly TARGET_COMMAND="../bin/unko.tr"

@test "unko.trでうんこは💩になる" {
  run bash -c "echo うんこ | $TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
}

@test "unko.trでうんちは💩になる" {
  run bash -c "echo うんち | $TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
}

@test "unko.trで下痢は💩になる" {
  run bash -c "echo 下痢 | $TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
}

@test "unko.trで💩は💩になる" {
  run bash -c "echo 💩 | $TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "$output" = 💩 ]
}

