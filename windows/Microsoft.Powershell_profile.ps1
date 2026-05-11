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

function Remove-TrailingWhitespace {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    Get-ChildItem -Path $Path -Recurse -File |
    ForEach-Object {
        $content = Get-Content -LiteralPath $_.FullName -Raw
        $newContent = $content -replace '[ \t]+(?=\r?\n|$)', ''
        if ($content -ne $newContent) {
            [System.IO.File]::WriteAllText($_.FullName, $newContent)
        }
    }
}
