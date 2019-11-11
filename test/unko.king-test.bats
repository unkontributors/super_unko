#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="$(pwd)/../bin/unko.king"
readonly BASH_REQUIRE_VERSION=4.0

@test "-h でヘルプを出力する" {
  run "$TARGET_COMMAND" -h
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ ^unko.king.* ]]
  coverage "$TARGET_COMMAND" -h
}

@test "--help でヘルプを出力する" {
  run "$TARGET_COMMAND" --help
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ ^unko.king.* ]]
  coverage "$TARGET_COMMAND" --help
}

@test "-v でバージョンを出力する" {
  run "$TARGET_COMMAND" -v
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ ^v ]]
  coverage "$TARGET_COMMAND" -v
}

@test "--version でバージョンを出力する" {
  run "$TARGET_COMMAND" --version
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ ^v ]]
  coverage "$TARGET_COMMAND" --version
}

@test "引数未指定の時はデフォルト5になる" {
  run "$TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　　👑" ]
  [ "${lines[1]}" = "　　　　（💩💩💩）" ]
  [ "${lines[2]}" = "　　　（💩👁💩👁💩）" ]
  [ "${lines[3]}" = "　　（💩💩💩👃💩💩💩）" ]
  [ "${lines[4]}" = "　（💩💩💩💩👄💩💩💩💩）" ]
  coverage "$TARGET_COMMAND"
}

@test "引数 5" {
  run "$TARGET_COMMAND" 5
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　　👑" ]
  [ "${lines[1]}" = "　　　　（💩💩💩）" ]
  [ "${lines[2]}" = "　　　（💩👁💩👁💩）" ]
  [ "${lines[3]}" = "　　（💩💩💩👃💩💩💩）" ]
  [ "${lines[4]}" = "　（💩💩💩💩👄💩💩💩💩）" ]
  coverage "$TARGET_COMMAND" 5
}

@test "引数 5 未満はNG" {
  for i in -1 0 1 2 3 4; do
    run "$TARGET_COMMAND" $i
    [ "$status" -ne 0 ]
    coverage "$TARGET_COMMAND" $i
  done
}

@test "引数 6" {
  run "$TARGET_COMMAND" 6
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "　　　　　　　👑" ]
  [ "${lines[1]}" = "　　　　　（💩💩💩）" ]
  [ "${lines[2]}" = "　　　　（💩👁💩👁💩）" ]
  [ "${lines[3]}" = "　　　（💩💩💩👃💩💩💩）" ]
  [ "${lines[4]}" = "　　（💩💩💩💩👄💩💩💩💩）" ]
  [ "${lines[5]}" = "　（💩💩💩💩💩💩💩💩💩💩💩）" ]
  coverage "$TARGET_COMMAND" 6
}

@test "オプション以外の第1引数は数値のみ受け付ける" {
  for i in a whoami '$(whoami)' あ 漢字 "" - "*" / "?" '_[$(whoami >&2)]'; do
    run "$TARGET_COMMAND" "$i"
    [ "$status" -ne 0 ]
    [[ "$output" =~ ^.*ERR.*Invalid.*number.*$ ]]
    coverage "$TARGET_COMMAND" "$i"
  done
}

@test "第1引数に段数、第2引数が不正なケース" {
  for i in a whoami '$(whoami)' あ 漢字 "" - "*" / "?" '_[$(whoami >&2)]'; do
    run "$TARGET_COMMAND" 8 "$i"
    [ "$status" -ne 0 ]
    [[ "$output" =~ ^.*ERR.*Invalid.*sub.*command.*$ ]]
    coverage "$TARGET_COMMAND" 8 "$i"
  done
}

#==============================================================================
# NOTE:
#   以降のテストではecho-sdを使用する。
#   echo-sdはBash4.0以下では動かないため、Bash4.1以上のみテストする。
#==============================================================================

bash_version=$(bash --version | grep -Eo "[0-9]+\.[0-9]+" | head -n 1)
if [ $(echo "$BASH_REQUIRE_VERSION < $bash_version" | bc) -eq 0 ]; then
  echo "  Bash${BASH_REQUIRE_VERSION}以下はスキップ"
  exit 0
fi

@test "第1引数にはshoutを受け付ける。デフォルトの段数は5" {
  run "$TARGET_COMMAND" shout こんにちは
  [ "$status" -eq 0 ]
  [[ "${lines[1]}" =~ ^.*こんにちは.*$ ]]
  [ "${lines[3]}" = "　　　　　　👑" ]
  [ "${lines[4]}" = "　　　　（💩💩💩）" ]
  [ "${lines[5]}" = "　　　（💩👁💩👁💩）" ]
  [ "${lines[6]}" = "　　（💩💩💩👃💩💩💩）" ]
  [ "${lines[7]}" = "　（💩💩💩💩👄💩💩💩💩）" ]
  coverage "$TARGET_COMMAND" shout こんにちは
}

@test "第1引数に段数、第2引数にshout" {
  run "$TARGET_COMMAND" 8 shout こんばんは
  [ "$status" -eq 0 ]
  [[ "${lines[1]}" =~ ^.*こんばんは.*$ ]]
  coverage "$TARGET_COMMAND" 8 shout こんばんは
}

@test "shoutの第3引数以降はオプション" {
  run bash -c "echo うんこ | $TARGET_COMMAND 7 shout -s"
  [ "$status" -eq 0 ]
  [[ "${lines[1]}" =~ ^.*うんこ.*$ ]]
  coverage bash -c "echo うんこ | $TARGET_COMMAND 7 shout -s"
}
