/*

 #####   ######  #####  #####    #   ######  #    #  ######          #    #
 #    #  #         #    #    #   #   #       #    #  #               #    #
 #    #  #####     #    #    #   #   #####   #    #  #####           ######
 #####   #         #    #####    #   #       #    #  #        ###    #    #
 #   #   #         #    #   #    #   #        #  #   #        ###    #    #
 #    #  ######    #    #    #   #   ######    ##    ######   ###    #    #

	Declarations for retrieve mechanism.

*/

#ifndef _eif_retrieve_h_
#define _eif_retrieve_h_

#include <stdio.h>
#include "eif_globals.h"
#include "eif_hashin.h"
#include "eif_cecil.h"

#ifdef __cplusplus
extern "C" {
#endif
 
#define SOLVED 		1		/* Flag for solved reference in a rt_struct struture */
#define UNSOLVED	0		/* ........ an unsolved ............................ */

/* Internal representation of the different kinds of storage */
#define BASIC_STORE '\0'
#define GENERAL_STORE '\01'
#define INDEPENDENT_STORE '\02'

/* Setting of `eif_discard_pointer_values' */
#define eif_set_discard_pointer_values(v)	eif_discard_pointer_values = (EIF_BOOLEAN) (v)

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
		EIF_OBJECT rtu_obj;			/* Solved hector reference */
		struct rt_cell  *rtu_cell;	/* Unsolved references descriptions */
	} rtu_data; 
};

#define rt_list 	rtu_data.rtu_cell
#define rt_obj		rtu_data.rtu_obj

/*
 * Eiffel calls
 */
RT_LNK char *eretrieve(EIF_INTEGER file_desc);		/* Retrieve object store in file */
RT_LNK EIF_REFERENCE stream_eretrieve(char **, long, long, EIF_INTEGER *);	/* Retrieve object store in stream */
RT_LNK char *portable_retrieve(int (*char_read_function)(char *, int));


/*
 * Utilities
 */

extern char *rt_make(void);			/* Retrieve object graph */
extern char *rt_nmake(EIF_CONTEXT long int objectCount);		/* Retrieve `n' objects */
extern struct htable *rt_table;	/* Table used for solving references */
extern int32 nb_recorded;		/* Number of items recorded in Hector */
extern char rt_kind;
RT_LNK EIF_BOOLEAN eif_discard_pointer_values;	/* Do we need to store pointers or not? */

extern int old_retrieve_read(void);
extern int retrieve_read(void);

extern int old_retrieve_read_with_compression(void);
extern int retrieve_read_with_compression(void);

extern void rt_init_retrieve(int (*retrieve_function) (void), int (*char_read_function)(char *, int), int buf_size);
extern void rt_reset_retrieve(void);

extern int (*retrieve_read_func)(void);
extern int (*char_read_func)(char *, int);

#ifdef __cplusplus
}
#endif

#endif

