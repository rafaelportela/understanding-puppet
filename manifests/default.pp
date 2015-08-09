exec { "say hello":
 command => "/bin/echo hello"
}

host { 'web.example.com':
  ip => '192.168.100.2'
}

host { 'db.example.com':
  ip => '192.168.100.3'
}
