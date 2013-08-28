# http://www.websequencediagrams.com/?lz=UHVwcGV0IFZpcnR1YWwgVHlwZXMgdy8gSGllcmEKCnNpdGUucHAgLT4gY2xhc3NEZWZpbml0aW9uOiBoaWVyYSgAEgU6OnYAOwYAIAUsICBkZWZhdWx0cywgACEGADgGIGFycmF5KQoAPA8ASRVjcmVhdGVfcmVzb3VyY2VzKABbBy50eXBlLACBCAZPYmplY3QocykgaGFzaCwAbQkAPCZyZWFsaXplIChDAIE-BQCBfAdbAIFSBV8AgSUFXSkKIgCBUg4iIC0-IAAEEDpkAIINCQ&s=modern-blue

# TODO: move defaults to nodesite.params, and load defaults
class nodesite (
    $gitUri 			= {},
    $gitBranch 		= {},
    $nodeVersion 	= {},
    $fileToRun 		= {},
    $user         = {},
){

	# include nodejs
	 require nvm
	# require nvm::install
	# class{'nvm::install':}

	include nodesite::packages
	# include nodesite::project

	# TODO: use require before class instead of dependencies below? 
	class {'nodesite::project':
			gitUri 			=> $gitUri,
			gitBranch 	=> $gitBranch,
			fileToRun 	=> $fileToRun,
			nodeVersion	=> $nodeVersion,
      user        => $user,
	}
	
  # Class['nvm'] -> 
  Class['nodesite::packages'] ->
  Class['nodesite::project']

}