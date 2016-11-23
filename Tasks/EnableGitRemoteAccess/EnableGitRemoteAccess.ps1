[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation

try {
    [string]$remoteName = Get-VstsInput -Name RemoteName

    if (!$remoteName)
    {
        throw ("RemoteName parameter must be set.")
    }

    # Determine current remote.
    $remoteArg = "remote.$remoteName.url"
    $currentRemoteUrl = Invoke-VstsTool -FileName "git" -Arguments "config $remoteArg" -RequireExitCodeZero
    Write-Verbose "Current remote for $remoteName is set to $currentRemoteUrl"

    if ([string]::IsNullOrEmpty($currentRemoteUrl) -eq $true)
    {
        throw ("Could not determine remote of the Git repository.")
    }

    # Set the current remote URL as context variable so that it can be restored in a later task.
    Set-VstsTaskVariable -Name "IOZ.GitTools.OriginalRemote.$remoteName" -Value $currentRemoteUrl

    if (!($Env:SYSTEM_ACCESSTOKEN))
    {
        throw ("OAuth token not found. Make sure to have 'Allow Scripts to Access OAuth Token' enabled in the build definition.")
    }

    # Update URL of remote.
    $newRemoteUrlBuilder = New-Object System.UriBuilder ($currentRemoteUrl)
    $newRemoteUrlBuilder.UserName = "OAuth"
    $newRemoteUrlBuilder.Password = $Env:SYSTEM_ACCESSTOKEN
    Invoke-VstsTool -FileName "git" -Arguments "remote set-url $remoteName $newRemoteUrlBuilder" -RequireExitCodeZero

    Write-Verbose "Updated remote for $remoteName is $newRemoteUrlBuilder"
} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}