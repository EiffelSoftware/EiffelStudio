**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

`TAR_HEADER_PARSER` is a common ancestor for classes that are able to parse tar headers. etar provides two effective implementations: `USTAR_HEADER_PARSER` and `PAX_HEADER_PARSER` for the ustar and pax format respectively. Since `PAX_HEADER_PARSER` can do everything `USTAR_HEADER_PARSER` can (plus more), it is discouraged to use `USTAR_HEADER_PARSER` directly. However, `USTAR_HEADER_PARSER` can be a valuable building block for more advanced header formats.

### Usage
Most users won't have to use `TAR_HEADER_PARSER` directly, but this section shortly explains how it is properly used.

1. parse new block of header using `parse_block`
2. Unless `parsing_finished` holds, goto 1.

### Implementing a custom header parser
To implement a custom header parser, one has to implement the following features:

#### parse_block
`parse_block (a_block: MANAGED_POINTER; a_pos: INTEGER)`

This feature takes a block and parses it according to the header format. If after this block, the whole header is parsed, `parsing_finished` has to be set to true, and `last_parsed_header` has to contain the result of the parsing step. If an error occurs, `parsing_finished` has to be set to true as well.

#### Utilities
To implement a custom header parser one can use the following utilities:

##### next_block_string
`next_block_string (a_block: MANAGED_POINTER; a_pos, a_length: INTEGER): STRING`

Returns the next string in `a_block`, starting at `a_pos`. A string is an arbitrary sequence of characters different to '%U' (stops at first '%U') with length at most `a_length`

##### TAR_UTILS
`TAR_HEADER_PARSER` does not inherit from `TAR_UTILS`. If you want to use its utilities, you have to inherit from it.

#### Errors
As `TAR_HEADER_PARSER` inherits from `ERROR_HANDLER` one can report errors using `report_new_error` (compare [ERROR](ERROR.md)).

### Possible limitations
Currently there is nothing like a `can_parse (a_block: MANAGED_POINTER; a_pos: INTEGER): BOOLEAN` feature, since for the two provided parsers, there is no need for it. However other header formats could make it necessary to implement such a feature.

***
**[Back to the index](../index.md)**

