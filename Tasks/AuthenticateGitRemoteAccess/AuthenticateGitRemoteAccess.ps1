[cmdletbinding()]
param(
    [string]$remoteName
)

Write-Verbose "Entering script AuthenticateGitRemoteAccess.ps1"
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
Write-Verbose "Current remote for origin is set to $currentRemoteUrl"

if ([string]::IsNullOrEmpty($currentRemoteUrl) -eq $true)
{
    throw ("Could not determine remote of the Git repository.")
}

# Set the current remote URL as context variable so that it can be restored in a later task.
Write-Host "##vso[task.setvariable variable=IOZ.GitTools.OriginalRemote;]$currentRemoteUrl"

# Read OAuth token.
$token = $env:SYSTEM_ACCESSTOKEN

if ([string]::IsNullOrEmpty($token) -eq $true)
{
    throw ("OAuth token not found. Make sure to have 'Allow Scripts to Access OAuth Token' enabled in the build definition.")
}

# Update URL of remote.
#$newRemoteUrl = $currentRemoteUrl.replace("https://", "https://" + $token + "@")
$currentRemoteUri = New-Object System.Uri $currentRemoteUrl
$newRemoteUrlBuilder = New-Object System.UriBuilder($currentRemoteUri)
$newRemoteUrlBuilder.UserName = $token
git remote set-url $remoteName $newRemoteUrlBuilder.ToString()
Write-Verbose "Updated remote for origin is $newRemoteUrlBuilder.ToString()"

Write-Verbose "Leaving script AuthenticateGitRemoteAccess.ps1"