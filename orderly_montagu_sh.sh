#!/bin/sh
set -ex
if [ "$#" -eq 0 ]; then
    CMD=bash
else
    CMD=$1
    shift
fi

docker exec -it montagu_orderly_1 $CMD $*
