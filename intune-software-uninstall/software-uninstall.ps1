# =============================================
# ONLY CHANGE THESE LINES WHEN EMAIL ARRIVES
# =============================================
$software1 = "Google Chrome"
$process1  = "chrome"

$software2 = "Python 3.15"   # Use "Python" for all OR "Python 3.14" for specific
$process2  = "python"

$software3 = "Firefox"
$process3  = "firefox"

$software4 = "VLC media player"
$process4  = "vlc"

$software5 = ""
$process5  = ""
# =============================================
# DO NOT TOUCH ANYTHING BELOW THIS LINE
# =============================================

function Uninstall-Application {
    param(
        [string]$AppName,
        [string]$RunningProcess
    )

    if ($AppName -eq "") { return }

    Write-Host ""
    Write-Host "=== Processing: $AppName ==="

    # Stop running app
    if ($RunningProcess) {
        Write-Host "Stopping process: $RunningProcess"
        Get-Process $RunningProcess -ErrorAction SilentlyContinue |
            Stop-Process -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 3
    }

    # =============================================
    # PYTHON HANDLING (ALL USERS + VERSION BASED)
    # =============================================
    if ($AppName -like "*Python*") {

        Write-Host "Python detected"

        # Extract version digits (e.g. 3.14 → 314)
        $versionDigits = ($AppName -replace "[^0-9]", "")
        $versionDigits = $versionDigits.Substring(0, [Math]::Min(3, $versionDigits.Length))

        if ($versionDigits) {
            Write-Host "Target version: $versionDigits"
        } else {
            Write-Host "No version specified → removing ALL Python versions"
        }

        foreach ($user in Get-ChildItem "C:\Users" -Directory -ErrorAction SilentlyContinue) {

            $pythonPath = "$($user.FullName)\AppData\Local\Programs\Python"

            if (-not (Test-Path $pythonPath)) { continue }

            $folders = Get-ChildItem $pythonPath -Directory -ErrorAction SilentlyContinue

            foreach ($folder in $folders) {

                $folderDigits = ($folder.Name -replace "[^0-9]", "")

                # If version specified → match only that
                if ($versionDigits) {
                    if ($folderDigits -notlike "*$versionDigits*") { continue }
                }

                Write-Host "Deleting: $($folder.FullName)"
                Remove-Item $folder.FullName -Recurse -Force -ErrorAction SilentlyContinue
            }
        }

        Write-Host "Python removal completed"
        return
    }

    # =============================================
    # NORMAL SOFTWARE (REGISTRY METHOD)
    # =============================================
    $regPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    $foundApps = Get-ItemProperty $regPaths -ErrorAction SilentlyContinue |
                 Where-Object { $_.DisplayName -like "*$AppName*" }

    if (-not $foundApps) {
        Write-Host "NOT FOUND: $AppName"
        return
    }

    foreach ($software in @($foundApps)) {

        Write-Host "Uninstalling: $($software.DisplayName)"

        try {
            if ($software.QuietUninstallString) {
                Write-Host "Method: QuietUninstallString"
                Start-Process "cmd.exe" `
                    -ArgumentList "/c $($software.QuietUninstallString)" `
                    -Wait -NoNewWindow

            } elseif ($software.PSChildName -match '^\{.*\}$') {
                Write-Host "Method: MSI"
                Start-Process "msiexec.exe" `
                    -ArgumentList "/x `"$($software.PSChildName)`" /qn /norestart" `
                    -Wait

            } elseif ($software.UninstallString -like "*--uninstall*") {
                Write-Host "Method: Chrome style"
                $exe     = $software.UninstallString -replace '^"([^"]+)".*$', '$1'
                $exeArgs = $software.UninstallString -replace '^"[^"]+"(.*)$', '$1'
                Start-Process $exe `
                    -ArgumentList "$exeArgs --force-uninstall" -Wait

            } elseif ($software.UninstallString) {
                Write-Host "Method: Silent flags"
                $exe    = $software.UninstallString -replace '^"([^"]+)".*$', '$1'
                $result = Start-Process $exe -ArgumentList "/S" -Wait -PassThru
                if ($result.ExitCode -ne 0) {
                    $result = Start-Process $exe -ArgumentList "/silent" -Wait -PassThru
                }
                if ($result.ExitCode -ne 0) {
                    Start-Process $exe -ArgumentList "/quiet" -Wait
                }
            }

        } catch {
            Write-Host "Error: $_"
        }
    }

    Start-Sleep -Seconds 5
    Write-Host "Done: $AppName"
}

# =============================================
# EXECUTION
# =============================================
Write-Host "===== START ====="

Uninstall-Application -AppName $software1 -RunningProcess $process1
Uninstall-Application -AppName $software2 -RunningProcess $process2
Uninstall-Application -AppName $software3 -RunningProcess $process3
Uninstall-Application -AppName $software4 -RunningProcess $process4
Uninstall-Application -AppName $software5 -RunningProcess $process5

Write-Host "===== END ====="
exit 0
