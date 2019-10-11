#!/usr/bin/env bash

swapoff -a
dd if=/dev/zero of=/dev/shm/fill bs=1MB count=3900
MEMBLOB=$(dd if=/dev/zero bs=1MB count=2000)
free -h
docker run --name oom-check-node  --cpu-shares 128 --memory 256m --memory-swap 256m --network bridge -e __OW_API_HOST=https://172.17.0.1:443  --cap-drop NET_RAW --cap-drop NET_ADMIN --ulimit nofile=1024:1024 --pids-limit 1024 -v "$PWD":/usr/src/app -w /usr/src/app openwhisk/nodejs6action node memoryWithGC.js