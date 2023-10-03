Function Get-MarkdownHelp {
    <#
    .SYNOPSIS
        Gets the comment-based help and converts to GitHub Flavored Markdown.
    .PARAMETER Name
        A command name to get comment-based help.
    .EXAMPLE
        Get-HelpByMarkdown Select-Object > .\Select-Object.md

        DESCRIPTION
        -----------
        This example gets comment-based help of `Select-Object` command, and converts GitHub Flavored Markdown format,
        then saves it to `Select-Object.md` in current directory.
    .NOTES
        This function depends on the following other helper functions:
        - `Get-FunctionExampleCode`
        - `Get-FunctionExampleRemark`
    .LINK
        Get-FunctionExampleCode
    .LINK
        Get-FunctionExampleRemark
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True)]
        [ValidateScript({ Get-Command $_ })]
        [String]$Name
    )

    Process {

        try {
            if ($Host.UI.RawUI) {
                $RawUI = $Host.UI.RawUI
                $OldSize = $RawUI.BufferSize
                $TypeName = $OldSize.GetType().FullName
                $NewSize = New-Object $TypeName (500, $OldSize.Height)
                $RawUI.BufferSize = $NewSize

            }

            $Full = Get-Help $Name -Full

            @"
# $($full.Name)
## SYNOPSIS
$($full.Synopsis)
## SYNTAX
``````powershell
$((($full.syntax | Out-String) -replace "`r`n", "`r`n`r`n").Trim())
``````
## DESCRIPTION
$(($full.description | Out-String).Trim())
## PARAMETERS
"@ + $(foreach ($parameter in $full.parameters.parameter) {
                    @"
### -$($parameter.name) &lt;$($parameter.type.name)&gt;
$(($parameter.description | Out-String).Trim())
``````
$(((($parameter | Out-String).Trim() -split "`r`n")[-5..-1] | ForEach-Object { $_.Trim() }) -join "`r`n")
``````
"@
                }) + @"
## INPUTS
$($full.inputTypes.inputType.type.name)
## OUTPUTS
$(if ($null -ne $full.returnValues) { $full.returnValues.returnValue[0].type.name })
## NOTES
$(($full.alertSet.alert | Out-String).Trim())
## EXAMPLES
"@ + $(foreach ($example in $full.examples.example) {
                    @"
### $(($example.title -replace '-*', '').Trim())
``````powershell
$(Get-FunctionExampleCode $example)
``````
$(Get-FunctionExampleRemark $example)
"@
                }) + @'

'@

        } finally {
            if ($Host.UI.RawUI) {
                $rawUI = $Host.UI.RawUI
                $rawUI.BufferSize = $oldSize
            }
        }

    }

}
