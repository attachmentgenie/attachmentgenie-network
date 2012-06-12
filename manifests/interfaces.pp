class network::interfaces($interfaces={}, $mappings={}, $auto=[]) {

  file { "/etc/network/interfaces":
    content => template("network/interfaces.erb"),
  }

  service {"networking":
  	hasrestart => true,
  	hasstatus => false,
  	subscribe => File["/etc/network/interfaces"],
  }
}
