**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

`TAR_HEADER_WRITER` is a common ancestor for classes that are able to write tar headers. etar provides two effective implementations: `USTAR_HEADER_WRITER` and `PAX_HEADER_WRITER` for the ustar and pax format respectively. Since the ustar format suffers from certain limitations (length constraints on entries, compare [Header Formats](Header-Formats.md)), the usage of `PAX_HEADER_WRITER` is strongly encouraged, as it removes the ustar limitations. Furthermore it does not introduce any space overhead for headers that fit into a single ustar header, so there are no real drawbacks.

### Usage
Most users will most likely not have to use `TAR_HEADER_WRITER` directly, but this section shortly explains how it is properly used.

1. Check whether the header can be written using `writable`
2. Set new header to write using `set_active_header`
3. If `finished_writing` holds, exit
4. Write next block using `write_block_to_managed_pointer` or `write_block_to_new_managed_pointer`, goto 3

### Implementing a custom header writer
To implement a custom header writer, one has to implement the following features:

#### required_blocks
`required_blocks: BOOLEAN`

The amount of blocks that are required to write `active_header`. `active_header` is set by a client using `set_active_header` and represents the header for which writing is in progress.

#### writable
`writable (a_header: TAR_HEADER): BOOLEAN`

Indicate whether `a_header` can be written using this writer.

#### write_block_to_managed_pointer
`write_block_to_managed_pointer (p: MANAGED_POINTER; a_pos: INTEGER)`

Write next header block to `p` (starting at `a_pos`). This is the core feature and will probably require most work. It has to increase `written_blocks` by one.

#### Utilities
All `TAR_HEADER_WRITER` descendants can use the `TAR_UTILS` features. It is not intended that a `TAR_HEADER_WRITER` reports errors.

***
**[Back to the index](../index.md)**

