**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

`TAR_UTILS` provides various utility features. This page only mentions the ones that a user might need to implement a custom `ARCHIVER` or `UNARCHIVER`

### needed_blocks
`needed_blocks (n: NATURAL_64): NATURAL_64`

Indicates how many blocks are required to store `n` bytes.

### pad_block
`pad_block (p: MANAGED_POINTER; a_pos, n: INTEGER)`

Pad `n` '%U' characters to `p`, starting at `a_pos`.

### file_set_metadata
`file_set_metadata (a_file: FILE; a_header: TAR_HEADER)`

Set all metadata of `a_file` that `a_header` contains (uid, gid, permissions/mode, mtime). Metatdata that causes errors is ignored.

### file_set_mode
`file_set_mode (a_file: FILE; a_mode: INTEGER)`

Set mode of `a_file`. Silently exits in case of an error.

### file_set_mtime
`file_set_mtime (a_file: FILE; a_mtime: INTEGER)`

Set mtime (last modified) of `a_file` to `a_mtime`. Silently exits in case of an error.

### file_set_uid
`file_set_uid (a_file: FILE; a_uid: INTEGER)`

Set user id to `a_file` to `a_uid`. Silently exits in case of an error.

### file_set_gid
`file_set_gid (a_file: FILE; a_gid: INTEGER)`

Set group id to `a_file` to `a_gid`. Silently exits in case of an error.

## Utilities for headers and internal functions 
### file_owner
`file_owner (uid: INTEGER): STRING

Convert a given uid to a username. Used internally for metadata setting and should not be used directly.

### file_group
`file_group (gid: INTEGER): STRING

Convert a given gid to a group name. Used internally for metadata setting and should not be used directly.

### checksum
`checksum (p: MANAGED_POINTER; a_pos: INTEGER): NATURAL_64`

Calculates the checksum of a header block in ustar format.

### unify_utf_8_path
`unify_utf_8_path (a_path: PATH): STRING_8`

Turn given path to a uniform version: UTF-8 string representation with '/' as directory separators

### unify_and_split_filename
`unify_and_split_filename (a_path: PATH): TUPLE [filename_prefix: STRING_8; filename: STRING_8]`

Unfiy given path and split it into prefix and filename (used for ustar headers).

***
**[Back to the index](../index.md)**

