**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

`STORAGE_BACKEND` provides an unified interface for different storage methods an archive could use. Currently the only implementation is `FILE_STORAGE_BACKEND`, but one could add support for in-memory archives or compressed files as well.

### FILE_STOARGE_BACKEND
This class provides support for archives that are stored on disk. A `FILE_STROAGE_BACKEND` intance is either created with `make_from_file` (providing a `FILE`), with a filename using `make_from_filename`, or with a path using `make_from_path`. In case the referenced file does not exist, it will be created.

### Implementing a custom STORAGE_BACKEND
To implement a custom `STORAGE_BACKEND`, one has to implement the following features:

#### Creation procedures
If `default_create` is redefined, `Precursor` must be called. Every other creation procedure should call `default_create`.

#### open_read
`open_read`

Open backend for read access. Reading should start from the beginning of the backend.

#### open_write
`open_write`

Open backend for write access. Writing should start from the beginning of the backend.

#### close
`close`

Close backend

#### archive_finished
`archive_finished: BOOLEAN`

Indicate whether the next two blocks contain the end of archive indicator (only zero bytes). Subsequent `read_block` calls should not skip these two blocks, but read them again (not necessarily from from the backend again, the implementation is free to cache the blocks). If an error occured (or occurs while checking for the end of archive indicator), there are not enough blocks available or the backend is closed, `archive_finished` should return `True` as well.

#### block_ready
`block_ready: BOOLEAN`

Indicate whether there is a block available in `last_block`. If an error occured this should be `False`.

#### readable
`readable: BOOLEAN`

Indicates whether this backend can be read from. On error this has to return `False`.

#### writable
`writable: BOOLEAN`

Indicates whether this backend can be written to. On error this has to return `False`.

#### closed
`closed: BOOLEAN`

Indicates whether this backend is closed.

#### read_block
`read_block`

Read next block from backend. If there are not enough bytes for a full block, an error should be reported.

#### last_block
`last_block: MANAGED_POINTER`

Last block that was read. This block has to be of size `{TAR_CONST}.tar_block_size`.

#### write_block
`write_block (a_block: MANAGED_POINTER; a_pos: INTEGER)`

Write `a_block` to backend (starting at index `a_pos` of `a_block`).

#### finalize
`finalize`

Write end of archive indicator (two consecutive blocks of all zero bytes) and close backend.

***
**[Back to the index](../index.md)**

