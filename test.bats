#!/usr/bin/env bats

@test "no command" {
  run ./bin/super_unko
  [ "$status" -eq 1 ]
}

@test "help" {
  run ./bin/super_unko help
  [ "$status" -eq 0 ]
}

@test "help printpnm" {
  run ./bin/super_unko help printpnm
  [ "$status" -eq 0 ]
}

@test "ls" {
  run ./bin/super_unko ls
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = うんこ ]
}
