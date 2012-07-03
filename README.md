[![Build Status](https://secure.travis-ci.org/attachmentgenie/puppet-module-network.png)](http://travis-ci.org/attachmentgenie/puppet-module-network)

Puppet Network Module
=====================

Module for configuring network interfaces.

Tested on Debian GNU/Linux 6.0 Squeeze and Ubuntu 10.4 LTS and 12.04 LTS with
Puppet 2.6 and 2.7. Patches for other operating systems are welcome.

Usage
-----

By including the `network::interfaces` class you get a basic configuration
with only a loopback interface:

    include network::interfaces

You can enable the `eth0` interface configured with DHCP:

    class { "network::interfaces":
      interfaces => {
        "eth0" => {
          "method" => "dhcp",
        }
      },
      auto => ["eth0"],
    }

Or you can enable the `eth0` interface with a static configuration:

    class { "network::interfaces":
      interfaces => {
        "eth0" => {
          "method" => "static",
          "address" => "10.0.0.50",
          "netmask" => "255.255.255.0",
          "gateway" => "10.0.0.1",
        }
      },
      auto => ["eth0"],
    }

It's also possible to create two interfaces on the same ethernet device:

    class { "network::interfaces":
      interfaces => {
        "eth0" => {
          "method" => "static",
          "address" => "10.0.0.50",
          "netmask" => "255.255.255.0",
          "gateway" => "10.0.0.1",
        }
        "eth0:1" => {
          "method" => "static",
          "address" => "10.0.0.60",
          "netmask" => "255.255.255.0",
        }
      },
      auto => ["eth0", "eth0:1"],
    }

You can create pseudo interfaces which are useful for handling different
wireless networks:


    class { "network::interfaces":
      interfaces => {
        "work" => {
          "method" => "dhcp",
          "wpa-ssid" => "work-wlan",
          "wpa-psk" => "supersecretkey",
        }
        "open" => {
          "method" => "dhcp",
          "wireless-essid" => "open-wlan",
        }
      },
      mappings => {
        "wlan0" => {
          "script" => "guessnet-ifupdown",
          "maps" => ["timeout: 5", "work"],
        }
      },
      auto => ["wlan0"],
    }
