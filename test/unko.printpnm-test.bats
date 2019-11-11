#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="$(pwd)/../bin/unko.printpnm"

setup() {
  export RUN_TEST=true
  load "$TARGET_COMMAND"
}

@test "unko.printpnmのmax_stage_col関数は引数1のとき13を返す" {
  run max_stage_col 1
  [ "$status" -eq 0 ]
  [ "$output" -eq 13 ]
  coverage max_stage_col 1
}

@test "unko.printpnmのmax_stage_row関数は引数1のとき8を返す" {
  run max_stage_row 1
  [ "$status" -eq 0 ]
  [ "$output" -eq 8 ]
  coverage max_stage_row 1
}

@test "unko.printpnmのmax_value関数は引数の中からもっとも大きな値を返す" {
  run max_value 1 2 3
  [ "$status" -eq 0 ]
  [ "$output" -eq 3 ]
  coverage max_value 1 2 3
}

@test "unko.printpnmのmax_value関数は引数の中からもっとも大きな値を返す。並び順は関係ない" {
  run max_value 3 2 1
  [ "$status" -eq 0 ]
  [ "$output" -eq 3 ]
  coverage max_value 3 2 1
}

@test "unko.printpnmのmax_value関数は引数の中からもっとも大きな値を返す。2桁の整数に対しても" {
  run max_value 10 12 3
  [ "$status" -eq 0 ]
  [ "$output" -eq 12 ]
  coverage max_value 10 12 3
}

@test "unko.printpnmのrepeat関数は引数の数だけ1を連続して返す" {
  run repeat 3
  [ "$status" -eq 0 ]
  [ "$output" = 111 ]
  coverage repeat 3
}

@test "unko.printpnmのrepeat関数は引数の数だけ引数を連続して返す" {
  run repeat 3 0
  [ "$status" -eq 0 ]
  [ "$output" = 000 ]
  coverage repeat 3 0
}

@test "unko.printpnmのalign_center関数は文字列を指定の文字で中央揃えして返す (奇数)" {
  run align_center 0 <<< "$(echo -e '1\n111')"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "010" ]
  [ "${lines[1]}" = "111" ]
  coverage align_center 0 <<< "$(echo -e '1\n111')"
}

@test "unko.printpnmのalign_center関数は文字列を指定の文字で中央揃えして返す (偶数)" {
  run align_center 0 <<< "$(echo -e '1\n1111')"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "0100" ]
  [ "${lines[1]}" = "1111" ]
  coverage align_center 0 <<< "$(echo -e '1\n1111')"
}

