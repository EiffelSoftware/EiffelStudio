**[Index](index.md) | [Home](README.md) | [Interfaces](interfaces/README.md)**
***

To use the etar library, one does not have to know anything about the used formats. The following pieces of code illustrate, how an archive can be extracted and created:

```
unarchive (a_file: FILE)
        -- Unarchive `a_file'
    local
        l_archive: ARCHIVE
    do
        create l_archive.make (create {FILE_STORAGE_BACKEND}.make_from_file (a_file))
        l_archive.add_unarchiver (create {FILE_UNARCHIVER})                   
        l_archive.add_unarchiver (create {DIRECTORY_UNARCHIVER})
        l_archive.open_unarchive
        l_archive.unarchive
    end

archive (a_file: FILE; a_archive_file: FILE)
        -- Archive `a_file' to new archive `a_archive_file'
    require
        plain_file: a_file.is_plain
    local
        l_archive: ARCHIVE
    do
        create l_archive.make (create {FILE_STORAGE_BACKEND}.make_from_file (a_file))
        l_archive.open_archive
        a_archive.add_entry (create {FILE_ARCHIVABLE}.make (a_file))
        l_archive.close
    end
```

[ARCHIVE](ARCHIVE.md) explains more details about the exact usage of etar's central class.

Additionally, one can find further examples under [/examples](../examples)
