task :default do
  sh "puppet-lint manifests/*.pp"
  sh "puppet apply --noop manifests/*.pp   "
end