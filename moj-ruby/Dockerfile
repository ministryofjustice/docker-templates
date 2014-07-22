# Use last baseimage from ubuntu-12.04
FROM moj-base:latest

RUN apt-get update

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

###
### Install ruby 2.0
###
RUN apt-get install -y --force-yes --no-install-recommends dsd-ruby2.1-bundler libyaml-0-2 libxslt1.1 libpq5

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
