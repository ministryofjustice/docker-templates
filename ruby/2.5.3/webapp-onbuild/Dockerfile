FROM ministryofjustice/ruby:2.5.3

# add official nodejs repo
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
        echo 'deb https://deb.nodesource.com/node jessie main' > /etc/apt/sources.list.d/nodesource.list

# install runit and nodejs
RUN apt-get update && apt-get install -y runit nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

# SSH proxy settings
ENV SSH_AUTH_SOCK /tmp/ssh-auth
ENV SSH_AUTH_PROXY_PORT 1234

RUN mkdir -p /usr/src/app
RUN bundle config --global without test:development
WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/

# Hack to install private gems
ONBUILD RUN socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork TCP4:$(ip route|awk '/default/ {print $3}'):$SSH_AUTH_PROXY_PORT & bundle install

ONBUILD COPY . /usr/src/app
ONBUILD RUN mkdir -p /usr/src/app/public/assets

CMD ["bundle", "exec"]
