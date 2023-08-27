
Function Convert-PartialHTML {
    <#
    .SYNOPSIS
        Helper Function for converting HTML to Markdown.
    .PARAMETER InputObject
        The HTML to convert.
    .EXAMPLE
        Convert-PartialHTML '<div>Some HTML</div>'
        &lt;div&gt;Some HTML&lt;/div&gt;
    #>
    [CmdletBinding()]
    [Alias('EncodePartOfHtml')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String]$InputObject
    )

    ($InputObject -replace '<', '&lt;') -replace '>', '&gt;'
}
