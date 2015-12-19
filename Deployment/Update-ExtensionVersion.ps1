param (
	[string] $filePath,
	[string] $version
)

# Get the vss-extension.json as a PowerShell object.
$extension = Get-Content -Raw -Path $filePath | ConvertFrom-Json

$extension.version = $version

# Write changes back to file.
ConvertTo-Json $extension -Depth 999 | Set-Content -Path $filePath