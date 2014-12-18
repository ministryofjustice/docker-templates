A lightweight image based on ubuntu 14.04 LTS.
Build on top on phusion/baseimage

Use as your base so that we can orchestrate urgent fixes.

- adds repo.dsd.io
- forces latest bash (sec fix)

When using as base and you need to install pkg, start from
apt-get update
