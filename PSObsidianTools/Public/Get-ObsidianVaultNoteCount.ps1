Function Get-ObsidianVaultNoteCount {
    <#
    #>
    [CmdletBinding()]
    Param(
        [String]$Path
    )

    Begin {
        $ExcludedFiles = @(
            'LICENSE.md'
            'README.md'
            '_README.md'
            'CHANGELOG.md'
            'HOME.md'
        )

        $ExcludedFolders = @(
            'Templates'
            '99 - Archives'
        )
    }

    Process {
        $Cnt = Get-ChildItem -Path $Path -Recurse -File -Filter '*.md' |
        Where-Object { !($_.PSIsContainer) -and ($_.Name -notlike $ExcludedFiles) -and ($_.FullName -notmatch $ExcludedFolders) } |
        Where-Object { $_.Extension -eq '.md' } |
        Measure-Object |
        Select-Object -ExpandProperty Count
    }

    End {
        Return "Found $Cnt Total Markdown Notes in $(Resolve-Path $Path)"
    }
}
