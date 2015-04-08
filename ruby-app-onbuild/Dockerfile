FROM ministryofjustice/ruby:2

# SSH proxy settings
ENV SSH_AUTH_SOCK /tmp/ssh-auth
ENV SSH_AUTH_PROXY_PORT 1234

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/

# Hack to install private gems
ONBUILD RUN socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork TCP4:$(ip route|awk '/default/ {print $3}'):$SSH_AUTH_PROXY_PORT & bundle install

ONBUILD COPY . /usr/src/app

CMD ["bundle", "exec"]
