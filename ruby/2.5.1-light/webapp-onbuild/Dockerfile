FROM ruby:2.5.1-light

RUN apk update && apk add nodejs socat build-base libxml2-dev libxslt-dev postgresql-dev

RUN mkdir -p /usr/src/app
RUN bundle config --global without test:development
WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/

ONBUILD COPY . /usr/src/app
ONBUILD RUN mkdir -p /usr/src/app/public/assets

# Hack to install private gems
ONBUILD RUN socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork TCP4:$(ip route|awk '/default/ {print $3}'):$SSH_AUTH_PROXY_PORT & bundle install

CMD ["bundle", "exec"]
