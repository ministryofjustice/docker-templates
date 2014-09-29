# Use last baseimage from ubuntu-12.04
FROM moj-base:latest

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y nginx

# Ensure the logs can be reached by logstash
RUN chmod 755 /var/log/nginx 

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
