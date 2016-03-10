#!/bin/bash

set -e

BASE_TAG="ministryofjustice"

if [ -z $1 ]; then
    RUBY_TAGS=(2.1 2.2 2.3.0)
    echo No images passed on command line, defaulting to... "${RUBY_TAGS[@]}"
else
    RUBY_TAGS=($@)
    echo Getting image list from command line... "${RUBY_TAGS[@]}"
fi
CWD=`pwd`

for ruby_tag in ${RUBY_TAGS[@]}; do
	cd $CWD/$ruby_tag
    echo Building ${BASE_TAG}/ruby:${ruby_tag} docker image...
	docker build -q -t ${BASE_TAG}/ruby:${ruby_tag} .
    cd webapp-onbuild
    echo Building ${BASE_TAG}/ruby:${ruby_tag}-webapp-onbuild docker image...
    docker build -q -t ${BASE_TAG}/ruby:${ruby_tag}-webapp-onbuild .
    if [ ! -z ${DOCKER_REGISTRY} ]; then
        docker tag -q ${BASE_TAG}/ruby:${ruby_tag} ${DOCKER_REGISTRY}/ruby:$ruby_tag
        docker tag -q ${BASE_TAG}/ruby:${ruby_tag}-webapp-onbuild ${DOCKER_REGISTRY}/ruby:${ruby_tag}-webapp-onbuild
        echo Pushing ${DOCKER_REGISTRY}/ruby:${ruby_tag} to registry...
        docker push -q ${DOCKER_REGISTRY}/ruby:${ruby_tag}
        echo Pushing ${DOCKER_REGISTRY}/ruby:${ruby_tag}-webapp-onbuild to registry...
        docker push -q ${DOCKER_REGISTRY}/ruby:${ruby_tag}-webapp-onbuild
    else
        echo No DOCKER_TEMPLATES_REGISTRY set, skipping registry push...
    fi
done
