Function Get-FunctionExampleCode {
    <#
    .SYNOPSIS
        Helper Function for getting the Example Code from a Function.
    .PARAMETER Example
        The Example to get the Code from.
    .EXAMPLE
        Get-FunctionExampleCode Get-FunctionExampleCode
        Get-FunctionExampleCode Get-FunctionExampleCode
    #>
    [CmdletBinding()]
    [Alias('GetCode')]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String]$Example
    )

    Begin {

        # Get the Exampe Code + Remarks (Comments)
        $CodeAndRemarks = (($Example | Out-String) -replace ($Example.Title), '').Trim() -split "`r`n"

        # Instantiate Code List (Array)
        $Code = New-Object "System.Collections.Generic.List[string]"

    }

    Process {

        # Loop through each line of the Example Code + Remarks
        for ($i = 0; $i -lt $CodeAndRemarks.Length; $i++) {

            if ($CodeAndRemarks[$i] -eq 'DESCRIPTION' -and $CodeAndRemarks[$i + 1] -eq '-----------') {
                break
            }

            if (1 -le $i -and $i -le 2) {
                continue
            }

            $Code.Add($CodeAndRemarks[$i])

        }
    }

    End {

        # Return the Code
        $Code -join "`r`n"
    }
}
