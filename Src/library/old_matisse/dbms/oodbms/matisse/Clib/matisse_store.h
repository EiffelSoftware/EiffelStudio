/*
	Matisse_store.h

	This file is needed to create a translation table to have a set of applications
	that will use the same dynamic type of a same object even if the applications have
	not been compiled with the same dynamic type

*/

#ifndef _matisse_store_h_
#define _matisse_store_h_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>

#ifndef NULL
#define NULL 0
#endif

#include "eif_globals.h"
#include "eif_malloc.h"				/* For macros HEADER */
#include "eif_garcol.h"				/* For flags manipulation */

/* Different kinds of storage */
/* Internal representation of the different kinds of storage */

#define BASIC_STORE '\0'
#define GENERAL_STORE '\01'
#define INDEPENDENT_STORE '\02'

extern void create_translation_table(FILE *s_file);	/* Create the file which contains the old_dtype_to_current */
extern void read_translation_table(FILE *r_file);		/* Read the old_dtype_to_current forn a file */
extern int *access_current_table (void);			/* return the current_to_old_dtype address */
extern int *access_old_table (void);				/* return the old_dtype_to_current address */

extern void display ();		/* display function */

#ifdef __cplusplus
extern "C" }
#endif

#endif /* _matisse_store_h_ */
