/*

 #####   ######   #####  #####      #    ######  #    #  ######          #    #
 #    #  #          #    #    #     #    #       #    #  #               #    #
 #    #  #####      #    #    #     #    #####   #    #  #####           ######
 #####   #          #    #####      #    #       #    #  #        ###    #    #
 #   #   #          #    #   #      #    #        #  #   #        ###    #    #
 #    #  ######     #    #    #     #    ######    ##    ######   ###    #    #

	Declarations for retrieve mechanism.

*/

#ifndef _retrieve_h_
#define _retrieve_h_

#ifdef __cplusplus
extern "C" {
#endif
 
#include <stdio.h>
#include "eif_globals.h"
#include "hashin.h"
#include "cecil.h"

#define SOLVED 		1		/* Flag for solved reference in a rt_struct struture */
#define UNSOLVED	0		/* ........ an unsolved ............................ */

/*
 * In case of an unsolved reference, a structure rt_cell contain the
 * description of it, i.e the key in the hash table where the parent 
 * object is plus the offset where the unsolved reference is.
 */
struct rt_cell {
	struct rt_cell *next;
	long offset;
	unsigned long key;
};

/*
 * Item structure of the hash table used for solving ahead references
 */	
struct rt_struct {
	int rt_status;					/* Is the reference solved or not ? */
	union {
		EIF_OBJ rtu_obj;			/* Solved hector reference */
		struct rt_cell  *rtu_cell;	/* Unsolved references descriptions */
	} rtu_data; 
};

#define rt_list 	rtu_data.rtu_cell
#define rt_obj		rtu_data.rtu_obj

/*
 * Eiffel calls
 */
extern char *eretrieve(EIF_INTEGER file_desc);		/* Retrieve object store in file */
extern char *portable_retrieve(EIF_INTEGER file_desc, int (*char_read_function)(char *, int));


/*
 * Utilities
 */
/* extern int r_fides; 	        /* File descriptor use for retrieve */ /* %%zs removed and inluded eif_globals.h */
extern char *rt_make(void);			/* Retrieve object graph */
extern char *rt_nmake(EIF_CONTEXT long int objectCount);		/* Retrieve `n' objects */
extern struct htable *rt_table;	/* Table used for solving references */
extern int32 nb_recorded;		/* Number of items recorded in Hector */
extern char rt_kind;

extern int old_retrieve_read(void);
extern int retrieve_read(void);

extern int old_retrieve_read_with_compression(void);
extern int retrieve_read_with_compression(void);

extern void rt_init_retrieve(int (*retrieve_function) (void), int (*char_read_function)(char *, int), int buf_size);
extern void rt_reset_retrieve(void);

extern int (*retrieve_read_func)();
extern int (*char_read_func)(char *, int);
extern int char_read(char *pointer, int size);


#ifdef __cplusplus
}
#endif

#endif

