#!/usr/bin/env bash

function malloc() {
  if [[ $# -eq 0 || $1 -eq '-h' || $1 -lt 0 ]] ; then
    echo -e "usage: malloc N\n\nAllocate N mb, wait, then release it."
  else
    N=$(free -m | grep Mem: | awk '{print int($2/10)}')
    if [[ $N -gt $1 ]] ;then
      N=$1
    fi
    sh -c "MEMBLOB=\$(dd if=/dev/urandom bs=1MB count=$N) ; sleep 1"
  fi
}