Function Register-VaultExtension {
    <#
    .SYNOPSIS
        Registers a custom "*.vault" extension for opening Obsidian Vault directories in Obsidian.
    .DESCRIPTION
        This function registers a custom "*.vault" extension for opening Obsidian Vault directories in Obsidian.

        This is similar to how a VSCode workspace (`*.code-workspace`) file automatically opens VSCode, or `*.Rproj`
        files automatically open RStudio.

        This function is idempotent, so it can be run multiple times without issue.
    .EXAMPLE
        Register-VaultExtension

        # Will register the `.vault` file extension to launch vaults from file explorer in Obsidian.
    #>
    [CmdletBinding()]
    Param(

    )

    # Update PATHEXT Environment Variable with new .VAULT extension:
    # CMD: SETX PATHEXT "%PATHEXT%;.VAULT"
    [Environment]::SetEnvironmentVariable("PATHEXT", $env:PATHEXT + ";.VAULT", "User")

    # Associate file extension and register to command that opens obsidian
    # CMD: ASSOC .vault=ObsidianVault.File
    New-Item -Path 'HKCU:\Software\Classes\.vault' -Force | Out-Null
    New-ItemProperty -Path 'HKCU:\Software\Classes\.vault' -Name '' -Value 'ObsidianVault.File' -Force | Out-Null

    # Add Registry Key for ObsidianVault.File
    New-Item -Path "HKCU:\Software\Classes\ObsidianVault.File" -Force | Out-Null

    # Add Registry Key for the Command to Open Obsidian
    $command = 'pwsh.exe -NoProfile -w Hidden -Command { Import-Module PSObsidianMD; Open-ObsidianVault -Vault "%1" %* }'
    New-ItemProperty -Path "HKCU:\Software\Classes\ObsidianVault.File" -Name "" -Value $command -Force | Out-Null

    # Add Registry Key for the Icon to use for the ObsidianVault.File
    # Create new sub-key for DefaultIcon
    Get-Item -Path 'HKCR:\ObsidianVault.File' | New-Item -Name 'DefaultIcon' -Force

    # Add default value of type REG_SZ for the icon's source location
    New-ItemProperty -Path 'HKCR:\ObsidianVault.File\DefaultIcon' -Name '(Default)' -Value "%LOCALAPPDATA%\Obsidian\Obsidian.exe,0" -PropertyType REG_SZ -Force

}
