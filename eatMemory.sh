#!/usr/bin/env bash

function malloc() {
  if [[ $# -eq 0 || $1 -eq '-h' || $1 -lt 0 ]] ; then
    echo -e "usage: malloc N\n\nAllocate N mb, wait, then release it."
  else
    N=$(free -m | grep Mem: | awk '{print int($2/10)}')
    if [[ $N -gt $1 ]] ;then
      N=$1
    fi
    sh -c "MEMBLOB=\$(dd if=/dev/zero bs=1MB count=$N) ; sleep 1"
  fi
}

#malloc 6000
MEMBLOB=$(dd if=/dev/zero bs=1MB count=6000)
free -h
docker run --name oom-check-node  --cpu-shares 128 --memory 256m --memory-swap 256m --network bridge -e __OW_API_HOST=https://172.17.0.1:443  --cap-drop NET_RAW --cap-drop NET_ADMIN --ulimit nofile=1024:1024 --pids-limit 1024 -v "$PWD":/usr/src/app -w /usr/src/app openwhisk/nodejs6action node memoryWithGC.js