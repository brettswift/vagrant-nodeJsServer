# http://www.websequencediagrams.com/?lz=UHVwcGV0IFZpcnR1YWwgVHlwZXMgdy8gSGllcmEKCnNpdGUucHAgLT4gY2xhc3NEZWZpbml0aW9uOiBoaWVyYSgAEgU6OnYAOwYAIAUsICBkZWZhdWx0cywgACEGADgGIGFycmF5KQoAPA8ASRVjcmVhdGVfcmVzb3VyY2VzKABbBy50eXBlLACBCAZPYmplY3QocykgaGFzaCwAbQkAPCZyZWFsaXplIChDAIE-BQCBfAdbAIFSBV8AgSUFXSkKIgCBUg4iIC0-IAAEEDpkAIINCQ&s=modern-blue


class nodesite (
    $gitUri 			= {},
    $nodeVersion 	= {},
    $fileToRun 		= {},
){

	# include nodejs

	include nodesite::packages
	include nodesite::project

	class { 'nvm_nodejs':
  	user    => 'vagrant',
  	version => $nodeVersion,
	}

	info("##### node path: $nvm_nodejs::NODE_PATH")


	class {'nodesite::project':
			gitUri 			=> $gitUri,
			fileToRun 	=> $fileToRun,
	}
	
  
  Class['nodesite::packages'] ->
  Class['nodesite::npm'] ->
  Class['nvm_nodejs'] -> 
  Class['nodesite::project']

}