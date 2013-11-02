# == Class: neo4j::ubuntu
#
# Everything you need to get Neo4j running on Ubuntu.  This first draft is meant to be self-contained for first
# time users, we'll see what we can do to make a module that can be user by the Puppet Forge community.
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
#  class { neo4j::ubuntu }
#
# === Authors
#
# Author Name <julian.simpson@neotechnology.com>
#
# === Copyright
#
# Copyright 2012 Neo Technology Inc.
#
class neo4j::ubuntu {
  include linux
  include java
  include ebs


  exec {
    'apt-get update':
      command => '/usr/bin/apt-get update';

    'neotech signing key':
      command => '/usr/bin/wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -',
      before  => Exec['apt-get update'],
      unless  => '/usr/bin/apt-key list | grep -q neotechnology.com';

    'restart neo4j':
      command     => '/usr/sbin/service neo4j-service restart',
      require     => [Package['neo4j'],
                      Class['neo4j::linux'],
                      File['neo4j config file'],
                      File['neo4j auth extension link'],
                      Exec['bump the minimum heap size'],
                      Exec['bump the maximum heap size'],
      ];

    'bump the minimum heap size':
      command     => '/bin/echo "wrapper.java.initmemory=1024" >> /etc/neo4j/neo4j-wrapper.conf',
      require     => Package['neo4j'],
      unless      => '/bin/grep "^wrapper.java.initmemory" /etc/neo4j/neo4j-wrapper.conf 2>/dev/null';

    'bump the maximum heap size':
      command     => '/bin/echo "wrapper.java.maxmemory=4096" >> /etc/neo4j/neo4j-wrapper.conf',
      require     => Package['neo4j'],
      unless      => '/bin/grep "^wrapper.java.maxmemory" /etc/neo4j/neo4j-wrapper.conf 2>/dev/null';
  }

  file {
    'neo4j contrib dir':
      ensure => directory,
      path   => '/usr/share/neo4j-contrib';

    'neo4j auth extension':
      path    => '/usr/share/neo4j-contrib/authentication-extension-1.8.1-fudge.jar',
      source  => 'puppet:///modules/neo4j/authentication-extension-1.8.1-fudge.jar',
      require => File['neo4j contrib dir'];

    'neo4j auth extension link':
      ensure  => 'link',
      path    =>  '/usr/share/neo4j/plugins/authentication-extension-1.8.1-fudge.jar',
      target  => '/usr/share/neo4j-contrib/authentication-extension-1.8.1-fudge.jar',
      require => File['neo4j auth extension'];

    'neo4j apt config':
      path    => '/etc/apt/sources.list.d/neo4j.list',
      content => 'deb http://debian.neo4j.org/repo stable/',
      before  => Exec['apt-get update'];

    'neo4j config file':
      path     => '/etc/neo4j/neo4j-server.properties',
      content  => template('neo4j/neo4j-server.properties.erb'),
      require  => Package['neo4j'],
      owner    => neo4j,
      group    => adm;
  }

  package {
    'neo4j':
      ensure  => present,
      require => [Exec['apt-get update'], Class['neo4j::java']];
  }

  service {
    'neo4j-service':
      ensure  => running,
      enable  => true,
      require => Exec['restart neo4j'],
      subscribe => File['neo4j config file'];
  }

}