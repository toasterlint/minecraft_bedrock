#!/bin/bash

md5sum -c /data/md5check --quiet
RESULT=$?

if [ $RESULT -ne 0 ]; then
	echo "Extracting server..."
	unzip /opt/bedrock_server.zip -d /data
	md5sum /opt/bedrock_server.zip > /data/md5check
fi

cd /data
LD_LIBRARY_PATH=. ./bedrock_server
