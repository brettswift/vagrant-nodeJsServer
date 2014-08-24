class profiles::mongo_database (
    $db_name          = undef,
    $db_user          = undef,
    $db_password      = undef,
){


  class {'::mongodb::globals':
    manage_package_repo     => true,
  }
  ->
  class {'::mongodb::server':
    # auth => true,
  }
  ->
  class {'::mongodb::client': }
  ->
  mongodb::db { "${db_name}":
    user            => "${db_user}",
    password_hash => "${db_password}",
    roles         => ['readWrite','dbOwner'],
  }
  
} 
