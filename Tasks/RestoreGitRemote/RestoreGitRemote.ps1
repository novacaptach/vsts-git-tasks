[cmdletbinding()]
param(
    [string]$remoteName
)

Write-Verbose "Entering script RestoreGitRemote.ps1"
Write-Verbose "Parameter Values"
foreach($key in $PSBoundParameters.Keys)
{
    Write-Verbose ($key + ' = ' + $PSBoundParameters[$key])
}

if(!$remoteName)
{
    throw ("RemoteName parameter must be set.")
}

import-module "Microsoft.TeamFoundation.DistributedTask.Task.Common"

# Get the original remote URL from the context variable.
$originalRemoteUrl = Get-TaskVariable -Context $distributedTaskContext -Name IOZ.GitTools.OriginalRemote.$remoteName -Global $FALSE

if ([string]::IsNullOrEmpty($originalRemoteUrl) -eq $true)
{
    throw ("Could not find original URL of the remote '$remoteName'. Make sure you have called 'Enable Git Remote Access' Task for the remote '$remoteName' before the 'Restore Git Remote' task.")
}

git remote set-url $remoteName $originalRemoteUrl
Write-Verbose "Updated remote for $remoteName is $originalRemoteUrl"

Write-Verbose "Leaving script RestoreGitRemote.ps1"