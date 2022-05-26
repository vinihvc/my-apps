param([switch]$Elevated)

# Ask for Administrator rights
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

$myApps = @(
# Dev
'Microsoft.WindowsTerminal',
'Microsoft.VisualStudioCode',
'Git.Git',

# WSL
'Canonical.Ubuntu.2004',

# Browser
'Mozilla.Firefox',

# Tools System
'Microsoft.PowerToys',
'Nvidia.GeForceExperience',
'Twilio.Authy',
'Dropbox.Dropbox',

# Comunication
'Discord.Discord',
'SlackTechnologies.Slack',

# Gaming
'Valve.Steam'
)

$myApps | ForEach-Object -Process { winget install -e --id $_ }