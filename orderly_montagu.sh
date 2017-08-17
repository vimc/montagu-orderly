#!/bin/sh
docker run --rm \
       -v montagu_orderly_volume:/orderly \
       -w /orderly \
       --network montagu_default \
       docker.montagu.dide.ic.ac.uk:5000/montagu-orderly:master $*
