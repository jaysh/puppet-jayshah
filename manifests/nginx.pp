# Class: jayshah::nginx
#
# Install and configure nginx from the nginx.org repository.
#
class jayshah::nginx {
  # The repository requires the operatoring system in lowercase
  # for it to work properly (e.g. "CentOS" -> "centos").
  $os_downcase = downcase($::operatingsystem)

  # Setup the yum repository for nginx.
  yumrepo { 'nginx':
    baseurl  => "http://nginx.org/packages/$os_downcase/$::operatingsystemmajrelease/$::architecture/",
    descr    => 'nginx repository',
    enabled  => 1,
    gpgcheck => 0,
  }

  # Basic nginx installation.
  class { '::nginx':
    require => Yumrepo['nginx'],
  }

  # Configure our fastcgi.conf in nginx for php-fpm.
  file { "$::nginx::params::confdir/fastcgi.conf":
    source  => 'puppet:///modules/jayshah/nginx/fastcgi.conf',
    require => Package[$::nginx::params::package],
    notify  => Service[$::nginx::params::service],
  }

  # Deploy the php.conf.inc provided by ::nginx.
  ::nginx::file { 'php.conf.inc':
    source => 'puppet:///modules/nginx/php.conf.inc',
  }
}
