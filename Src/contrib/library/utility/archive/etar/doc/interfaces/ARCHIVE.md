**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

### Initialization

To create a new instance of the `ARCHIVE` class, the client has to use the `make` feature and provide a `STORAGE_BACKEND`, which will then be used to do I/O (reading and writing blocks). A client then can either open the archive for archiving or for unarchiving. It is not possible to archive and unarchive simultaneously.

### Archiving

To use the archiving mode, one has to use `open_archive` after creation. Then, one can add entries using `add_entries`. Once all entries are written, the user has to call `finalize`, which will cause the archive to write the end of archive indicator and then close itself.

All entries are children of [ARCHIVABLE](ARCHIVABLE.md), for details about provided `ARCHIVABLE`s and how to write your own compare the linked page. 

### Unarchiving

To use the unarchiving mode, the user may first register arbitrarily many `UNARCHIVER`s using `add_unarchiver`. Once all of them were added, `open_unarchive` opens the archive for unarchiving. Note that once the archive is opened, no more `UNARCHIVER`s can be added. Next, the client may either use `unarchive`, which will then unarchive all entries at once and close the archive, or he can use `unarchive_next_entry`, until `unarchiving_finished` becomes `True`. In the latter case, the client has to close the archive himself by calling `close`. For each entry, `ARCHIVE` will use the *last* registered `UNARCHIVER` that is suitable for the corresponding entry (for further information and details about implementing your own `UNARCHIVER` see [UNARCHIVER](UNARCHIVER.md)).

### Errors
As `ARCHIVE` inherits from `ERROR_HANDLER`, it's pretty easy to register error callbacks as described in [ERROR](ERROR.md)

***
**[Back to the index](../index.md)**

