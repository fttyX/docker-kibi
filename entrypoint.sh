#!/bin/bash

set -e

if [ -z ${ELASTICSEARCH_URL} ]; then
  ELASTICSEARCH_URL="localhost"
  service elasticsearch start
  tail -f /var/log/elasticsearch/*.log
fi

# Patch demo kibi to use standard ES port
perl -p -i -e "s/9220/9200/" /opt/kibi/config/kibi.yml
perl -p -i -e "s/localhost/$ELASTICSEARCH_URL/" /opt/kibi/config/kibi.yml

# Start Kibi
/opt/kibi/bin/kibi &
