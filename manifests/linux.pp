# == Class: neo4j::linux
#
# Make required changes to the Linux configuration in accordance with the Neo4j manual.
# Thanks to Neo4j contributor Hendy Irawan (https://github.com/ceefour) for this class!
#
# === Parameters
#
# None.
#
# === Variables
# None.
#
# === Examples
#
#  class { neo4j::linux }
#
# === Authors
#
# Author Name <julian.simpson@neotechnology.com>
#
# === Copyright
#
# Copyright 2012 Neo Technology Inc.
#
class neo4j::linux {
  exec {
    'neo4j_security_limits':
      command   => '/bin/sed -i -e \'$a neo4j    soft    nofile    40000\' -e \'$a neo4j    hard    nofile    40000\' /etc/security/limits.conf',
      logoutput => true,
      unless    => '/bin/grep "neo4j" /etc/security/limits.conf';

    'neo4j_pam_limits':
      command   => '/bin/sed -i -e \'s/# session    required   pam_limits.so/session    required   pam_limits.so/\' /etc/pam.d/su',
      logoutput => true,
      onlyif    => '/bin/grep "# session    required   pam_limits.so" /etc/pam.d/su';
    }

}