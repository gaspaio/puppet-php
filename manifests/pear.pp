# TODO REWRITE THIS USING A CUSTOM TYPE+PROVIDER
class php::pear inherits php::params {

  package { 'pear':
    name => $php::params::pear_package_name,
    ensure => present,
    require => Class['php'],
  }

  # upgrades PEAR, installs basic PHP tools
  exec { "pear_upgrade":
    command => "pear upgrade",
    require => Package['pear'],
  }

  exec { "pear_auto_discover":
    command => "pear config-set auto_discover 1",
    require => [Package['pear'], Exec['pear_upgrade']],
  }

  exec { "pear_phpqatools":
    command => "pear install --alldeps pear.phpqatools.org/phpqatools",
    unless => "pear list -a | grep phpqatools",
    require => Exec["pear_auto_discover"]
  }

  exec { "pear_phing_install":
      command => "pear install --alldeps pear.phing.info/phing",
      unless => "pear list -a | grep phing",
      require => Exec["pear_auto_discover"]
    }
}
