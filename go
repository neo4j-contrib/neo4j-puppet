#!/bin/bash

die(){
  echo $1
  exit 1
}

uid=`id -u`
[ $uid -eq 0 ] || die "Usage: sudo $0"

apt-get update -qq
apt-get install unzip puppet -y
wget -q -O neo4j-puppet.zip https://github.com/neo4j-contrib/neo4j-puppet/archive/master.zip
unzip -q -o neo4j-puppet.zip
mv -f neo4j-puppet-master neo4j
echo "********************************************************************************"
echo "***** By using this you agree to the terms of the Oracle License Agreement *****"
echo "********************************************************************************"
export I_ACCEPT_THE_ORACLE_LICENSE=true
puppet apply neo4j/tests/init.pp --modulepath .