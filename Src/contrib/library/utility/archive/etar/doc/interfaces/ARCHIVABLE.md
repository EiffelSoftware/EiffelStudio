**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

Everything that one wants to archive has to inherit from `ARCHIVABLE`, which provides an interface that `ARCHIVE` uses to write it. The etar library provides two predefined implementations.

### FILE_ARCHIVABLE
`FILE_ARCHIVABLE` allows to archive plain files. A client has to provide a `FILE` for which the `FILE_ARCHIVABLE` will be created.

### DIRECTORY_ARCHIVABLE
`DIRECTORY_ARCHIVABLE` allows to archive a directory (without any contents). On creation, the client has to provide a `FILE` (!) for which `is_directory` holds.

### Implementing a Custom ARCHIVABLE
To implement a custom `ARCHIVABLE`, one has to implement the following features. All features from [TAR_UTILS](TAR_UTILS.md) can be used. Please note that `ARCHIVABLE`s are not supposed to report errors.

#### Creation Procedures
There is nothing to consider for creation procedures.

#### required_blocks
`required_blocks: INTEGER`

Has to return how many blocks are needed to archive the payload. At least 0.

#### header
`header: TAR_HEADER`

Has to return a `TAR_HEADER` suitable for the archivable type and the payload.

#### write_block_to_managed_pointer
`write_block_to_managed_pointer (p: MANAGED_POINTER; a_pos: INTEGER)`

Has to write the next block to `p` (writing should start at position `a_pos`). This feature has to increate `written_blocks` by one. In case the payload does not fill a whole block, it has to be padded to full block size (`{TAR_CONST}.tar_block_size`), you might want to use `TAR_UTILS.pad_block` for this.

***
**[Back to the index](../index.md)**

