[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation

try {
    [string]$remoteName = Get-VstsInput -Name RemoteName

    if(!$remoteName)
    {
        throw ("RemoteName parameter must be set.")
    }

    # Get the original remote URL from the context variable.
    $originalRemoteUrl = Get-VstsTaskVariable -Name "IOZ.GitTools.OriginalRemote.$remoteName"

    if ([string]::IsNullOrEmpty($originalRemoteUrl) -eq $true)
    {
        throw ("Could not find original URL of the remote '$remoteName'. Make sure you have called 'Enable Git Remote Access' Task for the remote '$remoteName' before the 'Restore Git Remote' task.")
    }

    Invoke-VstsTool -FileName "git" -Arguments "remote set-url $remoteName $originalRemoteUrl" -RequireExitCodeZero
    Write-Verbose "Updated remote for $remoteName is $originalRemoteUrl"
} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}