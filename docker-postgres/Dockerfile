FROM phusion/baseimage:0.9.16
MAINTAINER Matt Blewitt <blewitt.matt+docker@gmail.com>

WORKDIR /root

# Usual stuff
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y wget

# Set timezone + locale
RUN echo "en_GB.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && dpkg-reconfigure -f noninteractive locales && \
    echo "LANG=en_GB.UTF-8" > /etc/default/locale && \
    echo "Europe/London" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

# Setup postgres user
RUN groupadd -r postgres&& useradd -r -g postgres postgres

# Set installation variables
ENV PG_MAJOR 9.4
ENV PG_VERSION 9.4.1-1.pgdg14.04+1
ENV USERNAME postgres
ENV PASSWORD password

# Add pgdg apt source and repo key
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Install postgres, python, v8 (for WAL-E)
RUN apt-get update && apt-get install -y \
    postgresql-$PG_MAJOR=$PG_VERSION \
    postgresql-contrib-$PG_MAJOR=$PG_VERSION \
    postgresql-server-dev-$PG_MAJOR \
    postgresql-plpython-$PG_MAJOR \
    postgresql-$PG_MAJOR-plv8 \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libssl-dev \
    libffi-dev \
    python-dev \
    python-pip \
    daemontools \
    libevent-dev \
    lzop \
    pv && \
    pip install virtualenv && \
    pip install cryptography

# Install WAL-E into a virtualenv
RUN virtualenv /var/lib/postgresql/wal-e &&\
    . /var/lib/postgresql/wal-e/bin/activate &&\
    pip install wal-e &&\
    ln -s /var/lib/postgresql/wal-e/bin/wal-e /usr/local/bin/wal-e

# Create directory for storing WAL-E env vars
RUN umask u=rwx,g=rx,o= &&\
    mkdir -p /etc/wal-e.d/env &&\
    chown -R root:postgres /etc/wal-e.d

# Cleanup
RUN apt-get remove --purge -y wget &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy some configs & scripts
RUN mkdir -m 755 -p /etc/service/postgres

COPY files/config/pg_hba.conf     /etc/postgresql/$PG_MAJOR/main/
COPY files/config/postgresql.conf /etc/postgresql/$PG_MAJOR/main/
COPY files/scripts                /data/scripts
COPY files/runit/postgres         /etc/service/postgres/run
COPY files/runit/cron             /etc/service/cron/run

# Fix ownership
RUN chown -R postgres:postgres /etc/postgresql/$PG_MAJOR/main && \
    chmod -R 755 /data/scripts && \
    chmod 755 /etc/service/cron/run /etc/service/postgres/run

# Setup
USER postgres

RUN /etc/init.d/postgresql start &&\
  psql --command "ALTER USER postgres WITH PASSWORD '$PASSWORD';" &&\
  /etc/init.d/postgresql stop

USER root

# Enable volume for persistence
VOLUME ["/var/log/postgresql", \
        "/var/log/supervisor", \
        "/etc/postgresql/$PG_MAJOR/main", \
        "/var/lib/postgresql/$PG_MAJOR/main"]

# Expose and init
EXPOSE 5432

CMD ["/data/scripts/postgres.sh"]
