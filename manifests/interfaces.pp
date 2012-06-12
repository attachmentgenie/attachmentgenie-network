class network::interfaces($interfaces={}, $mappings={}, $auto=[]) {

  file { "/etc/network/interfaces":
    content => template("network/interfaces.erb"),
    notify  => Service["networking"],
  }

  service {"networking":
	#ensure => running,
	#enable => true,
	hasrestart => true,
	hasstatus => false,
	subscribe => File["/etc/network/interfaces"],
  }
}
