@{
    PSDepend = @{
        Version = 'latest'
    }
    PSDependOptions = @{
        Target = './Build/Modules'
    }
    'Pester' = @{
        Version = 'latest'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
    'psake' = @{
        Version = 'latest'
    }
    'BuildHelpers' = @{
        Version = 'latest'
    }
    'PowerShellBuild' = @{
        Version = 'latest'
    }
    'PSScriptAnalyzer' = @{
        Version = 'latest'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
}
