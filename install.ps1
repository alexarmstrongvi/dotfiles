function New-HardLinkChecked {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path,

        [Parameter(Mandatory=$true)]
        [string]$Target
    )
    if ((Test-Path $Path) -And (Get-Item $Path).PSIsContainer) {
        # Directory target provided so assume caller wants to use target filename
        $Path = Join-Path -Path $Path -ChildPath (Split-Path -Path $Target -Leaf)
    }
    $drive1 = ([System.IO.Path]::GetPathRoot($Path)).ToUpper()
    $drive2 = ([System.IO.Path]::GetPathRoot($Target)).ToUpper()
    if ($drive1 -ne $drive2) {
        Write-Host "WARNING: Paths are on different drives: $drive1 and $drive2"
    # } else {
    #     Write-Host "DEBUG: Paths are both on drive $drive1"
    }
    if (Test-Path $Path) {
        Write-Host "Target path already exists. Consider renaming: $Path"
        return
    }
    # Write-Host "Creating hard link from $Target to $Path"
    cmd /c mklink /H "$Path" "$Target"
}

# Powershell dotfiles
$tgtPath = (Get-Item ".\windows\Microsoft.PowerShell_profile.ps1").FullName
# NB: $PROFILE may not exist yet
$dstDir = [System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($PROFILE))

$dstPath = Join-Path -Path $dstDir -ChildPath "PowerShell/Microsoft.PowerShell_profile.ps1"
New-HardLinkChecked -Path $dstPath -Target $tgtPath
$dstPath = Join-Path -Path $dstDir -ChildPath "PowerShell/Microsoft.VSCode_profile.ps1"
New-HardLinkChecked -Path $dstPath -Target $tgtPath
$dstPath = Join-Path -Path $dstDir -ChildPath "WindowsPowerShell/Microsoft.PowerShell_profile.ps1"
New-HardLinkChecked -Path $dstPath -Target $tgtPath
$dstPath = Join-Path -Path $dstDir -ChildPath "WindowsPowerShell/Microsoft.VSCode_profile.ps1"
New-HardLinkChecked -Path $dstPath -Target $tgtPath

# VSCode dotfiles
$tgtPath = (Get-Item ".\config\vscode\keybindings.json").FullName
$dstDir = "$env:APPDATA\Code\User"
New-HardLinkChecked -Path $dstDir -Target $tgtPath

$tgtPath = (Get-Item ".\config\vscode\settings.json").FullName
$dstDir = "$env:APPDATA\Code\User"
New-HardLinkChecked -Path $dstDir -Target $tgtPath