node default {
  host { 'web01.example.com':
    ip => '192.168.100.2',
  }

  host { 'web02.example.com':
    ip => '192.168.100.3',
  }

  host { 'db.example.com':
    ip => '192.168.100.4',
  }
}

node /^web(01|02).example.com?/ {
  class { 'nginx::server':
    server_name => 'webapp',
    app_root_dir => '/vagrant/myapp',
    app_listening_port => '5000',
    require => Exec['apt-update'],
  }

  file { '/etc/init.d/myapp':
    source => 'file:///vagrant/files/myapp',
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }

  package { 'python-pip':
    ensure => installed,
    require => Exec['apt-update']
  }

  service { 'myapp':
    ensure => running,
    enable => true,
    require => [
      File['/etc/init.d/myapp'],
      Package['python-pip']
    ],
  }
}

node 'db.example.com' {
  class { '::mysql::server':
    root_password => 'root',
    remove_default_accounts => false,
  }

  mysql::db { 'myapp_db':
    user => 'myuser',
    password => 'myuser',
    host => 'localhost',
    grant => ['ALL'],
  }
}
