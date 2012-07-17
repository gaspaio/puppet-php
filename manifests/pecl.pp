# TODO REWRITE THIS USING A CUSTOM TYPE+PROVIDER
# TODO PUT XDEBUG IN ITS OWN FILE
# TODO RESTART APACHE WHEN A PHP EXTENSION IS INSTALLED (XDEBUG)

class php::pecl(
  $xdebug_remotehost
) inherits php::params {

  package { 'libpcre3-dev':
    ensure => present,
  }

  package { 'make':
    ensure => present,
  }

  package { 'php-dev':
    name => $php::params::php_dev_package_name,
    ensure => present,
  }

# Install xdebug via PECL
  exec { 'pecl_xdebug':
    command => "pecl install xdebug",
    unless => "pecl list | grep -i 'xdebug'",
    require => [
      Package['pear', 'php-dev', 'make'],
      Exec['pear_upgrade']
    ],
  }

# Install more recent APC version from PECL
  exec { "pecl_apc":
    command => "pecl install apc",
    unless => "pecl list | grep -i apc",
    require => [
      Package['pear','php-dev','libpcre3-dev', 'make'],
      Exec['pear_upgrade']
    ],
  }

  file { $php::params::apc_ini:
    ensure => present,
    owner => 'root',
    group => 'root',
    source => "puppet:///modules/php/apc.ini",
    require => Exec['pecl_apc'],
  }

  file { $php::params::xdebug_ini:
    ensure => present,
    content => template("php/xdebug.ini.erb"),
    owner => 'root',
    group => 'root',
    require => Exec['pecl_xdebug'],
  }

  file { "apc_php":
    path => "/var/www/apc.php",
    ensure => present,
    source => "puppet:///modules/php/apc.php",
    require => [Package['php'], Exec['pecl_apc']],
  }
}
