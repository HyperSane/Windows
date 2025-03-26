# ⚠️ Safety Not Guaranteed⚠️
# Deletes a ghost file that you can't normally delete, that gets stuck.
param (
    [string]$TargetPath
)

# If not passed as an argument, fallback to first command-line argument
if (-not $TargetPath -and $args.Count -gt 0) {
    $TargetPath = $args[0]
}

# Ensure something was passed
if (-not $TargetPath) {
    Write-Host "❌ No target path provided. Use 'SendTo' or 'Open with'." -ForegroundColor Red
    exit 1
}

# Normalize path with \\?\ prefix to bypass weird path limitations
$literalPath = "\\?\$TargetPath"

if (Test-Path -LiteralPath $literalPath) {
    try {
        Remove-Item -LiteralPath $literalPath -Recurse -Force -ErrorAction Stop
        Write-Host "✅ Successfully deleted:`n$TargetPath" -ForegroundColor Green
    } catch {
        Write-Host "❌ Error deleting:`n$TargetPath`nError: $_" -ForegroundColor Red
    }
} else {
    Write-Host "⚠️ Path does not exist:`n$TargetPath" -ForegroundColor Yellow
}
