FROM ruby:2.4.2

# install socat to proxy SSH traffic for private repos
RUN apt-get update && apt-get install -y socat apt-transport-https && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

# Throw errors if Gemfile has been modified since Gemfile.lock
# Don't use any gems installed into the system. This makes the gem tree standalone
# Install multiple gems in parallel ( 4 in this case ) to speed up image build
# Disable installation & generation of RDOC / RI ( speed up and decrease size )
RUN bundle config --global frozen 1 && bundle config --global disable_shared_gems 1 && bundle config --global jobs 4 && echo "gem: --no-rdoc --no-ri" > /etc/gemrc

# Add Githubs public keys into known_hosts
RUN mkdir $HOME/.ssh && touch /root/.ssh/known_hosts && ssh-keyscan github.com >> /root/.ssh/known_hosts

# https://github.com/ministryofjustice/docker-templates/issues/37
# UTF 8 issue during bundle install
# Add application user
ENV LC_ALL="C.UTF-8" APPUSER="moj"

RUN adduser $APPUSER --home /usr/src/app --shell /bin/bash --disabled-password --gecos ""
