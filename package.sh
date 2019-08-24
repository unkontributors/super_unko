#!/bin/bash
set -ue
THIS_DIR=$(
  cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd
)
readonly THIS_DIR
{
  cd "${THIS_DIR}"
  tar zcvf super_unko.tar.gz bin lib .tar2package.yml
  docker run -i greymd/tar2rpm < super_unko.tar.gz > pkg/super_unko.rpm.tmp
  mv pkg/super_unko.rpm{.tmp,}
  docker run -i greymd/tar2deb < super_unko.tar.gz > pkg/super_unko.deb.tmp
  mv pkg/super_unko.deb{.tmp,}
  rm super_unko.tar.gz
}
