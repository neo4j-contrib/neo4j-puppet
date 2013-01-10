Facter.add("oracle_license_accepted") do
  setcode do
    ENV['I_ACCEPT_THE_ORACLE_LICENSE'] ? true : false
  end
end