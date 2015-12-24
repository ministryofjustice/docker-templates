# Use last baseimage from ubuntu-12.04
FROM moj-base:latest

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

###
### Added ruby 2.2
###
RUN echo "deb [arch=amd64] http://repo.dsd.io trusty main" > /etc/apt/sources.list.d/dsd.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6929455C
RUN apt-get update

RUN apt-get install -y --no-install-recommends dsd-ruby2.2-bundler libyaml-0-2 libxslt1.1 libpq5

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

