class phpmyadmin {
  if ! file_exists('/phpmyadmin/ssl/certs/vhost.crt') {
    require phpmyadmin::httpd::ssl
  }

  if $db_host {
    file { '/phpmyadmin/data/config.inc.php':
      ensure  => present,
      content => template('phpmyadmin/config.inc.php.erb')
    }
  }
}
