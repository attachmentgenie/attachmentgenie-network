define network::interface_file(
  $interfaces = {},
  $mappings = {},
  $auto = {},
  $restart = false,
  $file_pattern = '%s',
){
  include network::restart

  $filename = sprintf($file_pattern, $name)
  file { $filename:
    content => template('network/interfaces.erb'),
  }

  if $restart {
    File[$name] ~> Class['network::restart']
  }
}
