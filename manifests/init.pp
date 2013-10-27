class jayshah {
  # OpenVZ seems to think that base CentOS images should include Apache.
  package { 'remove_httpd':
    ensure => absent,
    name   => 'httpd',
  }

  # I like a simple editor for changing configuration files.
  package { 'nano':
    ensure => present,
  }

  # I like to manage my server as moi.
  class { 'jayshah::sudo_user':
    username => 'jay',
    ssh_key  => 'AAAAB3NzaC1yc2EAAAADAQA..snip..G2pBLF11L',
    password => '$1$ILRyJM7Z$Mh1w9F9UIdSbeeThs/8i11', # changeme
  }

  include jayshah::sshd
  include jayshah::php_fpm
  include jayshah::bind

  # Only deploy nginx after httpd has been removed.
  class { 'jayshah::nginx':
    require => Package['remove_httpd'],
  }
}
