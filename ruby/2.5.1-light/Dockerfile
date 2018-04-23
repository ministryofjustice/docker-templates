FROM ruby:2.5.1-alpine3.7

RUN apk update && apk add bash git
RUN bundle config --global frozen 1 && bundle config --global disable_shared_gems 1
ENV APPUSER moj
RUN adduser $APPUSER -h /usr/src/app -s /bin/bash -D -g ""
