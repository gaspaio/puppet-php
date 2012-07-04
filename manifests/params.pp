class php::params {

  # Purge directories managed by puppet ?
  $purge_dirs = false

  # php.ini default settings
  $memory_limit           = '128M'
  $max_execution_time     = '30'
  $max_input_time         = '60'
  $display_errors         = 'On'
  $display_startup_errors = 'On'
  $error_reporting        = 'E_ALL | E_STRICT'
  $post_max_size          = '64M'
  $upload_max_filesize    = '64M'

  case $::operatingsystem {
    'ubuntu', 'debian': {
      $base_dir = "/etc/php5/"
      $extra_dir = "${base_dir}extra/"
      $conf_dir = "${base_dir}conf.d/"

      $cli_dir = "${base_dir}cli/"
      $cli_ini = "${cli_dir}php.ini"
      $cli_package_name = "php5-cli"
      $tpl_php53cli_ini = "php/php-cli.ini.erb"

      $fpm_dir = "${base_dir}fpm/"
      $fpm_pool_dir = "${fpm_dir}pool.d/"
      $fpm_ini = "${fpm_dir}php.ini"
      $fpm_package_name = "php5-fpm"
      $fpm_conf = "${fpm_dir}php-fpm.conf"
      $fpm_service_name = "php5-fpm"

      $apache_dir = "${base_dir}apache2/"
      $apache_ini = "${apache_dir}php.ini"
      $apache_package_name = "libapache2-mod-php5"

      #FIXME remove service name from this module.
      $apache_name = "apache2"
      $tpl_php53apache_ini = "php/php-apache.ini.erb"
    }
  }
}
