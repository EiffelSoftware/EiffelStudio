/*

 #    #    ##    #       #        ####    ####           #    #
 ##  ##   #  #   #       #       #    #  #    #          #    #
 # ## #  #    #  #       #       #    #  #               ######
 #    #  ######  #       #       #    #  #        ###    #    #
 #    #  #    #  #       #       #    #  #    #   ###    #    #
 #    #  #    #  ######  ######   ####    ####    ###    #    #

	Private declarations for malloc routines
*/

#ifndef _rt_malloc_h_
#define _rt_malloc_h_

#include "eif_malloc.h"

#ifdef __cplusplus
extern "C" {
#endif

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

/*
 * Type of requests for meminfo().
 */
#define M_FULL		0				/* Ask for general statistics */
#define M_EIFFEL	1				/* Ask for Eiffel chunk statistics */
#define M_C			2				/* Ask for C chunk statistics */

#define NBLOCKS			83		/* Number of block lists */

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

#ifdef VXWORKS
#define GS_ZONE_SZ_DEFAULT	2*PAGESIZE_VALUE
#else

#ifdef EIF_GSZ_ALLOC_OPTIMIZATION
#define GS_ZONE_SZ_DEFAULT	2097152	/* Size of a scavenge zone (2MB) */
#else
#define GS_ZONE_SZ_DEFAULT 307200	/* Size is 300K by default. */
#endif

#endif	/* VXWORKS */
#define GS_FLOATMARK ((eif_scavenge_size >> 2) + \
					  (eif_scavenge_size >> 3) + \
					  (eif_scavenge_size >> 5))	/* Leave that much free, this is
												 * equal to x * 0.40625
												 * We are doing this to improve the 
												 * preformance of the computation */
#define GS_WATERMARK (eif_scavenge_size - 1024)	/* Collect to be run after this */

/* Memory block types (for allocate_from_core)
 */
#define MB_EO		0				/* Memory block for regular Eiffel object */
#define MB_CHUNK	1				/* Memory block for big memory chunk */

/*
 * Private macros used by low-level routines.
 */
#define GC_FREE		2				/* Garbage collector takes care of free */
#define GC_ON		1				/* Garbage collector is on */
#define GC_OFF		0				/* Garbage collector is off */


/*
 * Global variables, not in a per thread basis.
 */

extern int	eif_scavenge_size;				/* Size of GSZ. */
extern int	eif_tenure_max;					/* Maximum tenuring age. */
extern int	eif_gs_limit;					/* Maximum size of object in GSZ. */
extern int	eif_stack_chunk;				/* Size of local stack chunk. */
extern int	eif_chunk_size;					/* Size of chunk. */

#ifdef ISE_GC
extern struct emallinfo m_data;		/* Accounting info from malloc */
extern struct emallinfo c_data;		/* Accounting info from malloc for C */
extern struct emallinfo e_data;		/* Accounting info from malloc for Eiffel */
extern struct ck_list cklst;		/* Head and tail of chunck list */
extern struct sc_zone sc_from;		/* Scavenging 'from' zone */
extern struct sc_zone sc_to;		/* Scavenging 'to' zone */
extern uint32 gen_scavenge;			/* Is Generation Scavenging running ? */
extern long eiffel_usage;			/* For memory statistics */
extern int eif_max_mem;				/* Maximum memory that can be allocated */
#endif /* ISE_GC */

#ifdef __cplusplus
}
#endif

#endif
