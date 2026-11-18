# ==============================================================================
# Script Name: pc-02.ps1
# Description: Connects to PC-02 to monitor the active RDP session (view-only).
#              Delegates to Invoke-RDPMonitor.ps1.
# ==============================================================================
& "$PSScriptRoot\Invoke-RDPMonitor.ps1" -Target "PC-02"
