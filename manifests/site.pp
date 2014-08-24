Exec { path => [ "/bin", "/sbin" , "/usr/bin", "/usr/sbin" ] }

node nodeserver, /us-west-2/{

	include roles::uptime

# 	$database_name = "testhree"

#   class {'::mongodb::globals':
#     manage_package_repo     => true,
#   }
#   ->
#   class {'::mongodb::server':
#     # auth => true,
#   }
#   ->
#   class {'::mongodb::client': }
#   ->
#   mongodb::db { "${database_name}":
#     user            => "adminuser",
#     password        => "adminpass",
#   }

#   mongodb_user { "user3":
#   ensure        => present,
#   password_hash => "password", #mongodb_password('user3', 'password'),
#   database      => "${database_name}",
#   roles         => ['readWrite', 'dbAdmin'],
#   tries         => 10,
#   require       => Class['mongodb::server'],
# }


}

