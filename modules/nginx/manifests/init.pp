class nginx ($server_name = 'myapp') {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { 'nginx':
    ensure => installed,
    require => Exec['apt-get update']
  }

  file { "/etc/nginx/sites-available/${server_name}":
    ensure => file,
    source => 'file:///vagrant/files/nginx-myapp.conf',
    owner => 'root',
    group => 'root',
  }

  file { "/etc/nginx/sites-enabled/${server_name}":
    ensure => 'link',
    target => "/etc/nginx/sites-available/${server_name}",
    require => File["/etc/nginx/sites-available/${server_name}"],
    notify => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => 'absent',
    require => File["/etc/nginx/sites-available/${server_name}"],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    require => [
      Package['nginx'],
      File["/etc/nginx/sites-enabled/${server_name}"],
      File['/etc/nginx/sites-enabled/default']
    ],
  }
}
