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

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"
#include "eif_globals.h"


#define xcalloc	eif_rt_xcalloc
#define xmalloc	eif_rt_xmalloc
#define xfree	eif_rt_xfree

/*
 * Use MT safe malloc functions.
 */

#ifdef EIF_THREADS
#undef HAS_SMART_MMAP
#undef HAS_SMART_SBRK
#undef HAS_SBRK
#endif	/* EIF_THREADS */


/*
 * Useful shortcuts for accessing fields.
 */
#define ov_next		ov_head.ovu.ovu_next
#define ov_flags	ov_head.ovu.ovu_flags
#define ov_fwd		ov_head.ovu.ovu_fwd
#define ov_size		ov_head.ovs_size
#ifdef EIF_TID
#define ovs_tid     ov_head.ovs_tid
#endif /* EIF_TID */
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
 * Chunk's types and size.
 */
#define C_T			0				/* Chunk mainly holds C blocks */
#define EIFFEL_T	1				/* Chunk mainly holds Eiffel blocks */
#define ALL_T		2				/* Any chunk, used by full_coalesc() */
#define CHUNK_SZ_MIN	8192		/* Minimum chunk size. */

#ifdef VXWORKS
#define CHUNK_DEFAULT	8192		/* standard chunk (in VxWorks case) */
#else
#define CHUNK_DEFAULT	262144		/* Number of bytes in standard chunk */
#endif

/* Memory block types (for allocate_from_core)
 */
#define MB_EO		0				/* Memory block for regular Eiffel object */
#define MB_CHUNK	1				/* Memory block for big memory chunk */

/*
 * Private macros used by low-level routines.
 */
#define OVERHEAD	sizeof(union overhead)			/* Malloc overhead */
#define HEADER(p)	(((union overhead *) (p))-1)	/* Fetch header address */
#define GC_FREE		2				/* Garbage collector takes care of free */
#define GC_ON		1				/* Garbage collector is on */
#define GC_OFF		0				/* Garbage collector is off */

/*
 * Type of requests for meminfo().
 */
#define M_FULL		0				/* Ask for general statistics */
#define M_EIFFEL	1				/* Ask for Eiffel chunk statistics */
#define M_C			2				/* Ask for C chunk statistics */

/*
 * Generation scavenging parameters
 */
#define GS_LIMIT		512		/* Maximun size for allocation in scavenge zone. */
#ifdef VXWORKS
#define	GS_SZ_MIN	2*PAGESIZE_VALUE
#else
#define GS_SZ_MIN	8192	/* Minimum size for generational 
							 * scavenge zone. */
#endif	/* VXWORKS */

#endif	/* VXWORKS */
#ifdef VXWORKS
#define GS_ZONE_SZ_DEFAULT	2*PAGESIZE_VALUE
#else
#ifdef EIF_STRING_OPTIMIZATION
#define GS_ZONE_SZ_DEFAULT	2097152	/* Size of a scavenge zone (2MB) */
#else	/* EIF_STRING_OPTIMIZATION */
#define GS_ZONE_SZ_DEFAULT 307200	/* Size is 300K by default. */
#endif	/* EIF_STRING_OPTIMIZATION */
#endif	/* VXWORKS */
#define GS_FLOATMARK ((eif_scavenge_size >> 2) + \
					  (eif_scavenge_size >> 3) + \
					  (eif_scavenge_size >> 5))	/* Leave that much free, this is
												 * equal to x * 0.40625
												 * We are doing this to improve the 
												 * preformance of the computation */
#define GS_WATERMARK (eif_scavenge_size - 1024)	/* Collect to be run after this */

/*
 * Functions return type.
 */
RT_LNK EIF_REFERENCE emalloc(uint32 type);				/* Allocate an Eiffel object */
RT_LNK EIF_REFERENCE spmalloc(unsigned int nbytes);			/* Allocate an Eiffel special object */
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
 * Global variables, not in a per thread basis.
 */

extern int	eif_scavenge_size;				/* Size of GSZ. */
extern int	eif_tenure_max;					/* Maximum tenuring age. */
extern int	eif_gs_limit;					/* Maximum size of object in GSZ. */
extern int	eif_chunk_size;					/* Size of chunk. */


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
rt_shared EIF_REFERENCE eif_set(EIF_REFERENCE object, unsigned int nbytes, uint32 type);				/* Set Eiffel object prior use */

#ifdef __cplusplus
}
#endif

#endif
