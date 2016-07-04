[cmdletbinding()]
param(
    [string]$remoteName
)

Write-Verbose "Entering script EnableGitRemoteAccess.ps1"
Write-Verbose "Parameter Values"
foreach($key in $PSBoundParameters.Keys)
{
    Write-Verbose ($key + ' = ' + $PSBoundParameters[$key])
}

if(!$remoteName)
{
    throw ("RemoteName parameter must be set.")
}

# Determine current remote.
$remoteArg = "remote.$remoteName.url"
$currentRemoteUrl = git config $remoteArg
Write-Verbose "Current remote for $remoteName is set to $currentRemoteUrl"

if ([string]::IsNullOrEmpty($currentRemoteUrl) -eq $true)
{
    throw ("Could not determine remote of the Git repository.")
}

# Set the current remote URL as context variable so that it can be restored in a later task.
Write-Host "##vso[task.setvariable variable=IOZ.GitTools.OriginalRemote.$remoteName;]$currentRemoteUrl"

if (!($Env:SYSTEM_ACCESSTOKEN))
{
    throw ("OAuth token not found. Make sure to have 'Allow Scripts to Access OAuth Token' enabled in the build definition.")
}

# Update URL of remote.
$newRemoteUrlBuilder = New-Object System.UriBuilder (git config remote.$remoteName.url)
$newRemoteUrlBuilder.UserName = "OAuth"
$newRemoteUrlBuilder.Password = $Env:SYSTEM_ACCESSTOKEN
git remote set-url origin $newRemoteUrlBuilder

Write-Verbose "Updated remote for $remoteName is $newRemoteUrlBuilder"

Write-Verbose "Leaving script EnableGitRemoteAccess.ps1"
