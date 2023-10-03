---
Date: <% tp.date.now() %>
Author: {{ AuthorName }} <{{ AuthorEmail }}>
Tags: [ "#Type/Daily", "#Topic/Journal" ]
Aliases: [ "<% tp.date.now("YYYY-MM-DD") %>", "<% moment(tp.file.title,'YYYY-MM-DD').format("dddd, MMMM DD, YYYY") %>" ]
---

<< [[<% tp.date.yesterday() %>]] | [[<% tp.date.tomorrow() %>]] >>


# <% moment(tp.file.title,'YYYY-MM-DD').format("dddd, MMMM DD, YYYY") %>

## Journal

> Personalized daily activity logs

## Discoveries

> Anything relevant that I discovered on this day (i.e. tools, technology, articles, podcasts, videos, people, etc.)

## Notes

> Scratchpad for daily notes

## Tasks

```todoist
name: Highest Priority & Date
filter: "today | overdue"
sorting:
   - date
   - priority
group: true
```


### Generated Notes Today

```dataview
TABLE file.folder AS Folder
WHERE file.cday = date(this.file.name) AND file.name !=(this.file.name)
SORT file.folder ASC, file.name ASC
```

### Modified Notes Today

```dataview
TABLE file.folder AS Folder
WHERE file.mday = date(this.file.name)
 AND file.name !=(this.file.name)
SORT file.mtime asc
```

***

## Appendix: Links and References

*Note created on [[<% tp.file.creation_date("YYYY-MM-DD") %>]] and last modified on [[<% tp.file.last_modified_date("YYYY-MM-DD") %>]].*

### Internal Linked Notes

- [[Daily Notes]]

### External References

#### Backlinks

```dataview
list from [[<% tp.file.title %>]] AND -"Changelog" AND -"<% tp.file.title %>"
```


***

Jimmy Briggs <jimmy.briggs@jimbrig.com> | <% tp.date.now("YYYY") %>
