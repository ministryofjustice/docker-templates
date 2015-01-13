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

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/
ONBUILD COPY vendor/bundle /usr/src/app/vendor/bundle
ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app
ONBUILD RUN mkdir /usr/src/app/public/assets

CMD ["bundle", "exec"]
