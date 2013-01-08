task :default do
  sh "puppet-lint manifests/ubuntu.pp"
  sh "puppet apply --noop manifests/ubuntu.pp   "
end