FROM blitznote/debootstrap-amd64:16.04

# Set correct environment variables.
ENV HOME="/root" DEBIAN_FRONTEND="noninteractive"

###
### Added ruby 2.2
###
RUN apt-get update -qq && apt-get install -y dirmngr && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 914D5813
RUN echo "deb http://ppa.launchpad.net/gds/govuk/ubuntu trusty main" > /etc/apt/sources.list.d/gds-govuk-precise.list
RUN apt-get update -qq

# Ensure the bash is the latest version and clean up
RUN apt-get install --only-upgrade bash && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
