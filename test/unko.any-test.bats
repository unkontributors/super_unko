#!/usr/bin/env bats

readonly TARGET_COMMAND="../bin/unko.any"

@test "引数がない場合はヘルプを出力する" {
  run "$TARGET_COMMAND"
  [ "$status" -eq 0 ]
}

@test "引数が1つのときは💩の置換のみ" {
  run "$TARGET_COMMAND" あ
  [ "$status" -eq 0 ]
}

@test "引数が2つのときは💩の置換と文言変更" {
  run "$TARGET_COMMAND" あ い
  [ "$status" -eq 0 ]
}
