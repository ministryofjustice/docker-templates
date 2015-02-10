CWD=`pwd`
#This gets the tag that's currently checked out
TAG=`git name-rev --tags --name-only $(git rev-parse HEAD)|cut -f1 -d '^'`
for img in moj-base moj-nginx moj-ruby moj-peoplefinder light; do
    cd $CWD/$img
    docker build -t $img .
    if [ "$TAG" != "undefined" ]; then
        docker tag $img:latest $img:$TAG
    fi
done
