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

#define xcalloc		eif_rt_xcalloc
#define xmalloc		eif_rt_xmalloc
#define xfree		eif_rt_xfree
#define split_block	eif_rt_split_block

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
RT_LNK EIF_REFERENCE bmalloc(long int size);			/* Bit object creation */
RT_LNK EIF_REFERENCE spmalloc(unsigned int nbytes, EIF_BOOLEAN atomic);			/* Allocate an Eiffel special object */

RT_LNK EIF_REFERENCE strmalloc(unsigned int nbytes);		/* Allocate a string. */
extern EIF_REFERENCE eif_strset(EIF_REFERENCE object, unsigned int nbytes);
						/* Set the string header. */
RT_LNK EIF_REFERENCE cmalloc(unsigned int nbytes);				/* Allocate a C object */
extern EIF_REFERENCE gmalloc(unsigned int nbytes);				/* Garbage collector's allocation */
extern EIF_REFERENCE xmalloc(unsigned int nbytes, int type, int gc_flag);				/* Low level allocation routine */
extern EIF_REFERENCE xcalloc(unsigned int nelem, unsigned int elsize);				/* Calloc */
extern void xfree(register EIF_REFERENCE ptr);				/* Free */
extern void xfreechunk(EIF_REFERENCE ptr);					/* Free memory chunks */
extern char *crealloc(char *ptr, unsigned int nbytes);			/* Reallocate a C object */
extern EIF_REFERENCE xrealloc(register EIF_REFERENCE ptr, register unsigned int nbytes, int gc_flag);			/* Reallocate with GC turned on/off */
RT_LNK EIF_REFERENCE sprealloc(EIF_REFERENCE ptr, long int nbitems);			/* Reallocate an Eiffel special object */
RT_LNK EIF_REFERENCE strrealloc(EIF_REFERENCE ptr, long int nbitems);			/* Reallocate an Eiffel special object */
extern struct emallinfo *meminfo(int type);	/* Memory statistics */



/*
 * Shared routines
 */
extern int split_block(register union overhead *selected, register uint32 nbytes);			/* Block spliting */
extern void lxtract(union overhead *next);				/* Extraction from free list */
extern void rel_core(void);				/* Give memory back to kernel */
extern int chunk_coalesc(struct chunk *c);			/* Coalescing to reduce fragmentation */
extern char *get_to_from_core(unsigned int nbytes);	/* Get to_space from core for partial scavenging */
extern void memck(unsigned int max_dt);

extern void mem_diagnose(int sig);			/* Memory usage dump */
extern int full_coalesc(int chunk_type);			/* Perform free blocks coalescing */
extern void sc_stop(void);

#ifdef __cplusplus
}
#endif

#endif
