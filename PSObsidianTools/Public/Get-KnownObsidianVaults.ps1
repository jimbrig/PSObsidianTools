Function Get-KnownObsidianVaults {
  <#
    .SYNOPSIS
        Gets a list of known Obsidian Vaults from the User's Obsidian Configuration File.

    .DESCRIPTION
        Gets a list of known Obsidian Vaults from the User's Obsidian Configuration File.

    .PARAMETER ObsidianConfigPath
        (Optional) Path to the Obsidian Configuration (JSON) File. On Windows the default is "$env:AppData\Obsidian\obsidian.json".
        See the .NOTES section for more information.

    .EXAMPLE
        Get-KnownObsidianVaults

        ID                                   VaultName Path                                                                 TimeStamp
        --                                   --------- ----                                                                 ---------
        1c2c2c2c-3c3c-4c4c-5c5c-6c6c7c7c7c7c Vault1    C:\Users\Jimmy\Documents\Obsidian\Vault1                          2021-08-15 12:00:00 AM
        2c2c2c2c-3c3c-4c4c-5c5c-6c6c7c7c7c7c Vault2    C:\Users\Jimmy\Documents\Obsidian\Vault2                          2021-08-15 12:00:00 AM
        3c2c2c2c-3c3c-4c4c-5c5c-6c6c7c7c7c7c Vault3    C:\Users\Jimmy\Documents\Obsidian\Vault3                          2021-08-15 12:00:00 AM

    .NOTES
        This function, by default, assumes that the Obsidian Configuration File is located at "$env:AppData\Obsidian\obsidian.json"
        and will fail if the file is not found at that location or the specified location from the parameter.

        On UNIX systems, per the [Obsidian Documentation](https://help.obsidian.md/Files+and+folders/How+Obsidian+stores+data#Global+settings),
        the default locations by Operating System for global application settings directory paths are:
            - macOS: `/Users/yourusername/Library/Application Support/obsidian`
            - Windows: `%APPDATA%\Obsidian\`
            - Linux: `$XDG_CONFIG_HOME/Obsidian/ or ~/.config/Obsidian/`

        NOTE: For Linux use `$XDG_CONFIG_HOME:-$HOME/.config/obsidian/obsidian.json` as the default path to handle the
        case where `$XDG_CONFIG_HOME` is not set.

        ***

        - Inspired by: https://github.com/Yetenol/Obsidian-CLI/blob/main/obsidian.ps1
        - Obsidian Documentation: https://help.obsidian.md/Files+and+folders/How+Obsidian+stores+data#Global+settings

    .OUTPUTS
        PSCustomObject[] - List of Obsidian Vaults with the following properties:
            - ID: The Obsidian Vault ID
            - VaultName: The Obsidian Vault Name
            - Path: The Obsidian Vault Path
            - TimeStamp: The Obsidian Vault Last Modified TimeStamp (Converted from Unix Epoch Time in Milliseconds to DateTime)

    .LINK
        Get-ObsidianVault
    #>
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory = $false)]
    [ValidateScript({ Test-Path $_ })]
    [string]$ObsidianConfigPath = "$env:AppData\Obsidian\obsidian.json"
  )

  # Get Raw JSON into a PSCustomObject
  [PSCustomObject]$ObsidianJSONConfig = Get-Content -Path $ObsidianConfigPath -Raw | ConvertFrom-Json

  # Get the list of Vaults from the JSON Config, Extracting the Vault Names as an extra Property
  [PSCustomObject[]]$KnownObsidianVaults = $ObsidianJSONConfig.vaults.PSObject.Properties | ForEach-Object {
    [PSCustomObject]@{
      ID        = $_.Name;
      VaultName = ($_.Value.Path | Split-Path -Leaf);
      Path      = $_.Value.Path;
      TimeStamp = [System.DateTimeOffset]::FromUnixTimeMilliseconds($_.Value.ts).DateTime;
    }
  }

  # Return the list of Vaults PSCustomObject Table
  Return ( $KnownObsidianVaults | Format-List )

}
