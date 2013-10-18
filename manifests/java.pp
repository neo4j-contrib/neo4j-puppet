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

class neo4j::java {
  if ($::oracle_license_accepted == 'true') {
    notice("Proceeding with the Oracle JVM as you agree to the license agreement")

    exec {
      # this should probably be DRYed
      'apt-get update for OAB dependencies':
        command => '/usr/bin/apt-get update';

      'download OAB':
        command => '/usr/bin/wget https://raw.github.com/flexiondotorg/oab-java6/master/oab-java.sh -O /tmp/oab-java.sh',
        creates => '/tmp/oab-java.sh';

      'install OAB repo':
        command   => '/tmp/oab-java.sh',
        require   => [File['/tmp/oab-java.sh'], Exec['apt-get update for OAB dependencies']],
        logoutput => true,
        timeout   => 1200, # 20 minutes, for slow Internet connections
        before    => Exec['apt-get update'],
        creates   => '/etc/apt/sources.list.d/oab.list';

      'default JVM':
        command => '/usr/sbin/update-alternatives --set java /usr/lib/jvm/java-6-sun/jre/bin/java',
        before  => Package['neo4j'],
        require => Package['sun-java6-jdk'];
    }

    file {
      '/tmp/oab-java.sh':
        mode    => '0755',
        require => Exec['download OAB'];
    }

    package {
      'sun-java6-jdk':
        ensure  => present,
        require => Exec['apt-get update']
    }

  }

}