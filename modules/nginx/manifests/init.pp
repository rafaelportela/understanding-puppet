class nginx {
  package { 'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => 'absent',
    notify => Package['nginx'],
  }

  service { 'nginx':
    ensure => running,
    require => File['/etc/nginx/sites-enabled/default'],
  }
}
