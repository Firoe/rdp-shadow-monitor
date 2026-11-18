# ==============================================================================
# Script Name: Invoke-RDPMonitor.ps1
# Description: Shared helper to connect to a remote machine and monitor the
#              active RDP session (view-only). Requires qwinsta and mstsc.exe.
# ==============================================================================
param(
    [Parameter(Mandatory = $true)]
    [string]$Target
)

$lines = qwinsta /server:$Target 2>$null

if (-not $lines) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show(
        "Unable to reach $Target. The computer may be offline or unreachable.",
        "Shadow Monitor"
    )
    exit 1
}

$sessionId = $null
foreach ($line in $lines) {
    if ($line -match "^\s*\S+\s+\S+\s+(\d+)\s+Active") {
        $sessionId = $matches[1]
        break
    }
}

if (-not $sessionId) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show(
        "No active session found on $Target.",
        "Shadow Monitor"
    )
    exit 1
}

Start-Process "$env:SystemRoot\System32\mstsc.exe" -ArgumentList "/shadow:$sessionId /v:$Target /noconsentprompt"
