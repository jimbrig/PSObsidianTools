Enum ObsidianTemplateType {
    Undefined = 0
    Note
    Daily
    Project
    Knowledge
    Reference
    List
    MOC
    Slipbox
    Source
    Code
    Tool
}

Class ObsidianTemplate {
    hidden [ObsidianTemplateType] $Type = [ObsidianTemplateType]::Undefined
    [string] $Name
    [string] $Description
    [string] $Template

    [ObsidianTemplateType] GetTemplateType() {
        return $this.Type
    }

    ObsidianTemplate() {
        $this.Type = [ObsidianTemplateType]::Undefined
    }

    ObsidianTemplate(
        [string] $Name,
        [string] $Description,
        [string] $Template,
        [ObsidianTemplateType] $Type
    ) {
        $this.Name = $Name
        $this.Description = $Description
        $this.Template = $Template
        $this.Type = $Type
    }

    [string] ToString() {
        return $this.Name
    }
}
