**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

`UNARCHIVER` is the central piece for unarchiving. `ARCHIVE` will parse the header and search for the last registered (!) `UNARCHIVER` that can unarchive the payload that belongs to the header (using the `can_unarchvive` feature). This unarchiver will then be initialized with the header and be passed blocks until it indicates that unarchiving finished.

### FILE_UNARCHIVER
`FILE_UNARCHIVER` accepts all header that have a typeflag for a regular file ('0' and '%U'). It will create a `RAW_FILE` and copy all payload blocks to it, until `size` bytes are written (`size` as given by the header). Additionally it will try to set the metadata according to the header information.

### DIRECTORY_UNARCHIVER
`DIRECTORY_UNARCHIVER` accepts all headers that have the directory typeflag ('5'). It will create a new directory and try to set the metadata according to the header.

### SKIP_UNARCHIVER
`SKIP_UNARCHIVER` accepts all headers and skips their payload without doing anything. It is used as a fallback by `ARCHIVE`.

### Usage
Most often the user will use `UNARCHIVER` with `ARCHIVE`, this section shortly explains, how to properly use it otherwise:

1. Check whether whether the payload to header can be unarchive using `unarchivable`
2. Initialize with header (`initialize`)
3. If `unarchiving_finished` or `has_error` exit
4. Pass next block to unachiver, using `unarchive_block`, goto 3

### Implementing a Custom UNARCHIVER
To implement a custom `UNARCHIVER`, one has to implement the following features. Additionally one can find some custom `UNARCHIVER`s in the example directory (minipax's `HEADER_SAVE_UNARCHIVER` and tar_ls' `HEADER_PRINT_UNARCHIVER`). All features from [TAR_UTILS](TAR_UTILS.md) can be used. Additionally every `UNARCHIVER` inherits from `ERROR_HANDLER` which makes it easy to report errors (compare [ERROR](ERROR.md)).

#### Creation Procedures
Every `UNARCHIVER` should redefine `default_create`. Remember to call `Precursor` to initialize all inherited stuff (e.g. the things from `ERROR_HANDLER`). Additionally one has to set the attribute `name` to a fitting value (e.g. "file to memory unarchiver" for an unarchiver that unarchives files to memory). `name` will be used when cascading errors to `ARCHVIVE`.

Every creation procedure has to call `default_create` (or is `default_create` itself).

#### required_blocks
`required_blocks: INTEGER`

Has to return the number of blocks that are required to unarchive the payload that belongs to this header.

#### unarchivable
`unarchivable (a_header: TAR_HEADER): BOOLEAN`

Indicates whether `a_header` can be unarchived by this `UNARCHIVER`. This is the function, `ARCHIVABLE` uses to determine, which `UNARCHIVER` to use.

#### unarchive_block
`unarchive_block (a_block: MANAGED_POINTER; a_pos: INTEGER)`

Takes a block and unarchives its contents. The blocks starts at `a_pos`. This feature unarchives at most `{TAR_CONST}.tar_block_size` bytes. It has to increase `unarchived_blocks` by one.

#### do_internal_initialization
`do_internal_initialization`

Initialize internal structures (only the new ones). It is called by `initialize`.

***
**[Back to the index](../index.md)**

