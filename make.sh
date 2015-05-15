#!/bin/sh
# set -x
CWD=`pwd`

if [ "$1" ]; then
    REGISTRY="$1"
    echo Setting local registry ${REGISTRY} for pushing...
    # See if we can find the registry
    echo Looking for registry ${REGISTRY}...
    response_v1=$(curl --insecure --write-out %{http_code} --silent --output /dev/null https://${REGISTRY}/v1/)
    response_v2=$(curl --insecure --write-out %{http_code} --silent --output /dev/null https://${REGISTRY}/v2/)
    if [ "${response_v1}" == "200" ] || [ "${response_v2}" == "200" ]; then
        echo Contacted registry ${REGISTRY}, using this for pushing images
    else
        echo Could not contact registry ${REGISTRY}, exiting
        exit 1
    fi
fi

for img in moj-base moj-nginx moj-ruby moj-peoplefinder light; do
	cd $CWD/$img
    echo Building local image ${img}
	docker build -t ${img} .
    if [ "${response_v1}" == "200" ] || [ "${response_v2}" == "200" ]; then
        remote_name=${REGISTRY}/$img
	    docker tag ${img} ${remote_name}
        echo Uploading ${remote_name} to ${REGISTRY}
        docker push ${remote_name}
    else
        echo No remote registry specified...skipping push
    fi
done

exit 0
