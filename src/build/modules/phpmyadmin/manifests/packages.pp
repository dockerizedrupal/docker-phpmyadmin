class phpmyadmin::packages {
  exec { 'apt-get update':
    path => ['/usr/bin']
  }

  package {[
      'apache2',
      'php5',
      'php5-mysql',
    ]:
    ensure => present,
    require => Exec['apt-get update']
  }
}