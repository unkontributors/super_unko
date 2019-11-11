#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="$(pwd)/../bin/super_unko"

@test "コマンドを指定しない場合はヘルプを出力して、異常終了する" {
  run "$TARGET_COMMAND"
  [ "$status" -ne 0 ]
  coverage "$TARGET_COMMAND"
}

@test "ヘルプを明示的に出力するときは正常終了する" {
  run "$TARGET_COMMAND" help
  [ "$status" -eq 0 ]
  coverage "$TARGET_COMMAND" help
}

@test "unko.lsを呼び出す" {
  run "$TARGET_COMMAND" ls
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = うんこ ]
  coverage "$TARGET_COMMAND" ls
}

@test "unko.anyを呼び出す" {
  run "$TARGET_COMMAND" any
  [ "$status" -eq 0 ]
  coverage "$TARGET_COMMAND" any
}

@test "unko.trを呼び出す" {
  run "$TARGET_COMMAND" tr <<< うんこ
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = 💩 ]
  coverage "$TARGET_COMMAND" tr <<< うんこ
}

@test "unko.towerを呼び出す" {
  run "$TARGET_COMMAND" tower
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（　　　）" ]
  [ "${lines[2]}" = "　　（　　　　　）" ]
  [ "${lines[3]}" = "　（　　　　　　　）" ]
  coverage "$TARGET_COMMAND" tower
}

@test "unko.tower 2を呼び出す" {
  run "$TARGET_COMMAND" tower 2
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　人" ]
  [ "${lines[1]}" = "　　（　　　）" ]
  [ "${lines[2]}" = "　（　　　　　）" ]
  coverage "$TARGET_COMMAND" tower 2
}

@test "bigunko.showを呼び出す" {
  run "$TARGET_COMMAND" bigshow
  [ "$status" -eq 0 ]
  coverage "$TARGET_COMMAND" bigshow
}

@test "存在しないコマンドのときは異常終了する" {
  run "$TARGET_COMMAND" unchi
  [ "$status" -ne 0 ]
  coverage "$TARGET_COMMAND" unchi
}
