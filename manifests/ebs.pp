# responsible for backups onto an EBS volume
class neo4j::ebs {
  if ($::ec_ami_id) {
    file {
      '/tmp/fs.sh':
        mode   => '0755',
        source =>'puppet:///modules/neo4j/fs.sh';

      '/backup/neo4j':
        owner   => neo4j,
        require => [Mount['backup'], Package['neo4j']];

      '/etc/cron.daily/neo4j_backup':
        owner  => root,
        mode   => '0755',
        source =>'puppet:///modules/neo4j/neo4j_backup';
    }

    exec {
      '/tmp/fs.sh':
        creates => '/backup',
        require => File['/tmp/fs.sh']
    }

    mount {
      '/backup':
        device => '/dev/xvdj',
        fstype => 'ext3';
    }
  }

}