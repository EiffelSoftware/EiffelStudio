Welcome to the etar wiki!

Project page: https://github.com/eiffelhub/etar

### Introduction
The etar library was developed as a project within the scope of the course "Software Engineering Laboratory: Open-Source EiffelStudio" at ETH Zurich, attended by Nicolas Trüssel and supervised by Jocelyn Fiat. The goal of the project was to add archiving support to the Eiffel programming language through a library. During the initial project discussion it was then decided to use the tar archive format and that the library should be written in pure Eiffel (no wrapping of existing solutions). The etar library was written and designed from scratch, since I (Nicolas Trüssel) did not find any existing archiving solutions for Eiffel.

### Functionality
etar supports creating and extracting archives using tar-family formats. Currently the ustar and pax archive formats are supported (specification linked below) and only plain files and directories can be added/extracted. Additionally the only storage possibility is an uncompressed file on disk.

However, etar was designed to be as extensible as possible, allowing both contributors and users to add support for new archive formats, payload types (e.g. symlinks and hardlinks), and storage backends (e.g. in-memory, compressed files) quite easily. For further information check the pages [ARCHIVABLE](interfaces/ARCHIVABLE.md) and [UNARCHIVER](interfaces/UNARCHIVER.md) for new payload types,  [TAR_HEADER_PARSER](interfaces/TAR_HEADER_PARSER.md) and [TAR_HEADER_WRITER](interfaces/TAR_HEADER_WRITER.md) for new archive formats, and [STORAGE_BACKEND](interfaces/STORAGE_BACKEND.md) for new storage possibilities.

### Documentation
Use the [Index](index.md) to easily navigate to different topics. 
A good starting point would be [Getting Started](Getting-Started.md) or [ARCHIVE](interfaces/ARCHIVE.md). 
[General Information about Archives](General-Information-about-Archives.md) and [Header Formats](Header-Formats.md) contains more background information, in case you want to learn more about tar in general.

Topics:
* [General Information about Archives](General-Information-about-Archives.md)
* [Header Formats](Header-Formats.md)
* [Getting Started](Getting-Started.md)
* [Interfaces](interfaces/README.md)

### Issues
- Improve test coverage
- Improve test style:
  Currently most tests nearly have the same code, so there is a lot of code duplication within the testcases.
- `ARCHIVABLE` tests use machine dependent metadata:
  Tests for `DIRECTORY_ARCHIVABLE` and `FILE_ARCHIVABLE` use hard-coded metadata which causes them to fail if cloned from GitHub and executed on different machines than the one the tests were written on.
- Unicode support is not fully tested.
-  `USTAR_HEADER_WRITER` allows UTF-8 strings (as opposed to [ISO/IEC 646:1991](https://en.wikipedia.org/wiki/ISO/IEC_646) only).
- Metadata restoring uses uid -> username lookup instead of username -> uid. There is a partial solution to this problem on the branch [externals](../../../tree/externals), but it only compiles on machines that have the `pwd.h` and `grp.h` headers (in particular it does not compile on Windows).
- When an archive named archive.tar contains an entry of a file named archive.tar and minipax is used to extract this file, the archive file is overwritten with the archived version (the entry) before it is fully extracted and therefore only parts of the original file are extracted.
  
### Future Work
Possible library extensions could be:
- Add append mode to `ARCHIVE` that allows to append new entries to an existing archive.
- Add support for more entry types (like links, sockets ...)
- Add more storage backends (e.g. compressed files, in-memory ...)

In case you want to work on some of these proposals (or something different) feel free to add an issue and/or submit PR.

### Resources
- pax specification: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html

