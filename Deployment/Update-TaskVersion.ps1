param (
	[string] $filePath,
	[string] $major,
	[string] $minor,
	[string] $patch
)

# Get the task.json as a PowerShell object.
$task = Get-Content -Raw -Path $filePath | ConvertFrom-Json

$task.version.Major = $major
$task.version.Minor = $minor
$task.version.Patch = $patch

# Write changes back to file.
ConvertTo-Json $task -Depth 999 | Set-Content -Path $filePath