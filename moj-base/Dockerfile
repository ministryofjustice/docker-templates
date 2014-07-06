# Use last baseimage from ubuntu-12.04
FROM phusion/baseimage:0.9.9

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

###
### Added ruby 2.0
###
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 914D5813 
RUN echo "deb http://ppa.launchpad.net/gds/govuk/ubuntu precise main" > /etc/apt/sources.list.d/gds-govuk-precise.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6
RUN echo "deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu precise main" > /etc/apt/sources.list.d/brightbox.list
RUN apt-get update

RUN apt-get install -y --no-install-recommends ruby2.0 ruby2.0-dev nodejs libxslt1.1 libpq5
RUN apt-get install -y --force-yes statsd

RUN update-alternatives --install /usr/bin/gem gem /usr/bin/gem2.0 171
RUN update-alternatives \
 --install /usr/bin/ruby ruby /usr/bin/ruby2.0 41 \
 --slave /usr/bin/erb erb /usr/bin/erb2.0 \
 --slave /usr/bin/testrb testrb /usr/bin/testrb2.0 \
 --slave /usr/bin/rake rake /usr/bin/rake2.0 \
 --slave /usr/bin/irb irb /usr/bin/irb2.0 \
 --slave /usr/bin/rdoc rdoc /usr/bin/rdoc2.0 \
 --slave /usr/bin/ri ri /usr/bin/ri2.0 \
 --slave /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby2.0.1.gz \
 --slave /usr/share/man/man1/erb.1.gz erb.1.gz /usr/share/man/man1/erb2.0.1.gz \
 --slave /usr/share/man/man1/irb.1.gz irb.1.gz /usr/share/man/man1/irb2.0.1.gz \
 --slave /usr/share/man/man1/rake.1.gz rake.1.gz /usr/share/man/man1/rake2.0.1.gz \
 --slave /usr/share/man/man1/ri.1.gz ri.1.gz /usr/share/man/man1/ri2.0.1.gz
RUN gem2.0 install rake bundler --no-rdoc --no-ri


###
### Add logstash-forwarder
###

# install deps
RUN apt-get install -y wget git golang ruby ruby-dev rubygems irb ri rdoc build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

# clone logstash-forwarder
# Build deb
ADD logstash-forwarder_0.3.1_amd64.deb /tmp/logstash-forwarder_0.3.1_amd64.deb
RUN dpkg -i /tmp/logstash-forwarder_0.3.1_amd64.deb
ADD certs /etc/certs

# Cleanup
RUN rm -rf /tmp/*

# ...put your own build instructions here...
# install service files for runit
ADD logstash.service /etc/service/logstash/run
ADD statsd.service /etc/service/statsd/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
