task :default do
  sh "puppet parser validate manifests/*.pp"
  sh "puppet-lint manifests/*.pp"

end