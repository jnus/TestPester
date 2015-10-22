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

    if ($testResults.FailedCount -gt 0)
    {
        throw 'One or more unit tests failed to pass.  Build aborting.'
    }
}

RunUnitTests $here\unittests.ps1
