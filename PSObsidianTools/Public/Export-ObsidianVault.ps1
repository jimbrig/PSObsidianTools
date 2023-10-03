Function Export-ObsidianVault {
    <#
    #>
    [CmdletBinding()]
    Param(

    )

    Begin {
        $Vault = Split-Path '.' -Leaf
        Set-Location '..\'
        $VaultCopy = "$Vault-Copy"
        if (Test-Path $VaultCopy) {
            Remove-Item $VaultCopy -Recurse -Force
        }
        Copy-Item $Vault $VaultCopy -Recurse -Force
        Set-Location $VaultCopy
    }

    Process {
        # Change _README.md to README.md
        Get-ChildItem -Recurse -File -Filter '_README.md' |
        ForEach-Object { Rename-Item -Force -Path $_.PSPath -NewName $_.Name.replace('_README', 'README') }

        Set-Location '..\'

        $VaultExport = "$Vault-Export"

        if (Test-Path $VaultExport) {
            Remove-Item $VaultExport -Recurse -Force
        }

        New-Item -ItemType Directory $VaultExport

        Copy-Item -Path "$Vault\.git" -Destination "$VaultExport\" -Recurse -Force
        Set-Location $VaultExport
        git checkout main
        Set-Location '..\'
        obsidian-export KaaS-Copy KaaS-Export
        Set-Location KaaS-Export
        tree
        git status
    }

    End {

    }

}
