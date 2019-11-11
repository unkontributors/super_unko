#!/bin/bash

coverage() {
  # kcovのインストールされている環境でのみ実行
  if type kcov 2> /dev/null; then
    local options=(--bash-dont-parse-binary-dir)
    kcov "${options[@]}" coverage "$@" || true
  fi
}
