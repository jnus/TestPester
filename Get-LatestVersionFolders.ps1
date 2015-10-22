function Get-LatestVersionFolders
{
   param([string] $Path,
         [int]$NumberOfVersions)
    $result =  gci $path -Directory | Where-Object {$_.Name -match "^(?:(\d+)\.)?(?:(\d+)\.)?(\*|\d+)$"} | Sort-Object $_.Name | select -last $NumberOfVersions
    return $result

}