class network::restart {
  exec { 'network-restart':
      command     => 'ifdown --exclude=lo -a ; ifup --exclude=lo -a',
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      refreshonly => true,
  }
}

