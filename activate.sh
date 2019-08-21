#!/bin/bash

if ! type super_unko > /dev/null 2>&1; then
  THIS_DIR=$(
    cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd
  )
  export PATH="$PATH:$THIS_DIR/bin"
  # shellcheck source=/dev/null
  source "$THIS_DIR/lib/super_unko/unko_command_not_found_hundle"
fi
