class nginx::server (
    $server_name = 'myapp',
    $app_root_dir = '/vagrant/',
    $app_listening_port = '8080',
  ) inherits nginx {

  file { "/etc/nginx/sites-available/${server_name}":
    ensure => file,
    content => template('nginx/nginx-server.conf.erb'),
    owner => 'root',
    group => 'root',
    require => Package['nginx'],
  }

  file { "/etc/nginx/sites-enabled/${server_name}":
    ensure => 'link',
    target => "/etc/nginx/sites-available/${server_name}",
    require => File["/etc/nginx/sites-available/${server_name}"],
    notify => Service['nginx'],
  }
}
