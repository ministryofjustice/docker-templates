#!/bin/bash

DOCKER_NOPUSH=true
DOCKER_NORMI=true

DEFAULT_DOCKERREPO="docker.local:5000"
DEFAULT_DOCKERTAG="moj-base-python"

DOCKERFILE="docker/python/Dockerfile"
DOCKERREPO="${DOCKERREPO:-$DEFAULT_DOCKERREPO}"
DOCKERTAG="${DOCKERTAG:-$DEFAULT_DOCKERTAG}"

if [ -n "$1" ]; then
  TAG="${DOCKERREPO}/${DOCKERTAG}:$1"
else
  TAG="${DOCKERREPO}/${DOCKERTAG}"
fi

docker build -t ${TAG} --rm=true .

if [ -z "$DOCKER_NOPUSH" ]; then
  echo "+ docker push ${TAG}"
  docker push ${TAG}
fi

if [ -z "$DOCKER_NORMI" ]; then
  echo "+ docker rmi ${TAG}"
  docker rmi ${TAG}
fi
