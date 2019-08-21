#!/bin/bash
set -ue
THIS_DIR=$(
  cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd
)
readonly THIS_DIR
{
  cd "${THIS_DIR}"
  tar zcvf super_unko.tar.gz -C "$THIS_DIR" bin lib .tar2package.yml &&
    docker run -i greymd/tar2rpm < super_unko.tar.gz > pkg/super_unko.rpm &&
    docker run -i greymd/tar2deb < super_unko.tar.gz > pkg/super_unko.deb &&
    rm super_unko.tar.gz
}
