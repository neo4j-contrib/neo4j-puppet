Facter.add("oracle_license_accepted") do
  setcode do
    ENV['I_ACCEPT_THE_ORACLE_LICENSE'] ? true : false
  end
end

Facter.add("neo4j_username") do
  setcode do
    ENV['NEO4J_USERNAME'] ||= 'neo4j'
  end
end

Facter.add("neo4j_password") do
  setcode do
    ENV['NEO4J_PASSWORD'] || 'Never.Use.Defaults'
  end
end
