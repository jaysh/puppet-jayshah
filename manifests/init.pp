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
    password => '$1$ILRyJM7Z$Mh1w9F9UIdSbeeThs/8i11', # changeme
  }

  include jayshah::sshd
  include jayshah::php_fpm
  include jayshah::bind

  # Only deploy nginx after httpd has been removed.
  class { 'jayshah::nginx':
    require => Package['remove_httpd'],
  }

  # Configure my server block.
  nginx::file { 'jay.sh.conf':
    source => 'puppet:///modules/jayshah/nginx/jay.sh.conf',
  }

  # Setup the document root to serve the website
  file { '/var/www':
    ensure => directory,
  }

  file { '/var/www/jay.sh':
    ensure  => directory,
    source  => 'puppet:///modules/jayshah/nginx/docroot',
    recurse => true,
    require => File['/var/www'],
    notify  => Exec['clear_cache'],
  }

  exec { 'clear_cache':
    command => '/bin/rm -rf /tmp/nginx-website-cache',
    refreshonly => true,
  }
}
