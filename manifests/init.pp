class php(
  $display_errors         = $php::params::display_errors,
  $display_startup_errors = $php::params::display_startup_errors,
  $error_reporting        = $php::params::error_reporting,
  $post_max_size          = $php::params::post_max_size,
  $upload_max_filesize    = $php::params::upload_max_filesize
) inherits php::params {

  package { 'php_cli':
    name   => $php::params::cli_package_name,
    ensure => present,
  }

  file { 'php_cli_dir':
    path    => $php::params::cli_dir,
    owner   => root,
    group   => root,
    purge   => $php::params::purge_dirs,
    recurse => true,
    force   => true,
    require => Package['php_cli'],
    ensure  => directory,
  }

  # Main php config directory
  file { 'php_config_dir':
  	path    => $php::params::conf_dir,
    owner   => root,
    group   => root,
    purge   => $php::params::purge_dirs,
    recurse => true,
    force   => true,
    require => [File['php_cli_dir'], Package['php_cli']],
    ensure  => directory,
  }

  # Symbolic link from the cli config dir to the main config dir
  file { "${php::params::cli_dir}conf.d":
    ensure => "../conf.d",
    require => [File['php_cli_dir'], Package['php_cli']],
  }

  file { 'php_extra_dir':
    path    => $php::params::extra_dir,
    owner   => root,
    group   => root,
    purge   => $php::params::purge_dirs,
    recurse => true,
    force   => true,
    require => [File['php_cli_dir'], Package['php_cli']],
    ensure  => directory,
  }

  file { $php::params::cli_ini:
    owner   => root,
    group   => root,
    require => Package['php_cli'],
    ensure  => file,
    content => template($php::params::tpl_php53cli_ini),
 }


}
