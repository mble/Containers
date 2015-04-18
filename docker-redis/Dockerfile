FROM phusion/baseimage:0.9.16
MAINTAINER Matt Blewitt <blewitt.matt@gmail.com>

WORKDIR /root

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Set timezone + locale
RUN echo "en_GB.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && dpkg-reconfigure -f noninteractive locales && \
    echo "LANG=en_GB.UTF-8" > /etc/default/locale && \
    echo "Europe/London" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

# Setup redis user
RUN groupadd -r redis && useradd -r -g redis redis

# Set installation variables
ENV REDIS_VERSION 2.8.19
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-2.8.19.tar.gz
ENV REDIS_DOWNLOAD_SHA1 3e362f4770ac2fdbdce58a5aa951c1967e0facc8

# Some prep
RUN mkdir -p /var/redis /etc/redis/ /var/run/redis /var/log/redis &&\
    chown -R redis /var/redis /etc/redis/ /var/run/redis /var/log/redis
ADD files/ /etc/redis/redis.conf

# Install redis
RUN buildDeps='gcc libc6-dev make' &&\
    set -x &&\
    apt-get update && apt-get install -y $buildDeps --no-install-recommends &&\
    rm -rf /var/lib/apt-get/lists/* &&\
    mkdir -p /usr/src/redis &&\
    curl -sSL "$REDIS_DOWNLOAD_URL" -o redis.tar.gz &&\
    echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - &&\
    tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 &&\
    rm redis.tar.gz &&\
    make -C /usr/src/redis &&\
    make -C /usr/src/redis install &&\
    rm -r /usr/src/redis &&\
    apt-get purge -y --auto-remove $buildDeps

# Take ownership, setup volume for persistence
RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

# Expose and start
EXPOSE 6379
CMD [ "redis-server", "/etc/redis/redis.conf" ]
