#!/bin/bash

SCRIPT_NAME="$(basename "${BASH_SOURCE:-$0}")"
readonly SCRIPT_NAME

# Dockerコンテナ系の定数
readonly CONTAINER_DIR_PREFIX=/work

# 着色系ANSIエスケープシーケンス
readonly RED=$'\x1b[31m'
readonly GREEN=$'\x1b[32m'
readonly RESET=$'\x1b[m'

# デフォルトの静的解析対象
readonly DEFAULT_TARGET_FILES=(*.sh bin/*)

# docker-composeコマンド
readonly DC_CMD=(docker-compose -f docker-compose-tools.yml)

test_count=0
err_count=0

main() {
  # 引数なしのときはヘルプを出力して終了
  if [[ $# -lt 1 ]]; then
    usage >&2
    return 1
  fi

  while ((0 < $#)); do
    local opt=$1
    shift

    case "$opt" in
      help)
        usage
        return
        ;;
      setup)
        # フォーマットとlintに使うDockerイメージを取得
        "${DC_CMD[@]}" pull formatter linter
        ;;
      format)
        # コードフォーマットにかける
        overwrite=""
        cmd_format "$@"
        print_check_result
        return $?
        ;;
      format-save)
        # コードフォーマットにかけて上書き保存
        overwrite="-w"
        cmd_format "$@"
        print_check_result
        return $?
        ;;
      lint)
        # 静的解析
        cmd_lint "$@"
        print_check_result
        return $?
        ;;
      all)
        # コードフォーマット＋静的解析
        cmd_format "$@"
        cmd_lint "$@"
        print_check_result
        return $?
        ;;
      *)
        usage >&2
        return 1
        ;;
    esac
  done
}

usage() {
  cat << EOS
$SCRIPT_NAME はプロジェクト内のシェルスクリプトのコードスタイルチェックをします。

Usage:
    $SCRIPT_NAME <command>

Available commands:
    help                      このヘルプを出力する。
    setup                     リントツールをセットアップする。
    format      [files...]    コードフォーマットにかける。
    format-save [files...]    コードフォーマットして上書き保存する。
    lint        [files...]    リントにかける。
    all                       プロジェクト全体をフォーマットとリントにかける。
EOS
}

## フォーマットにかけるサブコマンド。
cmd_format() {
  # 引数（ファイル）の指定があればそのファイルを解析する
  # なければデフォルト指定（プロジェクト全体）のファイルを解析する
  local files=("${DEFAULT_TARGET_FILES[@]}")
  if [[ 0 -lt $# ]]; then
    files=("$@")
  fi

  # テストするファイルの件数を加算
  test_count=$((test_count + ${#files[@]}))

  # コンテナ内のマウントディレクトリのフルパスに変更
  local fullpath_files=()
  for f in "${files[@]}"; do
    fullpath_files+=("$CONTAINER_DIR_PREFIX/$f")
  done

  run_shfmt "${fullpath_files[@]}"
}

## フォーマットにかける。
run_shfmt() {
  local files=("$@")
  local ret
  "${DC_CMD[@]}" run formatter $overwrite "${files[@]}"
  ret=$?
  if [[ "$ret" -ne 0 ]]; then
    err_count=$((err_count + 1))
  fi
}

## 静的解析にかけるサブコマンド。
cmd_lint() {
  # 引数（ファイル）の指定があればそのファイルを解析する
  # なければデフォルト指定（プロジェクト全体）のファイルを解析する
  local files=("${DEFAULT_TARGET_FILES[@]}")
  if [[ 0 -lt $# ]]; then
    files=("$@")
  fi

  # テストするファイルの件数を加算
  test_count=$((test_count + ${#files[@]}))

  # コンテナ内のマウントディレクトリのフルパスに変更
  local fullpath_files=()
  for f in "${files[@]}"; do
    # unko.puzzleはスキップする
    if [[ "$f" =~ ^.*unko.puzzle$ ]]; then
      continue
    fi
    fullpath_files+=("$CONTAINER_DIR_PREFIX/$f")
  done

  run_shellcheck "${fullpath_files[@]}"
}

## 静的解析にかける。
run_shellcheck() {
  local files=("$@")
  local ret
  "${DC_CMD[@]}" run linter "${files[@]}"
  ret=$?
  if [[ "$ret" -ne 0 ]]; then
    err_count=$((err_count + 1))
  fi
}

## テストの結果を出力する。
print_check_result() {
  echo "--------------------------------------------------------------------------------"
  if [[ "$err_count" -lt 1 ]]; then
    echo -e "[ ${GREEN}PASS${RESET} ] ($test_count/$test_count) all lint were passed."
    return
  else
    echo -e "[ ${RED}FAIL${RESET} ] lint were failed."
    return 1
  fi
}

main ${1+"$@"}
exit $?
