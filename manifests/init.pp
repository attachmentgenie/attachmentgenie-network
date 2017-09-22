# Class to install and configure network.
#
# Use this module to install and configure network.
#
# @example Declaring the class
#   include ::network
#
# @param auto_start List of interfaces to start.
# @param interfaces Set of interfaces to create.
# @param mappings Set of mappings to create.
# @param restart Restart networking service.
class network (
  Array $auto_start=[],
  Hash $interfaces={},
  Hash $mappings={},
  Boolean $restart=true,
) {
  file { 'interfaces config':
    content => template('network/interfaces.erb'),
    path    => '/etc/network/interfaces',
  }

  if $restart {
    exec { 'network restart':
      command     => 'ifdown --exclude=lo -a ; ifup --exclude=lo -a',
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      subscribe   => File['interfaces config'],
      refreshonly => true,
    }
  }
}
