class phpmyadmin {
  require phpmyadmin::php
  require phpmyadmin::httpd

  file { '/tmp/phpMyAdmin-4.3.6-all-languages.zip':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/tmp/phpMyAdmin-4.3.6-all-languages.zip'
  }

  exec { 'unzip phpMyAdmin-4.3.6-all-languages.zip':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/phpMyAdmin-4.3.6-all-languages.zip']
  }

  exec { 'rsync -avz phpMyAdmin-4.3.6-all-languages/ /var/www':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => Exec['unzip phpMyAdmin-4.3.6-all-languages.zip']
  }
}
