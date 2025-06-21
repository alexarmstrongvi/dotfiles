# Probably need to run the following manually first
# Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

# Environment configuration
$Env:XDG_CONFIG_HOME = (Get-Item "$HOME\dotfiles\config").FullName

# Command line configuration
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key 'Ctrl+u' -Function BackwardKillLine
Set-PSReadLineKeyHandler -Key 'Ctrl+k' -Function KillLine

function prompt {
    "[$(Get-Date -Format 'HH:mm:ss')] $(Get-Location)`r`n> "
}