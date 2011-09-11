Puppet Network Module
=====================

Module for configuring network interfaces.

Tested on Debian GNU/Linux 6.0 Squeeze and Ubuntu 10.4 LTS with
Puppet 2.6. Patches for other operating systems are welcome.


TODO
----

* Actual implementation


Installation
------------

Clone this repo to a network directory under your Puppet modules directory:

    git clone git://github.com/uggedal/puppet-module-network.git network

If you don't have a Puppet Master you can create a manifest file
based on the notes below and run Puppet in stand-alone mode
providing the module directory you cloned this repo to:

    puppet apply --modulepath=modules test_network.pp


Usage
-----

By including the `network::interfaces` class you get a basic configuration
with a loopback interface and the `eth0` interface configured with DHCP:

    import network::interfaces

You can enable the `eth0` interface configured with DHCP:

    class { "network::interfaces":
      interfaces => {
        "eth0" => {
          "type" => "dhcp",
        }
      },
      auto => ["eth0"],
    }

Or you can enable the `eth0` interface with a static configuration:

    class { "network::interfaces":
      interfaces => {
        "eth0" => {
          "type" => "static",
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
          "type" => "static",
          "address" => "10.0.0.50",
          "netmask" => "255.255.255.0",
          "gateway" => "10.0.0.1",
        }
        "eth0:1" => {
          "type" => "static",
          "address" => "10.0.0.60",
          "netmask" => "255.255.255.0",
        }
      },
      auto => ["eth0", "eth0:1"],
    }

You can create pseudo interfaces useful for handling different wireless
networks:


    class { "network::interfaces":
      interfaces => {
        "work" => {
          "wpa-ssid" => "work-wlan",
          "wpa-psk" => "supersecretkey",
        }
        "open" => {
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
