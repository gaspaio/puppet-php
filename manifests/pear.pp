# TODO REWRITE THIS USING A CUSTOM TYPE+PROVIDER
class php::pear inherits php::params {


  package { 'pear':
    name => $php::params::pear_package_name,
    ensure => present,
    require => Package['php'],
  }

# upgrades PEAR, installs basic PHP tools
  exec { "pear_upgrade":
    command => "$::php_pear_exec upgrade",
    require => Package['pear'],
  }

  exec { "pear_auto_discover":
    command => "$::php_pear_exec config-set auto_discover 1",
    require => [Package['pear'], Exec['pear_upgrade']],
  }
}
