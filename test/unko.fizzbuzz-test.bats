#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="$(pwd)/../bin/unko.fizzbuzz"
readonly BASH_REQUIRE_VERSION=4.0

#==============================================================================
# NOTE:
#   echo-sdはBash4.0以下では動かないため、Bash4.1以上のみテストする
#==============================================================================

bash_version=$(bash --version | grep -Eo "[0-9]+\.[0-9]+" | head -n 1)
if [ $(echo "$BASH_REQUIRE_VERSION < $bash_version" | bc) -eq 0 ]; then
  echo "  Bash${BASH_REQUIRE_VERSION}以下はスキップ"
  exit 0
fi

@test "引数がない時はヘルプを出力する" {
  run "$TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ .*unko.fizzbuzz:* ]]
  coverage "$TARGET_COMMAND"
}

@test "引数が正の整数でない時はヘルプを出力する" {
  for i in -1 1.1 a whoami '$(whoami)' あ 漢字 "" - "*" / "?" '_[$(whoami >&2)]'; do
    run "$TARGET_COMMAND" "$i"
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" =~ .*unko.fizzbuzz:* ]]
    coverage "$TARGET_COMMAND" "$i"
  done
}

@test "引数が0のときは何も出力しない" {
  run "$TARGET_COMMAND" 0
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == "" ]]
  coverage "$TARGET_COMMAND" 0
}

@test "引数が3のときは3まで出力する" {
  run "$TARGET_COMMAND" 3
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == 1 ]]
  [[ "${lines[1]}" == 2 ]]
  [[ "${lines[2]}" =~ .*fizz$ ]]
  [[ "${lines[3]}" == "" ]]
  coverage "$TARGET_COMMAND" 3
}

@test "引数が16のときは16まで出力する" {
  run "$TARGET_COMMAND" 16
  [ "$status" -eq 0 ]
  [[ "${lines[1]}" == 2 ]]
  [[ "${lines[2]}" =~ .*fizz$ ]]
  [[ "${lines[3]}" == 4 ]]
  [[ "${lines[4]}" =~ .*buzz$ ]]
  [[ "${lines[5]}" =~ .*fizz$ ]]
  [[ "${lines[14]}" =~ .*人人.* ]]
  [[ "${lines[15]}" =~ .*fizzbuzz.* ]]
  coverage "$TARGET_COMMAND" 16
}
