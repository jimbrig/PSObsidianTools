Function Get-ObsidianVaultWordCount {
    <#
    .SYNOPSIS
        Counts the number of words in all markdown files in a given folder path.
    .DESCRIPTION
        This function counts the number of words in all markdown files in a given folder path.
        It ignores certain file and folder names specified in the code (see details in Notes below).
    .PARAMETER FolderPath
        The path of the folder, representing an Obsidian Vault, to use.
    .EXAMPLE
        Get-VaultWordCount -FolderPath "$HOME\Dev\obsidian\MyVault"

        # This example returns the total word count of all markdown files in the "MyVault" folder.
    .NOTES
        Currently, this function ignores the following file names:
            - LICENSE
            - README.md
            - _README.md
            - CHANGELOG.md
            - HOME.md

        Currently, this function ignores the following folder's files:
            - Templates
            - node_modules
            - .obsidian
            - .bin
            - .git
            - .github
            - .docker
            - .vscode
            - .venv
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True)]
        [ValidateScript({ Test-Path $_ -PathType Container })]
        [String]$VaultPath
    )

    Begin {
        $FileNamesToIgnore = @(
            'LICENSE'
            'LICENSE.md'
            'README.md'
            '_README.md'
            'CHANGELOG.md'
            'HOME.md'
        )

        $FolderNamesToIgnore = @(
            'Templates'
            'node_modules'
            '.obsidian'
            '.bin'
            '.git'
            '.github'
            '.docker'
            '.vscode'
            '.venv'
        )

        $WordCount = 0
    }

    Process {
        $Files = Get-ChildItem -Path $FolderPath -Recurse -File -Force | `
            Where-Object { !($_.PSIsContainer) } | `
            Where-Object { $FolderNamesToIgnore -notmatch $_.FullName } | `
            Where-Object { $FileNamesToIgnore -notcontains $_.Name } | `
            Where-Object { $_.Extension -eq '.md' }

        $Files | ForEach-Object {
            $WordCount += (Get-WordCount -Path $_.FullName)
        }
    }

    End {
        Return $WordCount
    }
}

Function Get-WordCount {
    <#
        .SYNOPSIS
            Returns the number of words in a file.
        .DESCRIPTION
            Returns the number of words in a file.
        .PARAMETER Path
            The path to the file (must be a file, not a directory).
        .EXAMPLE
            Get-WordCount -Path "$HOME\Documents\GitHub\PSObsidian\README.md"

            # Returns the number of words in the README.md file.
        .NOTES
            - Used by the function Get-VaultWordCount.
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path -Path $_ -PathType Leaf })]
        [string]$Path
    )

    return (Get-Content -Path $Path -Raw | Measure-Object -Word).Words
}

# dir . *.md -recurse |
#     ? { !$_.PSIsContainer -and
#     ($_.Name -ne "01_summary.md") -and
#     ($_.Name -ne "summary.md") -and
#     !($_.FullName -match "node_modules") -and
#     !($_.FullName -match "_book")} |
#     get-content |
#     measure-object -Word |
#     % {  "" + $_.Words + " words"}
