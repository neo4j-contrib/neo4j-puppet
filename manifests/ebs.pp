# responsible for backups onto an EBS volume
class neo4j::ebs {
  if ($::ec2_ami_id) {
    file {
      '/tmp/fs.sh':
        mode   => '0755',
        source =>'puppet:///modules/neo4j/fs.sh';

      '/backup/neo4j':
        ensure  => directory,
        owner   => root,
        require => Mount['/backup'];

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
        ensure  => mounted,
        atboot  => true,
        options => 'nosuid',
        dump    => 0,
        pass    => 2,
        device  => '/dev/xvdj',
        fstype  => ext3,
        require => Exec['/tmp/fs.sh'];
    }
  }

}