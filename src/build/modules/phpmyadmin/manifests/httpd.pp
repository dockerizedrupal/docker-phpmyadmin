class phpmyadmin::httpd {
  require phpmyadmin::httpd::packages
  require phpmyadmin::httpd::supervisor

  exec { 'mkdir -p /phpmyadmin/data':
    path => ['/bin']
  }

  exec { 'usermod -d /phpmyadmin/data www-data':
    path => ['/usr/sbin']
  }

  exec { '/bin/bash -c "a2enmod actions"': }
  exec { '/bin/bash -c "a2enmod fastcgi"': }
  exec { '/bin/bash -c "a2enmod vhost_alias"': }
  exec { '/bin/bash -c "a2enmod rewrite"': }
  exec { '/bin/bash -c "a2enmod ssl"': }

  file { '/etc/apache2/sites-enabled/000-default':
    ensure => absent
  }

  file { '/etc/apache2/sites-available/default':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/etc/apache2/sites-available/default',
    mode => 644
  }

  file { '/etc/apache2/sites-enabled/default':
    ensure => link,
    target => '/etc/apache2/sites-available/default',
    require => File['/etc/apache2/sites-available/default']
  }

  file { '/etc/apache2/sites-available/default-ssl':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/etc/apache2/sites-available/default-ssl',
    mode => 644
  }

  file { '/etc/apache2/sites-enabled/default-ssl':
    ensure => link,
    target => '/etc/apache2/sites-available/default-ssl',
    require => File['/etc/apache2/sites-available/default-ssl']
  }

  file { '/etc/apache2/apache2.conf':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/etc/apache2/apache2.conf',
    mode => 644
  }
}
