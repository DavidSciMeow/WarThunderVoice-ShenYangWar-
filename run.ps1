# Set the source file name
$sourceFile = "null.wav"

# Get the current directory
$currentDir = Get-Location

# Check if the source file exists
if (-not (Test-Path "$currentDir\$sourceFile")) {
    Write-Host "Source file $sourceFile does not exist! Please make sure it is in the current folder." -ForegroundColor Red
    exit
}

# Loop through all files in the current folder and subfolders
Get-ChildItem -Recurse -File | ForEach-Object {
    # Skip the source file itself and any .ps1 files
    if ($_.FullName -ne (Join-Path $currentDir $sourceFile) -and $_.Extension -ne ".ps1") {
        Write-Host "Replacing file content: " $_.FullName -ForegroundColor Yellow
        Copy-Item -Path "$currentDir\$sourceFile" -Destination $_.FullName -Force
    }
}

Write-Host "Replacement completed!" -ForegroundColor Green