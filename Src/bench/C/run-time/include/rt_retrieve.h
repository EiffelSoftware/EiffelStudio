/*

 #####   ######  #####  #####    #   ######  #    #  ######          #    #
 #    #  #         #    #    #   #   #       #    #  #               #    #
 #    #  #####     #    #    #   #   #####   #    #  #####           ######
 #####   #         #    #####    #   #       #    #  #        ###    #    #
 #   #   #         #    #   #    #   #        #  #   #        ###    #    #
 #    #  ######    #    #    #   #   ######    ##    ######   ###    #    #

	Declarations for retrieve mechanism.

*/

#ifndef _rt_retrieve_h_
#define _rt_retrieve_h_

#include "eif_retrieve.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * In case of an unsolved reference, a structure rt_cell contain the
 * description of it, i.e the key in the hash table where the parent 
 * object is plus the offset where the unsolved reference is.
 */
typedef enum {RTU_KEYED, RTU_INDIRECTION} rt_unsolved_t;
struct rt_cell {
	struct rt_cell *next;
	long offset;
	rt_unsolved_t status;
	union {
		unsigned long key;		/* key of SOLVED record when `status' == RTU_KEYED */
		EIF_OBJECT rtu_obj;		/* hector reference when `status' == RTU_INDIRECTION */
	} u;
};

/*
 * Item structure of the hash table used for solving ahead references
 */	
typedef enum {UNSOLVED, SOLVED, DROPPED} rt_status_t;
struct rt_struct {
	rt_status_t rt_status;			/* Is the reference solved or not ? */
	union {
		EIF_OBJECT rtu_obj;			/* status=SOLVED:   Hector reference */
		struct rt_cell  *rtu_cell;	/* status=UNSOLVED: Detail about location to change */
		int16 old_type;				/* status=DROPPED:  Type not in current system */
	} rtu_data; 
};

#define rt_list 	rtu_data.rtu_cell
#define rt_obj		rtu_data.rtu_obj


extern EIF_REFERENCE ise_compiler_retrieve (EIF_INTEGER f_desc, EIF_INTEGER a_pos, int (*ret_func) (void));

extern struct htable *rt_table;	/* Table used for solving references */
extern int32 nb_recorded;		/* Number of items recorded in Hector */
extern char rt_kind;
extern char rt_kind_version;
extern int end_of_buffer;

extern int (*retrieve_read_func)(void);

/*
 * Utilities
 */

extern char *rt_make(void);			/* Retrieve object graph */
extern char *rt_nmake(EIF_CONTEXT long int objectCount);		/* Retrieve `n' objects */

extern int old_retrieve_read(void);
extern int retrieve_read(void);

extern int old_retrieve_read_with_compression(void);
extern int retrieve_read_with_compression(void);

extern void rt_init_retrieve(int (*retrieve_function) (void), int (*char_read_function)(char *, int), int buf_size);
extern void rt_reset_retrieve(void);

extern int (*char_read_func)(char *, int);


#ifdef __cplusplus
}
#endif

#endif
