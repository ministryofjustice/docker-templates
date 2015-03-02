FROM phusion/baseimage:0.9.12

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

###
### Added ruby 2.0
###
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 914D5813
RUN echo "deb http://ppa.launchpad.net/gds/govuk/ubuntu precise main" > /etc/apt/sources.list.d/gds-govuk-precise.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D88E42B4
RUN apt-get update -qq

# Ensure the bash is the latest version
RUN apt-get install --only-upgrade bash

# Fix broken path to so that 'env node' works again
RUN ln -s /usr/bin/nodejs /usr/bin/node

ADD statsd.service /etc/service/statsd/run
RUN chmod +x /etc/service/statsd/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
