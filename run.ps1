$here = Split-Path -Parent $MyInvocation.MyCommand.Path

function RunUnitTests
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $Path
    )

    Import-Module $here\Pester.3.3.11\tools\pester.psm1 -ErrorAction Stop

    $testResults = Invoke-Pester -Path $Path -PassThru -OutputFile Test.xml -OutputFormat NUnitXml

    # Upload results to AppVeyor build server. For TeamCity, enable build feature 'XML report processing'
    if($($env:APPVEYOR_JOB_ID)) {
        $wc = New-Object 'System.Net.WebClient'
        $wc.UploadFile("https://ci.appveyor.com/api/testresults/xunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\Test.xml))
    }

    if ($testResults.FailedCount -gt 0)
    {
        throw 'One or more unit tests failed to pass.  Build aborting.'
    }
}

RunUnitTests $here\unittests.ps1
