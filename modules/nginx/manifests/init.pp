class nginx {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { 'nginx':
    ensure => installed,
    require => Exec['apt-get update']
  }

  file { 'myapp.conf nginx file':
    path => '/etc/nginx/sites-available/myapp',
    source => 'file:///vagrant/files/nginx-myapp.conf',
    owner => 'root',
    group => 'root',
  }

  file { '/etc/nginx/sites-enabled/myapp':
    ensure => 'link',
    target => '/etc/nginx/sites-available/myapp',
    require => File['myapp.conf nginx file'],
    notify => Service['nginx'],
  }

  file { 'remove default site':
    path => '/etc/nginx/sites-enabled/default',
    ensure => 'absent',
    require => File['myapp.conf nginx file'],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    require => [
      Package['nginx'],
      File['/etc/nginx/sites-enabled/myapp'],
      File['remove default site']
    ],
  }
}
