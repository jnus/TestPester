$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\Get-LatestVersions.ps1"

Describe "Get-LastVersions" {
    Context "Given non version folder exists" {
        New-Item "TestDrive:\nonVersionFolder" -Type Directory

        It "Get latest 1 versions, returns none" {
            Get-LastVersions "TestDrive:\" 1 | Should BeNullOrEmpty
        }
    }

    Context "Given a version file exists" {
        New-Item "TestDrive:\2015.0.0" -Type File

        It "Get latest 1 versions, returns none" {
            Get-LastVersions "TestDrive:\" 1 | Should BeNullOrEmpty
        }
    }

    Context "Given 4 minor version folders exists" {
        New-Item "TestDrive:\2015.1.0" -Type Directory
        New-Item "TestDrive:\2015.2.0" -Type Directory
        New-Item "TestDrive:\2015.3.0" -Type Directory
        New-Item "TestDrive:\2015.5.0" -Type Directory

        It "Get latest 0 versions, returns none" {
            Get-LastVersions "TestDrive:\" 0 | Should BeNullOrEmpty
        }

        It "Get latest version folder, returns latest" {
            Get-LastVersions "TestDrive:\" 1 | Should Be '2015.5.0'
        }

        It "Gets latest 2 version" {
            $Result = Get-LastVersions "TestDrive:\" 2

            $Result[0] | Should Be '2015.3.0'
            $Result[1] | Should Be '2015.5.0'
        }
    }

    Context "Given 4 major version folders exists" {
        New-Item "TestDrive:\2015.0.0" -Type Directory
        New-Item "TestDrive:\2016.0.0" -Type Directory
        New-Item "TestDrive:\2018.0.0" -Type Directory
        New-Item "TestDrive:\2019.0.0" -Type Directory

        It "Get latest 0 versions, returns none" {
            Get-LastVersions "TestDrive:\" 0 | Should BeNullOrEmpty
        }

        It "Get latest version folder, returns latest" {
            Get-LastVersions "TestDrive:\" 1 | Should Be '2019.0.0'
        }

        It "Gets latest 2 version" {
            $Result = Get-LastVersions "TestDrive:\" 2

            $Result[0] | Should Be '2018.0.0'
            $Result[1] | Should Be '2019.0.0'
        }
    }

    Context "Given mix of major and minor version folders exists" {
        New-Item "TestDrive:\2015.1.0" -Type Directory
        New-Item "TestDrive:\2015.2.0" -Type Directory
        New-Item "TestDrive:\2016.0.0" -Type Directory

        It "Get latest version folder, returns latest" {
            Get-LastVersions "TestDrive:\" 1 | Should Be '2016.0.0'
        }

        It "Gets latest 2 version" {
            $Result = Get-LastVersions "TestDrive:\" 2
            $Result[0] | Should Be '2015.2.0'
            $Result[1] | Should Be '2016.0.0'
        }
    }
}
