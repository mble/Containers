# Solr

This is a container runnning [Solr](https://lucene.apache.org/solr/) 4.2.1, based off
of the
[java:8](https://registry.hub.docker.com/_/java/) image, which itself is based off Debian unstable, 'sid'.

## Users

A 'solr' user is set up on build and takes ownership of the solr
process and the data directories.

## Data Volume

No data volume is mapped. TODO.

## Ports

`8080` is exposed for easy linking through [fig](http://www.fig.sh/) or
[Compose](https://docs.docker.com/compose/).

## Configuration

`solrconfig.xml` is located in `files/` and can be edited to suit your
needs. It is currently relatively barebones, suitable only for
development.

### Logging

Logging is currently setup to be warnings only, and can be found in `/etc/solr/log/solr.log`.

### Schema

`schema.xml` has been written to primarily for
[Sunspot](https://sunspot.github.io/) useage, but is suitable for other
applications too. It can e found in `files/`.
