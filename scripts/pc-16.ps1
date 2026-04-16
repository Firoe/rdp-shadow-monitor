# ==============================================================================
# Script Name: pc-16.ps1
# Description: Connects to a remote machine to monitor the active RDP session (view-only).
#              Requires the qwinsta utility and mstsc.exe.
# ==============================================================================
$Target = "PC-16"
$sessionId = $null

$lines = qwinsta /server:$Target 2>$null

foreach ($line in $lines) {
    if ($line -match "^\s*\S+\s+\S+\s+(\d+)\s+Active") {
        $sessionId = $matches[1]
        break
    }
}

if (-not $sessionId) {
    [System.Windows.Forms.MessageBox]::Show("No active session found on $Target.","Shadow Monitor")
    exit
}

Start-Process "$env:SystemRoot\System32\mstsc.exe" -ArgumentList "/shadow:$sessionId /v:$Target /noconsentprompt"
