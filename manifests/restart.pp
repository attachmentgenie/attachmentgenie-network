class network::restart {
  exec { 'network-restart':
      command     => '/etc/init.d/networking restart',
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      refreshonly => true,
  }
}

