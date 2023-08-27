Function Open-ObsidianVault {
    <#
    .DESCRIPTION
        Launches an Obsidian Vault
    .PARAMETER VaultPath
        Path of the Vault to Launch.
    .EXAMPLE
        Open-ObsidianVault -VaultPath "C:\Users\Jimmy\Documents\Obsidian"

        # Will Open the Obsidian Vault with the specified path in Obsidian.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path $_ })]
        [string]$VaultPath
    )

    If ($Vault -like "*:\*") {
        $Vault = Split-Path $Vault -Leaf
    }

    $Vault = (($Vault.Replace(" ", "%20")).Replace("\", "/")).Replace(".vault", "")

    $URI = "obsidian://vault/$Vault"

    Start-Process $URI -Wait
}
