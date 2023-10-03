---
Date: <% tp.date.now() %>
Author: {{ AuthorName }} <{{ AuthorEmail }}>
Tags: [ "#Type/Note", "#Topic/Unknown" ]
Aliases: [ ]
---

# {{ Title }}

> [!NOTE] Sources
>
> - *[Link to Source]()*

## Contents

{{ TOC }}

## Overview

***

## Appendix: Links and References

*Note created on [[<% tp.file.creation_date("YYYY-MM-DD") %>]] and last modified on [[<% tp.file.last_modified_date("YYYY-MM-DD") %>]].*

### Internal Linked Notes

### External References

#### Backlinks

```dataview
list from [[<% tp.file.title %>]] AND -"CHANGELOG" AND -"<% tp.file.folder(true) %>/<% tp.file.title %>"
```


***

Jimmy Briggs <jimmy.briggs@jimbrig.com> | <% tp.date.now("YYYY") %>
