/*

 #    #    ##    #       #        ####    ####           #    #
 ##  ##   #  #   #       #       #    #  #    #          #    #
 # ## #  #    #  #       #       #    #  #               ######
 #    #  ######  #       #       #    #  #        ###    #    #
 #    #  #    #  #       #       #    #  #    #   ###    #    #
 #    #  #    #  ######  ######   ####    ####    ###    #    #

	Declarations for malloc routines
*/

#ifndef _eif_malloc_h_
#define _eif_malloc_h_

#include "eif_portable.h"
#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Documentation shows that mmap, and sbrk are 
 * incompatible with parallel use of standard malloc 
 * functions.
 */

#undef HAS_SMART_MMAP
#undef HAS_SMART_SBRK
#undef HAS_SBRK

/*
 * Useful shortcuts for accessing fields.
 */
#define ov_next		ov_head.ovu.ovu_next
#define ov_flags	ov_head.ovu.ovu_flags
#define ov_fwd		ov_head.ovu.ovu_fwd
#define ov_size		ov_head.ovs_size
#ifdef EIF_TID
#define ovs_tid     ov_head.ovs_tid
#endif

/*
 * Masks used on the ovs_size field.
 */
#define B_SIZE		0x07ffffff			/* Get the size of the block */
#define B_BUSY		0x80000000			/* Block is not free */
#define B_C			0x40000000			/* Block is a C block */
#define B_LAST		0x20000000			/* Block is the last one in chunk */
#define B_FWD		0x10000000			/* Forwarded Eiffel object */
#define B_CTYPE		0x08000000			/* Block belongs to a C type chunk */
#define B_NEW		(B_BUSY | B_C)		/* For newly created blocks */

/*
 * Object access low-level routines.
 */
#define OVERHEAD	sizeof(union overhead)			/* Malloc overhead */
#define HEADER(p)	(((union overhead *) (p))-1)	/* Fetch header address */


/*
 * Functions return type.
 */
RT_LNK EIF_REFERENCE emalloc(uint32 type);				/* Allocate an Eiffel object */
RT_LNK EIF_REFERENCE emalloc_size(uint32 ftype, uint32 dtype, uint32 size);	/* Allocate an Eiffel object */
RT_LNK EIF_REFERENCE bmalloc(long int size);			/* Bit object creation */
RT_LNK EIF_REFERENCE tuple_malloc (uint32 ftype);	/* Allocated tuple object */
RT_LNK EIF_REFERENCE tuple_malloc_specific (uint32 ftype, uint32 count, EIF_BOOLEAN atomic);	/* Allocated tuple object */
RT_LNK EIF_REFERENCE smart_emalloc (uint32 ftype);
RT_LNK EIF_REFERENCE spmalloc(unsigned int nbytes, EIF_BOOLEAN atomic);			/* Allocate an Eiffel special object */
RT_LNK void sp_init (EIF_REFERENCE obj, uint32 dftype, EIF_INTEGER lower, EIF_INTEGER upper);	/* Initialize special object of expanded */

RT_LNK EIF_REFERENCE strmalloc(unsigned int nbytes);		/* Allocate a string. */
						/* Set the string header. */
RT_LNK EIF_REFERENCE cmalloc(unsigned int nbytes);				/* Allocate a C object */
RT_LNK EIF_REFERENCE sprealloc(EIF_REFERENCE ptr, long int nbitems);			/* Reallocate an Eiffel special object */
RT_LNK EIF_REFERENCE strrealloc(EIF_REFERENCE ptr, long int nbitems);			/* Reallocate an Eiffel special object */


#ifdef __cplusplus
}
#endif

#endif
