#!/bin/bash

## util.sh はテスト用のユーティリティ関数ライブラリ。

readonly PAD="  "

## green は引数の文字列を端末上で緑色として出力する。
##
## @param msg
## @return 緑色のエスケープシーケンスで囲われたmsg
green() {
  local msg="$1"
  echo -e "\x1b[32m${msg}\x1b[0m"
}

## red は引数の文字列を端末上で赤色として出力する。
##
## @param msg
## @return 赤色のエスケープシーケンスで囲われたmsg
red() {
  local msg="$1"
  echo -e "\x1b[31m${msg}\x1b[0m"
}

## blue は引数の文字列を端末上で青色として出力する。
##
## @param msg
## @return 青色のエスケープシーケンスで囲われたmsg
blue() {
  local msg="$1"
  echo -e "\x1b[34m${msg}\x1b[0m"
}

## assert_eq はexpectとgotの値の一致を検証する。
## 一致の場合は OK を出力し、正常終了する。
## 不一致の場合は NG を出力し、異常終了する。
##
## @param desc   テストの目的・理由・何を検証したいか
## @param expect 期待値
## @param got    コマンドの実行結果
## @return 文字列の検証結果
##
## @env TEST_COUNT   テスト件数を加算
## @env FAILED_COUNT テスト失敗件数を加算
assert_eq() {
  local desc="$1"
  local expect="$2"
  local got="$3"

  TEST_COUNT=$((TEST_COUNT+1))

  if [ "$expect" = "$got" ]; then
    echo -e "${PAD}$(green [OK]) $desc" >&2
    return 0
  else
    FAILED_COUNT=$((FAILED_COUNT+1))
    echo -e "${PAD}$(red [NG]) $desc (expect = $expect, got = $got)" >&2
    return 1
  fi
}

## start_test はassert_eqを呼び出すための準備をする。
##
## @param app_name テスト対象のスクリプト名称
## @return テスト開始を表す文字列
##
## @env TEST_COUNT   テスト件数を初期化
## @env FAILED_COUNT テスト失敗件数を初期化
start_test() {
  local app_name=$1

  TEST_COUNT=0
  FAILED_COUNT=0
  echo -e "$(blue [$app_name])" >&2
}

## end_test はテストの成功・失敗の文字列を出力する。
## また、テストの終了処理（後始末）を行う。
##
## @return テストの成功・失敗の文字列
##
## @env TEST_COUNT   テスト件数を初期化
## @env FAILED_COUNT テスト失敗件数を初期化
end_test() {
  local exit_code=0

  echo
  if [ "$FAILED_COUNT" -le 0 ]; then
    echo -e "${PAD}$(green [SUCCESS]) [$TEST_COUNT] all tests are passed." >&2
  else
    echo -e "${PAD}$(red [FAILURE]) [$FAILED_COUNT/$TEST_COUNT] tests are failed." >&2
    exit_code=1
  fi
  echo

  TEST_COUNT=0
  FAILED_COUNT=0

  if [ "$exit_code" -ne 0 ]; then
    return 1
  fi
}
