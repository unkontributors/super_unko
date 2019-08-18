#!/usr/bin/env bats

readonly TARGET_COMMAND="$(pwd)/../bin/super_unko"

@test "no command" {
  run "$TARGET_COMMAND"
  [ "$status" -eq 1 ]
}

@test "help" {
  run "$TARGET_COMMAND" help
  [ "$status" -eq 0 ]
}

@test "help printpnm" {
  run "$TARGET_COMMAND" help printpnm
  [ "$status" -eq 0 ]
}

@test "ls" {
  run "$TARGET_COMMAND" ls
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = うんこ ]
}
