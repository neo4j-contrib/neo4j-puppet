task :default do
  sh "puppet parser validate manifests/*.pp"
  sh "puppet-lint manifests/*.pp"
end

task :template do
  sh "s3cmd put --acl-public templates/neo4j-server.properties.erb s3://cf-templates.neo4j.org"
end
