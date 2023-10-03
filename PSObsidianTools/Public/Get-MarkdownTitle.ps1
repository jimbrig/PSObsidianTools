Function Get-MarkdownTitle {
    <#
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ })]
        [ValidateScript( { $_.Name -like '*.md' })]
        [string]$Path,

        [Parameter(Mandatory = $false)]
        [ValidateSet(1, 2, 3, 4, 5, 6)]
        [int]$HeadingLevel = 1
    )

    Begin {
        $Pattern = ('#' * $HeadingLevel) + ' '
    }

    Process {
        $Headings = Select-String -Pattern $pattern -Path $Path | ForEach-Object { $_.Line -replace '^# ', '' }
    }

    End {
        Return $Headings
    }

}
