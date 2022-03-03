#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="../bin/unko.encode"

@test "-h でヘルプを出力する" {
  run "$TARGET_COMMAND" -h
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ ^Usage:.* ]]
  coverage "$TARGET_COMMAND" -h
}

@test "--help でヘルプを出力する" {
  run "$TARGET_COMMAND" --help
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ ^Usage:.* ]]
  coverage "$TARGET_COMMAND" --help
}

@test '引数なしのときは標準入力をエンコード' {
  run "$TARGET_COMMAND" <<< うんこ
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "ウンウこうんこう💩ウンウこうこここウウンウこうんここウうんこ" ]
  coverage "$TARGET_COMMAND" <<< うんこ
}

@test '-d で標準入力をデコード {
  run "$TARGET_COMMAND" -d <<< ウンウこうんこう💩ウンウこうこここウウンウこうんここウうんこ
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "うんこ" ]
  coverage "$TARGET_COMMAND" -d <<< ウンウこうんこう💩ウンウこうこここウウンウこうんここウうんこ
}

@test '--decode で標準入力をデコード {
  run "$TARGET_COMMAND" --decode <<< ウンウこうんこう💩ウンウこうこここウウンウこうんここウうんこ
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "うんこ" ]
  coverage "$TARGET_COMMAND" --decode <<< ウンウこうんこう💩ウンウこうこここウウンウこうんここウうんこ
}

@test 'ファイルが存在しない場合エラー' {
  export LANG=ja_JP.UTF-8
  run "$TARGET_COMMAND" うんこ
  echo "$output"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" =~ .*そのようなファイルやディレクトリはありません ]]
  coverage LANG=ja_JP.UTF-8 "$TARGET_COMMAND" うんこ
}

@test 'ディレクトリの場合エラー' {
  export LANG=ja_JP.UTF-8
  run "$TARGET_COMMAND" .
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" =~ .*ディレクトリです ]]
  coverage LANG=ja_JP.UTF-8 "$TARGET_COMMAND" .
}

@test 'ファイルが存在しない場合エラー(英語版)' {
  export LANG=en_US.UTF-8
  run "$TARGET_COMMAND" うんこ
  echo "$output"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" =~ .*"No such file or directory" ]]
  coverage LANG=en_US.UTF-8 "$TARGET_COMMAND" うんこ
}

@test 'ディレクトリの場合エラー(英語版)' {
  export LANG=en_US.UTF-8
  run "$TARGET_COMMAND" .
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" =~ .*"Is a directory" ]]
  coverage LANG=en_US.UTF-8 "$TARGET_COMMAND" .
}
