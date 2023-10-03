Function Test-MarkdownYAMLFrontMatter {
    <#

    .SYNOPSIS
        Tests a markdown file in an Obsidian Vault for valid YAML Frontmatter content (opinionated, see DESCRIPTION
        and NOTES for implmentation details on expected frontmatter variables).

    .DESCRIPTION
        This function performs tests against a markdown file to ensure it contains valid YAML Frontmatter conforming
        to the standards of my personal Obsidian Vault's structure.

    .PARAMETER Path
        The path to the markdown file to test.

    .NOTES
        YAML Frontmatter Tests:
            - Does the file contain YAML Frontmatter?
            - Check for the presence of the first and last lines of the frontmatter (---)
            - Check for a blank line after the last line of the frontmatter

        Expected Variables:
            - Date: Either just a single 'Date:' or 'Date Created:' and 'Date Modified:' with valid date formats
            - Author: Syntax is 'First Last <email>'
            - Tags: Syntax is 'Tags: [ "<tag1>", "<tag2>", ... ]
            - Aliases: Syntax is 'Aliases: [ "<alias1>", "<alias2>", ... ]

        Note that both Tags and Aliases are expected to use their plural forms

        Each Expected Variable is tested for individually against a regex pattern specific to that variable's
        expected format.

        Optional Variables:
            - CSS Classes: Syntax is 'cssclasses: ["<class1>", "<class2>", ... ]'
            - Title: Syntax is 'Title: <title>'
            - Source: Syntax is 'Source: <source>'
            - Sources: Syntax is 'Sources: [ "<source1>", "<source2>", ... ], where sources should be URLs
            - Type: Syntax is 'Type: <type>' and is validated against a list of valid types plus the Type should be
                included as a tag in the Tags variable list with syntax '#Type/<type>'.
            - Topic: Syntax is 'Topic: <topic>' and is validated against a list of valid topics plus the Topic should
                be included as a tag in the Tags variable list with syntax '#Topic/<topic>'.
            - Status: Syntax is 'Status: <status>' and is validated against a list of valid statuses plus the Status
                should be included as a tag in the Tags variable list with syntax '#Status/<status>'.
            - Publish: Syntax is 'Publish: <true|false>' and is validated as a boolean value.
            - Cover: Syntax is 'Cover: <path>' and is validated as a path to an image file. The path should be resolveable
                and be a valid image format for use (png, jpg, jpeg).
            - TimeStamp: Syntax is 'TimeStamp: <timestamp>' and is validated as a valid timestamp format.

    .EXAMPLE
        Test-MarkdownYAMLFrontMatter -Path "C:\Users\Jimmy\Documents\Obsidian\MyVault\0-INBOX\MyNote.md"

        # This example tests the frontmatter of the markdown file "MyNote.md" in the "0-INBOX" folder of the Obsidian Vault "MyVault".

    .OUTPUTS
        Boolean value indicating whether all expected frontmatter tests passed.

    .INPUTS
        String value representing the path to the markdown file to test.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ })]
        [ValidateScript( { $_.Name -like '*.md' })]
        [string]$Path
    )

    Begin {

        $YAMLDateVars = @(
            'Date'
            'Date Created'
            'Date Modified'
            'TimeStamp'
        )

        $YAMLMultiVars = @(
            'Tags'
            'Aliases'
            'cssclasses'
            'Sources'
        )

        $YAMLSingleVars = @(
            'Author'
            'Cover'
            'Source'
            'Type'
            'Topic'
            'Status'
            'Publish'
        )

        $YAMLExpectedVars = @(
            'Date Created'
            'Date Modified'
            'Author'
            'Tags'
            'Aliases'
        )

        # $DatePatterns = $YAMLDateVars | ForEach-Object { '^' + $_ + ':.\d{4}-\d{2}-\d{2}.*$' }
        # $MultiPatterns = $YAMLMultiVars | ForEach-Object { '^' + $_ + ':.[\w,]+.*$' }
        # $SinglePatterns = $YAMLSingleVars | ForEach-Object { '^' + $_ + ':.\w+.*$' }

        $StartFinishPattern = '^---$'
        $PatternAuthor = '^Author:.* <[^@]+@[^>]+>$'
        $PatternDate = '^Date:.\d{4}-\d{2}-\d{2}.*$'
        $PatternDateCreated = '^Date Created:.\d{4}-\d{2}-\d{2}.*$'
        $PatternDateModified = '^Date Modified:.\d{4}-\d{2}-\d{2}.*$'
        $PatternTags = '^Tags:\s*\[\s*("[^"]*"\s*,\s*)*"[^"]*"\s*\]$'
        $PatternAliases = '^Aliases:\s*\[\s*("[^"]*"\s*,\s*)*"[^"]*"\s*\]$'
        $PatternCSSClasses = '^cssclasses:.[\w,]+.*$'
        $PatternTitle = '^Title:.\w+.*$'
    }

    Process {

        # Get the first and last lines of the frontmatter by detecting '---'
        $StartFinishLines = Select-String -Path $Path -Pattern $StartFinishPattern -AllMatches | `
            Select-Object -ExpandProperty LineNumber

        # Extract the frontmatter content
        $FrontMatterContent = Get-Content -Path $Path | `
            Select-Object -Index (($StartFinishLines[0] - 1)..$StartFinishLines[1])

        # Ensure First and Last lines are '---'
        $TestFirstLine = $FrontMatterContent[0] -match $StartFinishPattern
        $TestLastLine = $FrontMatterContent[-2] -match $StartFinishPattern

        # Ensure Last Line followed by a blank line
        $TestLastLineLineBreak = $FrontMatterContent[-1] -match '^$'

        # Test for each expected frontmatter variable (Date, Author, Tags, Aliases)
        $TestDate = $FrontMatterContent -match "$PatternDate|$PatternDateCreated|$PatternDateModified"
        $TestAuthor = $FrontMatterContent -match $PatternAuthor
        $TestTags = $FrontMatterContent -match $PatternTags
        $TestAliases = $FrontMatterContent -match $PatternAliases

        $ExpectedTests = @(
            $TestFirstLine
            $TestLastLine
            $TestLastLineLineBreak
            $TestDate
            $TestAuthor
            $TestTags
            $TestAliases
        )

        $ExpectedTestsPassedCnt = $ExpectedTests | `
            Where-Object { $_ -eq $true } | `
            Measure-Object | `
            Select-Object -ExpandProperty Count

        $ExpectedTestsPassed = ($ExpectedTestsPassedCnt -eq $ExpectedTests.Count)

        # Tests for optional variables
        # $TestCSSClasses = $FrontMatterContent -match $PatternCSSClasses
        # $TestTitle = $FrontMatterContent -match $PatternTitle
        # $TestSource = $FrontMatterContent -match $PatternSource
        # $TestSources = $FrontMatterContent -match $PatternSources
        # $TestType = $FrontMatterContent -match $PatternType
        # $TestTopic = $FrontMatterContent -match $PatternTopic
        # $TestStatus = $FrontMatterContent -match $PatternStatus
        # $TestPublish = $FrontMatterContent -match $PatternPublish

        # All Tests
        # $AllTests = @(
        #     $TestFirstLine
        #     $TestLastLine
        #     $TestLastLineLineBreak
        #     $TestDate
        #     $TestAuthor
        #     $TestTags
        #     $TestAliases
        #     $TestCSSClasses
        #     $TestTitle
        #     $TestSource
        #     $TestSources
        #     $TestType
        #     $TestTopic
        #     $TestStatus
        #     $TestPublish
        # )

    }

    End {
        if ($ExpectedTestsPassed) {
            Write-Host 'All expected frontmatter tests passed' -ForegroundColor Green
            return $true
        } else {
            Write-Host 'Not all expected frontmatter tests passed...' -ForegroundColor Red
            return $false
        }
    }
}
