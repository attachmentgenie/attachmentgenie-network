class network::interfaces($interfaces={}, $mappings={}, $auto=[]) {

  file { "/etc/network/interfaces":
    content => template("network/interfaces.erb"),
  }
}
