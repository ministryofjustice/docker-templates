# MoJ Docker Templates

This repo contains Dockerfiles for basing project specific docker images from.

## Building the docker images

`./make.sh` in the top level directory will build all the images contained in
this repo


# Using images on other hosts

If you want to use these images on another host the easiest way to do it is to
run a registry and then use the registry tagged form of the `FROM` line:


```
FROM docker.local:5000/moj-base

# ...
```

## Setting up a docker registry

Taken from https://github.com/dotcloud/docker-registry

```
docker run \
         -e SEARCH_BACKEND=sqlalchemy \
         -p 5000:5000 \
         --detach \
         registry
```

Then add an alias of `docker.local` pointing to 127.0.0.1

```
echo "127.0.0.1 docker.local" | sudo tee -a /etc/hosts
```

## Pushing images

To push an image to a custom registry you have to tag it with `url/name`, i.e. for the moj-base image, we need to retag it

* First find out the image id:

    ```
    $ docker images
    REPOSITORY                                   TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    moj-base                                     latest              40f553624b6d        About an hour ago   508.1 MB
    registry                                     latest              6e526128fd5b        4 weeks ago         553.1 MB
    phusion/baseimage                            0.9.9               745d3ac92697        3 months ago        345.8 MB
    ```

* Then tag it with the registry prefix:

    ```
    $ docker tag moj-base docker.local:5000/moj-base
    ```

* And finally push it up to the registry:


    ```
    $ docker push docker.local:5000/moj-base
    The push refers to a repository [docker.local:5000/moj-base] (len: 1)
    Sending image list
    Pushing repository docker.local:5000/moj-base (1 tags)
    Image 511136ea3c5a already pushed, skipping
    (...)
    Image 964d2994056f already pushed, skipping
    0334c0cadc94: Image successfully pushed
    4dfac303cd8a: Image successfully pushed
    40f553624b6d: Image successfully pushed
    Pushing tag for rev [40f553624b6d] on {http://docker.local:5000/v1/repositories/moj-base/tags/latest}
    ```
