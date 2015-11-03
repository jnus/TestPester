# TestPester
Playing around with Pester

[![Build status](https://ci.appveyor.com/api/projects/status/6tp45tyn27bbmod2?svg=true)](https://ci.appveyor.com/project/sovs/testpester)

    Describing Get-LatestVersionFolders
	    Context Given non version folder exists
	    	[+] Get latest 1 versions, returns none 407ms
	    Context Given a version file exists
	    	[+] Get latest 1 versions, returns none 107ms
	    Context Given 4 minor version folders exists
	    	[+] Get latest 0 versions, returns none 65ms
	    	[+] Get latest version folder, returns latest 24ms
	    	[+] Gets latest 2 version 24ms
	    Context Given 4 major version folders exists
	    	[+] Get latest 0 versions, returns none 59ms
	    	[+] Get latest version folder, returns latest 17ms
	    	[+] Gets latest 2 version 19ms
	    Context Given mix of major and minor version folders exists
	    	[+] Get latest version folder, returns latest 54ms
	    	[+] Gets latest 2 version 18ms
