# Class: jayshah::php_fpm
#
# Install and configure php-fpm using puppet-php so it'll work with nginx.
#
class jayshah::php_fpm {
  include php::fpm::daemon
  php::fpm::conf { 'www':
    listen  => '/var/run/php-fpm-www.sock',
    user    => 'nobody',
  }
}
