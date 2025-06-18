
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
    if (Test-Path $Path) {
        Write-Host "Target path already exists. Consider renaming: $Path"
        return
    }
    # Write-Host "Creating hard link from $Target to $Path"
    cmd /c mklink /H "$Path" "$Target"
}

# Powershell dotfiles
$tgtPath = (Get-Item ".\home\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1").FullName
$dstDir = Split-Path -Path $PROFILE -Parent

$dstPath = Join-Path -Path $dstDir -ChildPath "Microsoft.PowerShell_profile.ps1"
New-HardLinkChecked -Path $dstPath -Target $tgtPath
$dstPath = Join-Path -Path $dstDir -ChildPath "Microsoft.VSCode_profile.ps1"
New-HardLinkChecked -Path $dstPath -Target $tgtPath


# VSCode dotfiles
$tgtPath = (Get-Item ".\config\vscode\keybindings.json").FullName
$dstDir = "$env:APPDATA\Code\User"
New-HardLinkChecked -Path $dstDir -Target $tgtPath

$tgtPath = (Get-Item ".\config\vscode\settings.json").FullName
$dstDir = "$env:APPDATA\Code\User"
New-HardLinkChecked -Path $dstDir -Target $tgtPath