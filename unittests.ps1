$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\Get-LatestVersionFolders.ps1"

Describe "Get-LatestVersionFolders" {
    Context "Given non version folder exists" {
        New-Item "TestDrive:\nonVersionFolder" -Type Directory

        It "Get latest 1 versions, returns none" {
            Get-LatestVersionFolders "TestDrive:\" 1 | Should BeNullOrEmpty
        }
    }

    Context "Given a version file exists" {
        New-Item "TestDrive:\1.0.0" -Type File

        It "Get latest 1 versions, returns none" {
            Get-LatestVersionFolders "TestDrive:\" 1 | Should BeNullOrEmpty
        }
    }

    Context "Given 4 minor version folders exists" {
        New-Item "TestDrive:\1.0.0" -Type Directory
        New-Item "TestDrive:\1.1.0" -Type Directory
        New-Item "TestDrive:\1.2.0" -Type Directory
        New-Item "TestDrive:\1.3.0" -Type Directory

        It "Get latest 0 versions, returns none" {
            Get-LatestVersionFolders "TestDrive:\" 0 | Should BeNullOrEmpty
        }

        It "Get latest version folder, returns latest" {
            Get-LatestVersionFolders "TestDrive:\" 1 | Should Be '1.3.0'
        }

        It "Gets latest 2 version" {
            $Result = Get-LatestVersionFolders "TestDrive:\" 2

            $Result[0] | Should Be '1.2.0'
            $Result[1] | Should Be '1.3.0'
        }
    }

    Context "Given 4 major version folders exists" {
        New-Item "TestDrive:\1.0.0" -Type Directory
        New-Item "TestDrive:\2.0.0" -Type Directory
        New-Item "TestDrive:\3.0.0" -Type Directory
        New-Item "TestDrive:\4.0.0" -Type Directory

        It "Get latest 0 versions, returns none" {
            Get-LatestVersionFolders "TestDrive:\" 0 | Should BeNullOrEmpty
        }

        It "Get latest version folder, returns latest" {
            Get-LatestVersionFolders "TestDrive:\" 1 | Should Be '4.0.0'
        }

        It "Gets latest 2 version" {
            $Result = Get-LatestVersionFolders "TestDrive:\" 2

            $Result[0] | Should Be '3.0.0'
            $Result[1] | Should Be '4.0.0'
        }
    }

    Context "Given mix of major and minor version folders exists" {
        New-Item "TestDrive:\1.1.0" -Type Directory
        New-Item "TestDrive:\2.2.0" -Type Directory
        New-Item "TestDrive:\3.0.0" -Type Directory

        It "Get latest version folder, returns latest" {
            Get-LatestVersionFolders "TestDrive:\" 1 | Should Be '3.0.0'
        }

        It "Gets latest 2 version" {
            $Result = Get-LatestVersionFolders "TestDrive:\" 2
            $Result[0] | Should Be '2.2.0'
            $Result[1] | Should Be '3.0.0'
        }
    }
}
