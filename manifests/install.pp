# == Class: neo4j::install
#
# Wraps up all the other classes and installs them on the correct OS.
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
#  class { neo4j::install }
#
# === Authors
#
# Author Name <julian.simpson@neotechnology.com>
#
# === Copyright
#
# Copyright 2012 Neo Technology Inc.
#
class neo4j::install {
  case $::operatingsystem {
    /^(Debian|Ubuntu)$/:{ include ubuntu  }
    default:            { fail('Sorry, we do not support your OS yet.\
      You can raise a GitHUb issue on neo4j-contrib/neo4j-puppet if you like')}
  }
}