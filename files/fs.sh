#!/bin/sh
mkfs.ext3 /dev/xvdj -F
mkdir /backup
chmod 0755 /backup
#mount /dev/xvdj /backup
#mkdir /backup/neo4j
#chown neo4j /backup/neo4j
