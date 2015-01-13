FROM ruby:2.1.5

RUN apt-get update && apt-get install -y runit apt-transport-https && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

RUN mkdir $HOME/.ssh && touch /root/.ssh/known_hosts && ssh-keyscan github.com >> /root/.ssh/known_hosts

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
# Don't use any gems installed into the system. This makes the gem tree standalone
RUN bundle config --global disable_shared_gems 1

# Add app user
ENV WEBUSER web
RUN adduser $WEBUSER --home /usr/src/app --shell /bin/bash --disabled-password --gecos ""

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# SSH auth socket to proxy private traffic
ENV SSH_AUTH_SOCK /tmp/ssh-auth
# SSH proxy port
ENV SSH_AUTH_PROXY_PORT 1234

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install --jobs 4 --retry 3

ONBUILD COPY . /usr/src/app
ONBUILD RUN mkdir /usr/src/app/public/assets

CMD ["bundle", "exec"]
