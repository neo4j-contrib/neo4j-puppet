class neo4j::install {
  case $operatingsystem {
    /^(Debian|Ubuntu)$/:{ include ubuntu  }
    default:            { fail('Sorry, we do not support your OS yet.\
      You can raise a GitHUb issue on neo4j-contrib/neo4j-puppet if you like') }
  }
}