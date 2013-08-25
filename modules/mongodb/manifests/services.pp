class mongodb::services{
  
  require mongodb::packages

  service { "mongod":
      enable => true,
      ensure => running,
  }
}