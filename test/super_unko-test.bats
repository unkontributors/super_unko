#!/usr/bin/env bats

readonly TARGET_COMMAND="$(pwd)/../bin/super_unko"

@test "コマンドを指定しない場合はヘルプを出力して、異常終了する" {
  run bash -c "$TARGET_COMMAND 2>&1"
  [ "$status" -ne 0 ]
  [ "$(tail -n +2 <<< $output)" = "$($TARGET_COMMAND help)" ]
}

@test "ヘルプを明示的に出力するときは正常終了する" {
  run "$TARGET_COMMAND" help
  [ "$status" -eq 0 ]
}

@test "サブコマンドのヘルプを出力する" {
  run "$TARGET_COMMAND" help printpnm
  [ "$status" -eq 0 ]
}

@test "unko.lsを呼び出す" {
  run "$TARGET_COMMAND" ls
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = うんこ ]
}

@test "unko.anyを呼び出す" {
  run "$TARGET_COMMAND" any
  [ "$status" -eq 0 ]
}

@test "unko.yesを呼び出す" {
  run bash -c "$TARGET_COMMAND yes | head -n 2"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = 💩 ]
  [ "${lines[1]}" = 💩 ]
}

@test "unko.grepを呼び出す" {
  run bash -c "$TARGET_COMMAND ls | $TARGET_COMMAND grep"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = 💩 ]
  [ "${lines[1]}" = 💩 ]
}

@test "unko.grepを呼び出す" {
  run bash -c "echo うんこ | $TARGET_COMMAND tr"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = 💩 ]
}

@test "unko.towerを呼び出す" {
  run bash -c "$TARGET_COMMAND tower"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（　　　）" ]
  [ "${lines[2]}" = "　　（　　　　　）" ]
  [ "${lines[3]}" = "　（　　　　　　　）" ]
}

@test "bigunko.showを呼び出す" {
  run bash -c "$TARGET_COMMAND bigshow"
  [ "$status" -eq 0 ]
}

@test "存在しないコマンドのときは異常終了する" {
  run bash -c "$TARGET_COMMAND unchi"
  [ "$status" -ne 0 ]
}
