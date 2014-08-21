class profiles::mongodb {

  $db_name = "uptimeVersionChecks"
  $db_user = 'uptimeUser'
  $db_password = 'password'

  class {'mongodb::globals':
    manage_package_repo     => true,
    server_package_name     => "mongodb-org-server",
  }->
  class {'mongodb::server':
    auth => true,
  }->
  mongodb::db { "${db_name}":
    user            => "${db_user}",
    password        => "${db_password}",
    # password_hash => 'a15fbfca5e3a758be80ceaf42458bcd8',
  }
}