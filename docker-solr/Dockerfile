FROM java:8
MAINTAINER Matt Blewitt <blewitt.matt@gmail.com>

# Set non-interactive mode
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Grab some extra packages
RUN apt-get update &&\
    apt-get install -y \
            build-essential \
            locales &&\
    apt-get clean

# Set timezone + locale
RUN echo "en_GB.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && dpkg-reconfigure -f noninteractive locales && \
    echo "LANG=en_GB.UTF-8" > /etc/default/locale && \
    echo "Europe/London" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

# Set solr version
ENV SOLR_VERSION 4.2.1

# Get solr and install
RUN wget -O solr.tar.gz http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz &&\
    tar -C /opt --extract --file solr.tar.gz &&\
    rm -rf solr.tar.gz &&\
    ln -s /opt/solr-$SOLR_VERSION /opt/solr &&\
    adduser --system --no-create-home solr

# Setup directory structure for 'main' core
RUN mkdir -p /etc/solr/log &&\
    mkdir -p /etc/solr/tmp &&\
    mkdir -p /etc/solr/main/conf &&\
    mkdir -p /etc/solr/main/data

# Add config files
ADD files/ /etc/solr/main/conf/

# Move some stuff around, take ownership of init script and home dir
RUN mv /etc/solr/main/conf/solr.xml /etc/solr &&\
    mv /etc/solr/main/conf/run.sh /etc/solr &&\
    mv /etc/solr/main/conf/logging.properties /opt/solr/example &&\
    chown -R solr /etc/solr && chmod -R 755 /etc/solr &&\
    chmod u+x /etc/solr/run.sh

# Start from directory
RUN chown -R solr /opt/solr/example
WORKDIR /opt/solr/example
USER solr

# Expose jetty port
EXPOSE 8080

# Execute init script
CMD /etc/solr/run.sh
