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
  include nginx

  file { '/etc/init.d/myapp':
    source => 'file:///vagrant/files/myapp',
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  package { 'python-pip':
    ensure => installed,
    require => Exec['apt-get update']
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
