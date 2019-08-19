#!/usr/bin/env bats

readonly TARGET_COMMAND="../bin/unko.tower"

@test "unko.towerは引数なしのときは3段" {
  run "$TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（　　　）" ]
  [ "${lines[2]}" = "　　（　　　　　）" ]
  [ "${lines[3]}" = "　（　　　　　　　）" ]
}

@test "unko.towerで引数2" {
  run "$TARGET_COMMAND" 2
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　人" ]
  [ "${lines[1]}" = "　　（　　　）" ]
  [ "${lines[2]}" = "　（　　　　　）" ]
}

@test "unko.towerで引数4" {
  run "$TARGET_COMMAND" 4
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　　人" ]
  [ "${lines[1]}" = "　　　　（　　　）" ]
  [ "${lines[2]}" = "　　　（　　　　　）" ]
  [ "${lines[3]}" = "　　（　　　　　　　）" ]
  [ "${lines[4]}" = "　（　　　　　　　　　）" ]
}

@test "unko.towerでメッセージを埋め込む" {
  run "$TARGET_COMMAND" -s あい
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（あいあ）" ]
  [ "${lines[2]}" = "　　（いあいあい）" ]
  [ "${lines[3]}" = "　（あいあいあいあ）" ]
}

@test "unko.towerで先頭から文字数分だけメッセージを埋め込む" {
  run "$TARGET_COMMAND" -m あい
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（あい　）" ]
  [ "${lines[2]}" = "　　（　　　　　）" ]
  [ "${lines[3]}" = "　（　　　　　　　）" ]
}

