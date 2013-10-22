class jayshah::bind {
  class { '::bind': chroot => true }

  bind::server::conf { '/etc/named.conf':
    listen_on_addr    => [ 'any' ],
    listen_on_v6_addr => [ 'any' ],
    recursion         => no,
    allow_query       => [ 'any' ],
    zones             => {
      'jay.sh.' => [
        'type master',
        'file "jay.sh"',
      ],
    }
  }

  bind::server::file { 'jay.sh':
    source => 'puppet:///modules/jayshah/bind/jay.sh',
  }

  # Helpful utilities for a DNS-server capable system.
  package { 'bind-utils':
    ensure => installed,
  }

  package { 'telnet':
    ensure => installed,
  }
}
