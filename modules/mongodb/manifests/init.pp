class mongodb{
 	
 	 include mongodb::services


 	file { "/etc/yum.repos.d/10gen.repo":
 		ensure 	=> present,
 		source	=> "puppet:///modules/mongodb/10gen.repo",
 	}


  File['/etc/yum.repos.d/10gen.repo'] -> 
  Class['mongodb::packages'] ->
  Class['mongodb::services']

}