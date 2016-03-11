**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

A `TAR_HEADER` instance contains all metadata archives store. This page is based on the [pax][posix08/pax-ustar header] specification (ustar interchange format part).

### Metadata

#### filename
Path to the file. Absolute paths are allowed, but most implementations turn them into relative paths.

#### mode
Traditional UNIX style file permissions (0777, 0644, ...)

#### user_id
User id of the file owner.

#### group_id
Group id of the file group.

#### size
For regular files this contains the size of the file in bytes. For etar purposes, this is 0 for all other cases. More details can be found in the [pax specification][posix08/pax-ustar header].

For files, this value is used to calculate the number of payload blocks that will follow the header.

#### mtime
Modification time of the file at archiving time. This value is measured in unix time (seconds since 00:00:00 UTC on 1 January 1970). The `time` library provides utilities to convert between time formats.


#### typeflag
Indicates what payload type this header follows. These values are standardized:

Flag    | Description
--------|----------------------------------------------------------------------------------------------
'0'     | Regular files ('%U' is allowed for backward compatibility but should not be used any longer)
'1'     | Hardlink (only allowed if the content / link target is archived as well)
'2'     | Symlink
'3'     | Character special device
'4'     | Block special device
'5'     | Directory
'6'     | FIFO
'7'     | Files with some high-performance attribute (implementation defined, may treat as regular file)
'A'-'Z' | Reserved for custom implementations
        | Everything else is reserved for further standardization

#### linkname
Target (pointee) of a link-type entry (empty/ignored otherwise)

#### user_name
Username of file owner

#### group_name
Groupname of file group

#### device_major
Device major number of special devices (block/character)

#### device_minor
Device minor number of special devices (block/character)


[posix08/pax-ustar header]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tagtcjh_28

***
**[Back to the index](../index.md)**

