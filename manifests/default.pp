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
}
