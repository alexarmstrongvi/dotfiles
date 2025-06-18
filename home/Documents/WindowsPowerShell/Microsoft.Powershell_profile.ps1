# Probably need to run the following manually first
# Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

$Env:XDG_CONFIG_HOME = (Get-Item "$HOME\dotfiles\config").FullName

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key 'Ctrl+u' -Function BackwardKillLine
Set-PSReadLineKeyHandler -Key 'Ctrl+k' -Function KillLine