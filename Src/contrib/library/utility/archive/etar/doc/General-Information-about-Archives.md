**[Index](index.md) | [Home](README.md) | [Interfaces](interfaces/README.md)**
***

### Archives

An archive is a file that combines multiple files (including metadata) in one single file. Compression is possible but not necessary. The etar library uses tar-style layout for its archives. This section contains a tiny summary of how the tar format generally looks like:

An archive ultimately is a series of blocks, each block consisting of 512 bytes. The last two blocks indicate the end of the archive and contain only zero bytes. All other blocks form entries. An entry consists of exactly one header block, followed by zero or more payload blocks. The exact number of payload blocks depends on the contents of the header block.

![Archive Schematic](archive.png)

#### Header blocks

Header blocks contain metadata about the following payload blocks, like for example:
* filename
* type (directory, regular file, ...)
* owner name

and more. For a detailed description of the header format see [the corresponding section in the pax specification][posix08/pax-ustar header]

[posix08/pax]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html
[posix08/pax-ustar header]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tagtcjh_28
