# Use last baseimage from ubuntu-14.04
FROM docker.local:5000/moj-base

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

###
### Install dsd-python2
###
# RUN apt-get install -y --force-yes --no-install-recommends dsd-python

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
