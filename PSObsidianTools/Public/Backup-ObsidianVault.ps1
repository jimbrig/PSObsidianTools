Function Backup-ObsidianVault {
    <#
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True, Position = 0)]
        [String]$VaultPath,
        [Parameter(Mandatory = $True, Position = 1)]
        [String]$BackupPath
    )

    Begin {
        Set-StrictMode -Version Latest
        $ErrorActionPreference = 'Stop'

        $TimeStamp = Get-Date -Format 'yyyyMMddHHmmss'
        $VaultPath = Resolve-Path -Path $VaultPath
        $BackupPath = Join-Path -Path $BackupPath -ChildPath "obsidian-backup-$TimeStamp"
    }

    Process {
        Write-Verbose -Message "Backing up vault to $BackupPath"
        Compress-Archive -Path $VaultPath -DestinationPath $BackupPath -CompressionLevel Optimal -Force
        Write-Verbose -Message 'Backup complete'
    }

    End {
        Write-Verbose -Message 'Done'
        Write-Output -InputObject $BackupPath
        Write-Verbose -Message "Backup location: $BackupPath"
    }
}
