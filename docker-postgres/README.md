# Postgres

This is a container runnning [PostgreSQL](http://www.postgresql.org/) 9.4.1, based off
of the
[phusion/baseimage](https://registry.hub.docker.com/u/phusion/baseimage/), which itself is based off Ubuntu 14.04 LTS 'Trusty Tahr'.

[WAL-E](https://github.com/wal-e/wal-e) is also installed for continious
archiving of Write Ahead Logs.

## Users

A 'postgres' user is set up on build and takes ownership of the redis
process and the data volume. It has a default password of 'password',
set as an environment variable, and should be overwritten.

## Data Volume

The data volume is mapped to `/var/lib/postgresql/9.4.1/main`.

## Ports

`5432` is exposed for easy linking through [fig](http://www.fig.sh/) or
[Compose](https://docs.docker.com/compose/).

## Configuration

`postgres.conf` and `pg_gba.conf` are located in `files/config/` and can be edited to suit your
needs. They are currently relatively barebones, suitable only for
development. Current configuration gets ~240tps on a VM host with 2GB of
RAM and a dual core processor.

### Logging

Logs are written to `/var/log/postgresql` and `/var/log/supervisor`

### Scripts

Some helpful scripts are located in `files/scripts`. They can be
accessed from within the container in `data/scripts`, for use with
`docker exec`..
