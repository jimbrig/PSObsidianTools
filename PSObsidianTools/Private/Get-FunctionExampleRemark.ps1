Function Get-FunctionExampleRemark {
    <#
    .SYNOPSIS
        Helper Function for getting the Example Remark from a Function's Example DocString.
    .PARAMETER Example
        The Example to get the Remark from.
    .EXAMPLE
        Get-FunctionExampleRemark Get-FunctionExampleRemark
        Get-FunctionExampleRemark Get-FunctionExampleRemark
    #>
    [CmdletBinding()]
    [Alias('GetRemark')]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String]$Example
    )

    Begin {

        # Get the Exampe Code + Remarks (Comments)
        $CodeAndRemarks = (($Example | Out-String) -replace ($Example.Title), '').Trim() -split "`r`n"

        # Set IsSkipped = $false
        $IsSkipped = $false

        # Instantiate Remark List (Array)
        $Remark = New-Object "System.Collections.Generic.List[string]"

    }

    Process {

        for ($i = 0; $i -lt $CodeAndRemarks.Length; $i++) {

            if (!$IsSkipped -and $CodeAndRemarks[$i - 2] -ne 'DESCRIPTION' -and $CodeAndRemarks[$i - 1] -ne '-----------') {
                continue
            }

            $IsSkipped = $true
            $Remark.Add($CodeAndRemarks[$i])
        }

    }

    End {

        # Return the Remark
        $Remark -join "`r`n"
    }

}
