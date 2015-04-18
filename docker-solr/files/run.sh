#!/bin/bash
/usr/bin/java -Dsolr.solr.home=/etc/solr/ -Djetty.logs=/etc/solr/log/solr.log -Djetty.home=/etc/solr -Djava.io.tmpdir=/etc/solr/tmp -Djava.util.logging.config.file=logging.properties -Djetty.port=8080 -Xms2048m -Xmx2048m -jar /opt/solr/example/start.jar
