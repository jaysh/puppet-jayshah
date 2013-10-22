class jayshah::sshd {
  service { 'sshd':
    ensure => running,
  }

  file { '/etc/ssh/sshd_config':
    source => 'puppet:///modules/jayshah/sshd/sshd_config',
    notify => Service['sshd'],
  }
}
