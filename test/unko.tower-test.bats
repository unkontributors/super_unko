#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="../bin/unko.tower"

@test 'unko.towerは引数なしのときは3段' {
  run "$TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（　　　）" ]
  [ "${lines[2]}" = "　　（　　　　　）" ]
  [ "${lines[3]}" = "　（　　　　　　　）" ]
  coverage "$TARGET_COMMAND"
}

@test 'unko.towerで引数2' {
  run "$TARGET_COMMAND" 2
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　人" ]
  [ "${lines[1]}" = "　　（　　　）" ]
  [ "${lines[2]}" = "　（　　　　　）" ]
  coverage "$TARGET_COMMAND" 2
}

@test 'unko.towerで引数4' {
  run "$TARGET_COMMAND" 4
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　　人" ]
  [ "${lines[1]}" = "　　　　（　　　）" ]
  [ "${lines[2]}" = "　　　（　　　　　）" ]
  [ "${lines[3]}" = "　　（　　　　　　　）" ]
  [ "${lines[4]}" = "　（　　　　　　　　　）" ]
  coverage "$TARGET_COMMAND" 4
}

@test 'unko.towerでメッセージを埋め込む' {
  run "$TARGET_COMMAND" -s あい
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（あいあ）" ]
  [ "${lines[2]}" = "　　（いあいあい）" ]
  [ "${lines[3]}" = "　（あいあいあいあ）" ]
  coverage "$TARGET_COMMAND" -s あい
}

@test 'unko.towerで先頭から文字数分だけメッセージを埋め込む' {
  run "$TARGET_COMMAND" -m あい
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（あい　）" ]
  [ "${lines[2]}" = "　　（　　　　　）" ]
  [ "${lines[3]}" = "　（　　　　　　　）" ]
  coverage "$TARGET_COMMAND" -m あい
}

@test 'unko.towerで半角文字は全角文字１つ分で置換される' {
  run "$TARGET_COMMAND" -m ab
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（a b 　）" ]
  [ "${lines[2]}" = "　　（　　　　　）" ]
  [ "${lines[3]}" = "　（　　　　　　　）" ]
  coverage "$TARGET_COMMAND" -m ab
}

@test 'unko.tower -mで置換文字に/が含まれていても置換できる' {
  run "$TARGET_COMMAND" -m /
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（/ 　　）" ]
  [ "${lines[2]}" = "　　（　　　　　）" ]
  [ "${lines[3]}" = "　（　　　　　　　）" ]
  coverage "$TARGET_COMMAND" -m /
}

@test 'unko.tower -sで置換文字に/が含まれていても置換できる' {
  run "$TARGET_COMMAND" -s /
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　人" ]
  [ "${lines[1]}" = "　　　（/ / / ）" ]
  [ "${lines[2]}" = "　　（/ / / / / ）" ]
  [ "${lines[3]}" = "　（/ / / / / / / ）" ]
  coverage "$TARGET_COMMAND" -s /
}

@test 'unko.tower -sで置換文字に\\が含まれていても置換できる' {
  run "$TARGET_COMMAND" -s '\\'
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = '　　　　　人' ]
  [ "${lines[1]}" = '　　　（\ \ \ ）' ]
  [ "${lines[2]}" = '　　（\ \ \ \ \ ）' ]
  [ "${lines[3]}" = '　（\ \ \ \ \ \ \ ）' ]
  coverage "$TARGET_COMMAND" -s '\\'
}

@test 'unko.tower -sASCIIコード表33~127までの全ての文字は半角文字として扱う (\\は除外)' {
  grep -o . <<< '!"#$%&'"'"'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~' | while read -r ch; do
    run "$TARGET_COMMAND" -s "$ch"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "　　　　　人" ]
    [ "${lines[1]}" = "　　　（$ch $ch $ch ）" ]
    [ "${lines[2]}" = "　　（$ch $ch $ch $ch $ch ）" ]
    [ "${lines[3]}" = "　（$ch $ch $ch $ch $ch $ch $ch ）" ]
    coverage "$TARGET_COMMAND" -s "$ch"
  done
}

