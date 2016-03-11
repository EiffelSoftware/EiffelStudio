**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

`OCTAL_UTILS` provides various utility functions to turn natural numbers (`NATURAL`) to strings and vice-versa. These functions are mainly used for ustar header writer and parser. Since most features are the same for different sized types (`NATURAL_16`, `NATURAL_32`, and `NATURAL_64`) this page only describes one of these and replaces the size with `XX`.

### is_octal_formatted
`is_octal_formatted (a_string: READABLE_STRING_8): BOOLEAN`

Returns true if the given string matches the following regex: `[0-7]*`

### is_octal_natural_XX_string
`is_octal_natural_XX_string (a_string: READABLE_STRING_8): BOOLEAN`

Returns true if the given argument represents a valid octal string that fits into XX bits. Valid octal strings only consist of the characters '0' to '7' (no minus or plus sign, no spaces).

### octal_string_to_natural_XX
`octal_string_to_natural_16 (a_string: READABLE_STRING_8): NATURAL_XX`

Parse a string representing an octal number and return its value.

### natural_XX_to_octal_string
`natural_XX_to_octal_string (n: NATURAL_XX): STRING_8`

Turn a number to its octal string representation.

## Utilities and Internal Functions

### natural_8_to_octal_character
`natural_8_to_octal_character (n: NATURAL_8): CHARACTER_8`

Turn number between 0 and 7 to its character representation ('0' to '7')

### leading_zeros_count
`leading_zeros_count (a_string: STRING_8): INTEGER`

Indicates how many zeros `a_string` starts with. Mainly used for the `is_octal_natural_XX_string` features.

### pad
`pad (a_string: STRING_8; n: INTEGER)`

Prepend `n` zero characters to `a_string`. Used by ustar header writer.

***
**[Back to the index](../index.md)**

