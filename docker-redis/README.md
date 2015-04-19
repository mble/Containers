# Redis

This is a container runnning [Redis](http://redis.io/) 2.8.19, based off
of the
[phusion/baseimage](https://registry.hub.docker.com/u/phusion/baseimage/), which itself is based off Ubuntu 14.04 LTS 'Trusty Tahr'.

## Users

A 'redis' user is set up on build and takes ownership of the redis
process and the data volume.

## Data Volume

The data volume is mapped to `/data` and is configured as the location
for the RDB dumps.

## Ports

`6379` is exposed for easy linking through [fig](http://www.fig.sh/) or
[Compose](https://docs.docker.com/compose/).

## Configuration

`redis.conf` is located in `files/` and can be edited to suit your
needs. It is currently relatively barebones, suitable only for
development.
