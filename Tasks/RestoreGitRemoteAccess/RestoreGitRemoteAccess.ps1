[cmdletbinding()]
param(
    [string]$remoteName
)

Write-Verbose "Entering script RestoreGitRemoteAccess.ps1"
Write-Verbose "Parameter Values"
foreach($key in $PSBoundParameters.Keys)
{
    Write-Verbose ($key + ' = ' + $PSBoundParameters[$key])
}

if(!$remoteName)
{
    throw ("RemoteName parameter must be set.")
}

Write-Verbose "Leaving script RestoreGitRemoteAccess.ps1"