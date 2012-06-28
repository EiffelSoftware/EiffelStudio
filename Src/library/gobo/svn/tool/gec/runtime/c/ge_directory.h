/*
	description:

		"C functions used to implement class DIRECTORY"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2005, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_DIRECTORY_H
#define GE_DIRECTORY_H

#ifdef __cplusplus
extern "C" {
#endif

extern void* GE_directory_open_read(char* dirname);
extern void* GE_directory_read_entry(void* dir);
extern char* GE_directory_last_entry (void* dir);
extern int GE_directory_close (void* dir);

#ifdef __cplusplus
}
#endif

#endif
