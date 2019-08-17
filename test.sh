#!/bin/bash

SCRIPT_NAME="$(basename "${BASH_SOURCE:-$0}")"
readonly SCRIPT_NAME

readonly BLUE=$'\x1b[34m'
readonly RESET=$'\x1b[m'

cd test

main() {
  # 引数未指定の場合は全てのテストを実行する
  local error_count=0
  local ret
  if [[ $# -lt 1 ]]; then
    for test_script in *-test.bats; do
      echo -e "${BLUE}${test_script}${RESET}"
      ./"$test_script"
      ret=$?
      if [[ "$ret" -ne 0 ]]; then
        error_count=$((error_count + 1))
      fi
      echo
    done
    return "$error_count"
  fi

  local cmd="$1"

  # ヘルプの出力
  if [[ "$cmd" = help ]]; then
    usage
    return
  fi

  # マッチするコマンドのみ実行
  for test_script in *-test.bats; do
    if [[ "$cmd"-test.bats = "$test_script" ]]; then
      echo -e "${BLUE}${test_script}${RESET}"
      ./"$test_script"
      ret=$?
      return "$ret"
    fi
  done

  usage >&2
  return 1
}

usage() {
  cat << EOS
$SCRIPT_NAME はtestディレクトリ配下のテストスクリプトを実行する。

Usage:
    $SCRIPT_NAME              全てのテストを実行する
    $SCRIPT_NAME <command>    コマンド、あるいはテストスクリプトを実行する

Available commands:
    help             このヘルプを出力する
    <test_script>    test/*-test.batsの任意の1つのスクリプト

Available test scripts:
EOS
  for test_script in *-test.bats; do
    sed 's/-test.bats//g' <<< "    $test_script"
  done
}

main ${1+"$@"}
exit $?
