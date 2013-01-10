#!/bin/bash
die(){
  echo $1
  exit 1
}

uid=`id -u`
[ $uid -eq 0 ] || die "Usage: sudo $0"

apt-get update -qq
apt-get install unzip puppet -y
wget -O neo4j-puppet.zip https://github.com/neo4j-contrib/neo4j-puppet/archive/master.zip
unzip -o neo4j-puppet.zip
mv neo4j-puppet-master neo4j
puppet apply neo4j/tests/init.pp --modulepath .