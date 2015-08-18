node default {
  exec { "say hello":
    command => "/bin/echo hello"
  }

  host { 'web.example.com':
    ip => '192.168.100.2',
  }

  host { 'db.example.com':
    ip => '192.168.100.3',
  }
}

node 'web.example.com' {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { 'nginx':
    ensure => installed,
    require => Exec['apt-get update']
  }

  service { 'nginx':
    ensure => running,
    require => [
      Package['nginx'],
      File['/etc/nginx/sites-enabled/myapp'],
      File['remove default site']
    ],
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
  }

  file { 'remove default site':
    path => '/etc/nginx/sites-enabled/default',
    ensure => 'absent',
  }
}

node 'db.example.com' {
  include '::mysql::server'
}
