#!/usr/bin/env bash
set -x
GIT_ID=$(git rev-parse --short=7 HEAD)
GIT_BRANCH=$(git symbolic-ref --short HEAD)
REGISTRY=docker.montagu.dide.ic.ac.uk:5000
NAME=montagu-orderly

APP_DOCKER_TAG=$REGISTRY/$NAME
APP_DOCKER_COMMIT_TAG=$REGISTRY/$NAME:$GIT_ID
APP_DOCKER_BRANCH_TAG=$REGISTRY/$NAME:$GIT_BRANCH

docker pull $APP_DOCKER_COMMIT_TAG || exit 1

VOLUME_ID=$(docker volume create)

docker run --rm --entrypoint /usr/bin/orderly_init \
       -v "$VOLUME_ID":/orderly \
       "$APP_DOCKER_COMMIT_TAG" \
       "/orderly"

SUCCESS1=$?

docker run --rm --entrypoint cat \
       -v "$VOLUME_ID":/orderly \
       "$APP_DOCKER_COMMIT_TAG" \
       "/orderly/orderly_config.yml"
SUCCESS2=$?

docker volume rm $VOLUME_ID

if [ $SUCCESS1 != 0 ]; then
    exit 1
elif [ $SUCCESS2 != 0 ]; then
     exit 1
else
    exit 0
fi
