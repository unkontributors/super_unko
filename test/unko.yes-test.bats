#!/usr/bin/env bats

readonly TARGET_COMMAND="../bin/unko.yes"

@test "unko.yesの1つ目の文字列は💩である" {
  run bash -c "$TARGET_COMMAND | head -n 1"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "💩" ]
}

@test "unko.yesの2つ目の文字列は💩である" {
  run bash -c "$TARGET_COMMAND | head -n 2"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "💩" ]
  [ "${lines[1]}" = "💩" ]
}

