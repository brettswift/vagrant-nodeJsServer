class nodejs::nvm{
  # file { "/tmp/install.sh":
  #   source  => "http://raw.github.com/creationix/nvm/master/install.sh",
  #   mode    => 744,
  #   ensure => file,
  # }

  exec { 'get nvm installer':
    command => "/usr/bin/wget https://raw.github.com/creationix/nvm/master/install.sh",
    creates => '/tmp/install.sh',
    cwd     => "/tmp",
  }

  file { "/tmp/nvm":
    ensure => directory,
  }

  file { '/tmp/nvm/install.sh':
    ensure  => file,
    mode    => '0755',
  }

  exec { 'nvm install':
    command     => "/bin/bash /tmp/install.sh",
    cwd         => "/tmp/nvm",
    refreshonly => true,
  }

  notify { 'done':
    message => 'NodeJS Server Completed'
  }

  Package['curl'] -> 
  Exec['get nvm installer'] -> 
  File['/tmp/nvm'] -> 
  File['/tmp/nvm/install.sh'] -> 
  Exec['nvm install'] -> Notify['done']
}