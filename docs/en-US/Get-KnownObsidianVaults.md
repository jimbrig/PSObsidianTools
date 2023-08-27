---
external help file: PSObsidianTools-help.xml
Module Name: PSObsidianTools
online version:
schema: 2.0.0
---

# Get-KnownObsidianVaults

## SYNOPSIS
Gets a list of known Obsidian Vaults from the User's Obsidian Configuration File.

## SYNTAX

```
Get-KnownObsidianVaults [[-ObsidianConfigPath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a list of known Obsidian Vaults from the User's Obsidian Configuration File.

## EXAMPLES

### EXAMPLE 1
```
Get-KnownObsidianVaults
```

ID                                   VaultName Path                                                                 TimeStamp
--                                   --------- ----                                                                 ---------
1c2c2c2c-3c3c-4c4c-5c5c-6c6c7c7c7c7c Vault1    C:\Users\Jimmy\Documents\Obsidian\Vault1                          2021-08-15 12:00:00 AM
2c2c2c2c-3c3c-4c4c-5c5c-6c6c7c7c7c7c Vault2    C:\Users\Jimmy\Documents\Obsidian\Vault2                          2021-08-15 12:00:00 AM
3c2c2c2c-3c3c-4c4c-5c5c-6c6c7c7c7c7c Vault3    C:\Users\Jimmy\Documents\Obsidian\Vault3                          2021-08-15 12:00:00 AM

## PARAMETERS

### -ObsidianConfigPath
(Optional) Path to the Obsidian Configuration (JSON) File.
On Windows the default is "$env:AppData\Obsidian\obsidian.json".
See the .NOTES section for more information.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: "$env:AppData\Obsidian\obsidian.json"
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PSCustomObject[] - List of Obsidian Vaults with the following properties:
### - ID: The Obsidian Vault ID
### - VaultName: The Obsidian Vault Name
### - Path: The Obsidian Vault Path
### - TimeStamp: The Obsidian Vault Last Modified TimeStamp (Converted from Unix Epoch Time in Milliseconds to DateTime)
## NOTES
This function, by default, assumes that the Obsidian Configuration File is located at "$env:AppData\Obsidian\obsidian.json"
and will fail if the file is not found at that location or the specified location from the parameter.

On UNIX systems, per the \[Obsidian Documentation\](https://help.obsidian.md/Files+and+folders/How+Obsidian+stores+data#Global+settings),
the default locations by Operating System for global application settings directory paths are:
    - macOS: \`/Users/yourusername/Library/Application Support/obsidian\`
    - Windows: \`%APPDATA%\Obsidian\\\`
    - Linux: \`$XDG_CONFIG_HOME/Obsidian/ or ~/.config/Obsidian/\`

NOTE: For Linux use \`$XDG_CONFIG_HOME:-$HOME/.config/obsidian/obsidian.json\` as the default path to handle the
case where \`$XDG_CONFIG_HOME\` is not set.

***

- Inspired by: https://github.com/Yetenol/Obsidian-CLI/blob/main/obsidian.ps1
- Obsidian Documentation: https://help.obsidian.md/Files+and+folders/How+Obsidian+stores+data#Global+settings

## RELATED LINKS

[Get-ObsidianVault]()

[Online Version: https://docs.jimbrig.com/PSObsidianMD/Get-KnownObsidianVaults.html]()

