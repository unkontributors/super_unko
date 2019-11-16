#!/usr/bin/env bats
source functions.sh

readonly TARGET_COMMAND="../bin/unko.pyramid"

@test 'unko.pyramidは引数なしのときは16段' {
  run "$TARGET_COMMAND"
  [ "$status" -eq 0 ]
  [ "${lines[0]}"  = "               💩               " ]
  [ "${lines[1]}"  = "              💩💩              " ]
  [ "${lines[2]}"  = "             💩  💩             " ]
  [ "${lines[3]}"  = "            💩💩💩💩            " ]
  [ "${lines[4]}"  = "           💩      💩           " ]
  [ "${lines[5]}"  = "          💩💩    💩💩          " ]
  [ "${lines[6]}"  = "         💩  💩  💩  💩         " ]
  [ "${lines[7]}"  = "        💩💩💩💩💩💩💩💩        " ]
  [ "${lines[8]}"  = "       💩              💩       " ]
  [ "${lines[9]}"  = "      💩💩            💩💩      " ]
  [ "${lines[10]}" = "     💩  💩          💩  💩     " ]
  [ "${lines[11]}" = "    💩💩💩💩        💩💩💩💩    " ]
  [ "${lines[12]}" = "   💩      💩      💩      💩   " ]
  [ "${lines[13]}" = "  💩💩    💩💩    💩💩    💩💩  " ]
  [ "${lines[14]}" = " 💩  💩  💩  💩  💩  💩  💩  💩 " ]
  [ "${lines[15]}" = "💩💩💩💩💩💩💩💩💩💩💩💩💩💩💩💩" ]
  coverage "$TARGET_COMMAND"
}

@test 'unko.pyramidの美しさはブラウザのコードレビューでも確認できる' {
  run bash -c "$TARGET_COMMAND 8|tr 💩 🎄|sed '1s/🎄/👑/';yes 💩|head -2|xargs printf '% 11s\n'"
  [ "${lines[0]}"  = "       👑       " ]
  [ "${lines[1]}"  = "      🎄🎄      " ]
  [ "${lines[2]}"  = "     🎄  🎄     " ]
  [ "${lines[3]}"  = "    🎄🎄🎄🎄    " ]
  [ "${lines[4]}"  = "   🎄      🎄   " ]
  [ "${lines[5]}"  = "  🎄🎄    🎄🎄  " ]
  [ "${lines[6]}"  = " 🎄  🎄  🎄  🎄 " ]
  [ "${lines[7]}"  = "🎄🎄🎄🎄🎄🎄🎄🎄" ]
  [ "${lines[8]}"  = "       💩" ]
  [ "${lines[9]}"  = "       💩" ]

}

@test 'unko.pyramidの引数1' {
  run "$TARGET_COMMAND" 1
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "💩" ]
}

@test "オプション以外の第1引数は数値のみ受け付ける" {
  for i in 0 16.5 a $ '_[$(whoami >&2)]' whoami '$(whoami)' あ 漢字 "*" / "?"; do
    run "$TARGET_COMMAND" "$i"
    [ "$status" -ne 0 ]
    [ "$output" = "unko.pyramid: Invalid number '${i}'" ]
  done
}

@test "第1引数に段数、第2引数が不正なケース" {
  for i in 0 16.5 a $ '_[$(whoami >&2)]' whoami '$(whoami)' あ 漢字 "*" / "?"; do
    run "$TARGET_COMMAND" 16 "$i"
    [ "$status" -ne 0 ]
    [ "$output" = "unko.pyramid: Invalid number '${i}'" ]
  done
}

@test "-から始まる不正なオプションはエラー" {
  for i in - -a --; do
    run "$TARGET_COMMAND" "$i"
    [ "$status" -ne 0 ]
    [ "$output" = "unko.pyramid: illegal option '${i}'" ]
  done
}

