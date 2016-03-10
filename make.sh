#!/bin/bash

set -e

# Get all the images from the command line if they exist otherwise default
if [ -z $1 ]; then
    IMAGES=(light moj-base moj-nginx moj-ruby ruby socat-ssh)
    echo No images passed on command line, defaulting to... "${IMAGES[@]}"
else
    IMAGES=($@)
    echo Getting image list from command line... "${IMAGES[@]}"
fi

CWD=`pwd`

for img in ${IMAGES[@]}; do
	cd $CWD/$img
    if [ ${img} == "ruby" ]; then
        DOCKER_TEMPLATES_REGISTRY=${DOCKER_TEMPLATES_REGISTRY} sh make.sh
    else
        echo Building ${img} docker image...
        tag=latest
	    docker build -t ${img}:${tag} .

        if [ ! -z ${DOCKER_TEMPLATES_REGISTRY} ]; then
            docker tag ${img}:${tag} ${DOCKER_TEMPLATES_REGISTRY}/${img}:${tag}
            echo Pushing ${DOCKER_TEMPLATES_REGISTRY}/${img}:${tag} to registry...
            docker push ${DOCKER_TEMPLATES_REGISTRY}/${img}:${tag}
        else
            echo No DOCKER_TEMPLATES_REGISTRY set, skipping registry push...
        fi
    fi
done
