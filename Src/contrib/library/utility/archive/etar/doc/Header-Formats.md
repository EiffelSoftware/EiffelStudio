**[Index](index.md) | [Home](README.md) | [Interfaces](interfaces/README.md)**
***

Currently the etar library supports two header formats: [ustar][posix08/pax-ustar header] and [pax][posix08/pax-pax header]. This page gives a rough overview over both formats. For further details, see the specification (linked above).

### ustar format
An ustar header consists of only one block, containing all relevant metadata of the next entry as described in [TAR_HEADER](interfaces/TAR_HEADER.md). Numeric values are formatted in ASCII-octal format and delimited by a NUL character. To make the numbers fixed size, they are prepended either space or '0' characters. etar uses '0' characters for writing and can parse both spaces and '0' characters. With etar, string values are encoded using the in UTF-8 format (here etar violates the specification and does not use [ISO/IEC 646:1991](https://en.wikipedia.org/wiki/ISO/IEC_646)). Paths use '/' to separate components.

### pax format
Due to the single block limitation, ustar header entries suffer from length limitations. The pax header format overcomes this limitations by adding two new payload types: pax global header and pax extended header.
Each of these entries has an ustar header that it is introduced with, followed by payload blocks containing entries of the format

length key=value

delimited by a newline character. Length includes the whole entry length (including the length field itself and the newline character). These entries are UTF-8 formatted (both in etar and the standard). Numeric fields use ASCII-decimal format. 

The entries in the extended payload blocks override the values of the next ustar header:

15 size=124158

will override the size field of the next header. Global payload types will override the entries of all following headers, except if there is an extended header that redefined the corresponding field. So the overall priorities are

1. Extended header value
2. Global header value
3. Normal header value

The [specification][posix08/pax-pax header] defines several special cases which are not mentioned here (e.g. resetting a field, multiple global headers, ...)

[posix08/pax-ustar header]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tag_20_92_13_06
[posix08/pax-pax header]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tag_20_92_13_03
