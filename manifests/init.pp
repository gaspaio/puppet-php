class php(
  $cli_display_errors         = $php::params::cli_display_errors,
  $cli_display_startup_errors = $php::params::cli_display_startup_errors,
  $cli_error_reporting        = $php::params::cli_error_reporting,
  $cli_post_max_size          = $php::params::cli_post_max_size,
  $cli_upload_max_filesize    = $php::params::cli_upload_max_filesize,
  $purge_dirs                 = $php::params::purge_dirs
) inherits php::params {

  package { 'php-cli': 
    name   => $php::params::cli_package_name,
    ensure => present,
  }

  file { $php::params::extra_dir:
    owner   => root,
    group   => root,
    purge   => $php::params::purge_dirs,
    recurse => true,
    force   => true,
    require => Package['php-cli'],
    ensure  => directory,
  }

  file { $php::params::conf_dir:
    owner   => root,
    group   => root,
    purge   => $php::params::purge_dirs,
    recurse => true,
    force   => true,
    require => Package['php-cli'],
    ensure  => directory,
  }

  file { $php::params::cli_ini:
    owner   => root,
    group   => root,
    require => Package['php-cli'],
    ensure  => file,
    content => template($php::params::tpl_php53cli_ini), 
  }

  file { $php::params::cli_dir:
    owner   => root,
    group   => root,
    purge   => $php::params::purge_dirs,
    recurse => true,
    force   => true,
    require => Package['php-cli'],
    ensure  => directory,
  }

  file { "${php::params::cli_dir}conf.d":
    ensure => "../conf.d",
    require => Package['php-cli'],
  }
}
