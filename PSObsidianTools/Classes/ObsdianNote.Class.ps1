class Note {
    [int] $Id
    [string] $Path
    [string] $Name
    [string] $Extension

    [string] ToMarkdown() {
        return "[$($this.Name)]($($this.Path))"
    }

    [string] ToObsidianLink() {
        return "[[$($this.Name)]]"
    }

    Note ($Id, $Path, $Name, $Extension) {
        $this.Id = $Id
        $this.Path = $Path
        $this.Name = $Name
        $this.Extension = $Extension
    }
}

class Tag {
    [int] $Id
    [string] $Name
}


class ObsidianNote {
    hidden [string] $Path

    [string] $Name

    [ValidateSet('Note', 'Daily Note', 'Project', 'MOC', 'List', 'Tool', 'Template', 'Slipbox', 'Source', 'Meta')]
    [string] $NoteType

    [string] $Author

    [string] $Topic

    [string[]] $Keywords

    [string[]] $URL

    [string[]] $Links

    [string[]] $Tags

    [string[]] $Aliases

    [string] $Content

    ObsidianNote ($Name, $Path, $NoteType) {
        $this.Name = $Name
        $this.Path = $Path
        $this.NoteType = $NoteType
    }
}
