Function New-ObsidianVault {
    <#
    .SYNOPSIS
        Creates a new Obsidian Vault
    .DESCRIPTION
        This function creates a new Obsidian Vault
        It will create the folder structure and the vault.json file

    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]$VaultPath,

        [Parameter(Mandatory = $true)]
        [string]$VaultName
    )

    Begin {

    }

    Process {
        try {
            if (-not (Test-Path -Path $VaultPath)) {
                New-Item -Path $VaultPath -ItemType Directory -Force | Out-Null
            }

            [string[]] $SubFolders = @(
                '0-INBOX'
                '1-SLIPBOX'
                '2-PROJECTS'
                '3-KNOWLEDGE'
                '4-REFERENCE'
                '5-EXTRAS'
                '6-LATER'
                '99-ARCHIVE'
                'Templates'
                'DailyNotes'
                'Meta'
            )

            ForEach ($Folder in $SubFolders) {
                $FolderPath = Join-Path -Path $VaultPath -ChildPath $Folder
                if (-not (Test-Path -Path $FolderPath)) {
                    New-Item -Path $FolderPath -ItemType Directory -Force | Out-Null
                }
            }
        } catch {
            Write-Error -Message 'Failed to create Vault folder structure' -ErrorAction Stop
            throw $_
        }

        [String[]] $DefaultFiles = @(
            'README.md'
            'CHANGELOG.md'
            'LICENSE.md'
            'HOME.md'
            'vault.json'
            '.gitattributes'
            '.gitignore'
            '.editorconfig'
            '.export-ignore'
            'requirements.txt'
            'mkdocs.yml'

            'vault.json'

        }
    }
