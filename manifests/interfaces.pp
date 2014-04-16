class network::interfaces(
  $interfaces={},
  $mappings={},
  $auto=[],
  $restart=true,
) {
  network::interface_file { '/etc/network/interfaces':
    interfaces => $interfaces,
    mappings   => $mappings,
    auto       => $auto,
    restart    => $restart,
  }

}
