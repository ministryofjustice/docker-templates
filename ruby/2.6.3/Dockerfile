FROM ruby:2.6.3

# install socat to proxy SSH traffic for private repos
RUN apt-get update && apt-get install -y socat apt-transport-https && apt-get clean && \
    rm -rf /var/lib/apt/lists/* && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

RUN gem install bundler
# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
# Don't use any gems installed into the system. This makes the gem tree standalone
RUN bundle config --global disable_shared_gems 1

# Add Githubs public keys into known_hosts
RUN mkdir $HOME/.ssh && touch /root/.ssh/known_hosts && ssh-keyscan github.com >> /root/.ssh/known_hosts

# https://github.com/ministryofjustice/docker-templates/issues/37
# UTF 8 issue during bundle install
ENV LC_ALL C.UTF-8

# Add application user
ENV APPUSER moj
RUN adduser $APPUSER --home /usr/src/app --shell /bin/bash --disabled-password --gecos ""
