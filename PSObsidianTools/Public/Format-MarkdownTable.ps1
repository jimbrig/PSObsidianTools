Function Format-MarkdownTable {
    <#
    #>
    [CmdletBinding()]
    [Alias('fmd')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSObject[]]
        $InputObject,

        [Parameter(Mandatory = $false)]
        [Switch]
        $Center,

        [Switch]
        [Parameter()]
        $AsJsonTable
    )

    Begin {
        $Items = @()
        $Columns = [ordered]@{}
    }

    Process {
        foreach ($Item in $InputObject) {
            $Items += $Item

            $Item.PSObject.Properties | ForEach-Object {
                if ($null -ne $_.Value) {
                    if (-not $Columns.Contains($_.Name) -or $Columns[$_.Name] -lt $_.Value.ToString().Length) {
                        $Columns[$_.Name] = $_.Value.ToString().Length
                    }
                }
            }
        }
    }

    End {
        $Output = ''
        if ($AsJsonTable) {
            $Output += "``````json:table`n"
            $Json = @{
                fields = $Columns.Keys | ForEach-Object { @{ key = $_; label = $_; sortable = 'true' } }
                items  = $Items | ForEach-Object {
                    $Row = @{}
                    foreach ($key in $Columns.Keys) {
                        $Row.$($key) = $_.($key)
                    }
                    $Row
                }
                filter = 'true'
            }
            $Output += "$($Json | ConvertTo-Json -Depth 10 -Compress)`n"
            $Output += "```````n"
        } else {
            foreach ($Key in $($Columns.Keys)) {
                $Columns[$Key] = [Math]::Max($Columns[$Key], $Key.Length)
            }

            $HeaderRow = @()
            foreach ($Key in $Columns.Keys) {
                $HeaderRow += ('{0,-' + $Columns[$Key] + '}') -f $Key
            }
            $Output += "$($HeaderRow -join ' | ')|`n"

            $SeparatorRow = @()
            foreach ($Key in $Columns.Keys) {
                $SeparatorRow += '-' * $Columns[$Key]
            }
            $Output += "$($SeparatorRow -join ' | ')`n"

            foreach ($Item in $Items) {
                $DataRow = @()
                foreach ($key in $Columns.Keys) {
                    $DataRow += ('{0,-' + $Columns[$key] + '}') -f $Item.($key)
                }
                $Output += "$($DataRow -join ' | ')`n"
            }
        }
        Write-Output $Output
    }
}
