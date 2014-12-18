FROM phusion/baseimage:0.9.15

# Set correct HOME
ENV HOME /root

# For debconf not to complain
ENV DEBIAN_FRONTEND noninteractive

# Let's add dsd pkg repo
ADD keys/dsd-apt.key /tmp/dsd-apt.key
RUN echo "deb [arch=amd64] http://repo.dsd.io trusty main" > /etc/apt/sources.list.d/dsd.list
RUN apt-key add /tmp/dsd-apt.key
RUN apt-get update

# Ensure that bash is the latest version
RUN apt-get install --only-upgrade bash

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
