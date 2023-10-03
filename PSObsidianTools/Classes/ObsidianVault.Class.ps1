# Vault class mirroring the official vault entries in the obsidian.json AppData Configuration
class Vault {
    [string]$path
    [int]$ts
    [bool]$open = $true
}

# Simpler vault representation class
class ObsidianVault {

    [string]$VaultPath
    [string]$VaultName
    [string]$VaultConfigPath
    [string]$VaultConfigFile
    # Last Modified TimeStamp
    [int]$VaultLastModified
    [string]$VaultLastModifiedDateTime

    [string]$VaultURI



    [string]$path
    [int]$ts
}
