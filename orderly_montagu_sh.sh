#!/bin/sh
set -ex
if [ "$#" -eq 0 ]; then
    CMD=bash
else
    CMD=$1
    shift
fi

docker run --rm \
       -it --entrypoint $CMD \
       -v montagu_orderly_volume:/orderly \
       -w /orderly \
       --network montagu_default \
       docker.montagu.dide.ic.ac.uk:5000/montagu-orderly:master $*
