/*

 #    #    ##    #       #        ####    ####           #    #
 ##  ##   #  #   #       #       #    #  #    #          #    #
 # ## #  #    #  #       #       #    #  #               ######
 #    #  ######  #       #       #    #  #        ###    #    #
 #    #  #    #  #       #       #    #  #    #   ###    #    #
 #    #  #    #  ######  ######   ####    ####    ###    #    #

	Declarations for malloc routines
*/

#ifndef _malloc_h_
#define _malloc_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "portable.h"

/*
 * General information structure.
 */
struct emallinfo {
	int ml_chunk;			/* Number of chunks */
	long ml_total;			/* Total space used by malloc */
	long ml_used;			/* Real space used, in bytes */
	long ml_over;			/* Overhead space, in bytes */
};

/*
 * Structure at the beginning of each big chunk. A chunk usually
 * holds more than one Eiffel object. They are linked together
 * in a double linked list.
 */
struct chunk {
	int32 ck_type;			/* Chunk's type */
	struct chunk *ck_next;	/* Next chunk in list */
	struct chunk *ck_prev;	/* Previous chunk in list */
	struct chunk *ck_lnext;	/* Next chunk of same type */
	struct chunk *ck_lprev;	/* Previous chunk of same type */
	int32 ck_length;		/* Length of block (w/o size of this struct) */
							/* int's are split around the chunk pointers */
							/*to provide correct padding for 64 bit machines*/
#if MEM_ALIGNBYTES > 8
	double ck_padding;		/* Alignment restrictions */
#endif
};

/* The following structure records the head and the tail of the
 * chunk list (blocks obtained via the sbrk() system call). The
 * list is useful when doing garbage collection, because it is
 * the only way we can walk through all the objects (using the
 * ov_size field and its flags).
 */
struct ck_list {
	struct chunk *ck_head;		/* Head of list */
	struct chunk *ck_tail;		/* Tail of list */
	struct chunk *cck_head;		/* Head of C list */
	struct chunk *cck_tail;		/* Tail of C list */
	struct chunk *eck_head;		/* Head of Eiffel list */
	struct chunk *eck_tail;		/* Tail of Eiffel list */
};

/* Description of a scavenging space */
struct sc_zone {
	int sc_size;				/* Space's size (in bytes) */
	char *sc_arena;				/* Base address of zone */
	char *sc_top;				/* Pointer to first free location */
	char *sc_mark;				/* Water-mark level */
	char *sc_end;				/* First location beyond space */
	uint32 sc_flgs;				/* ov_size in the selected malloc block */
};

/* Overhead for each memory segment allocated. All these objects
 * are linked by size when they are free. This link field is used
 * by Eiffel objects to store some flags. One bit is used to indicate
 * C objects, so the garbage collector will skip them. Another field
 * is used to store the size of the block. Only the lowest 27 bits are
 * used (thus limiting the size of an object to 2^27 bytes). The upper
 * 5 bits are used to store the status of the blocks. See below.
 */
union overhead {
	struct {
		union {
			union overhead *ovu_next;	/* Next block with same size */
			uint32 ovu_flags;			/* Eiffel flags */
			char *ovu_fwd;				/* Forwarding pointer */
		} ovu;
		uint32 ovs_size;				/* Size of block, plus flags */
	} ov_head;
#if MEM_ALIGNBYTES > 8
	double ov_padding;					/* Alignment restrictions */
#endif
};

/*
 * Useful shortcuts for accessing fields.
 */
#define ov_next		ov_head.ovu.ovu_next
#define ov_flags	ov_head.ovu.ovu_flags
#define ov_fwd		ov_head.ovu.ovu_fwd
#define ov_size		ov_head.ovs_size

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
#define CHUNK		65536			/* Number of bytes in standard chunk */

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
#define GS_LIMIT		100		/* Max size for allocation in scavenge zone */
#define GS_ZONE_SZ		153600	/* Size of a scavenge zone (150K) */
#define GS_FLOATMARK	(GS_ZONE_SZ * .40)	/* Leave that much free */
#define GS_WATERMARK	(GS_ZONE_SZ - 1024)	/* Collect to be run after this */

/*
 * Functions return type.
 */
extern char *emalloc(uint32 type);				/* Allocate an Eiffel object */
extern char *spmalloc(unsigned int nbytes);			/* Allocate an Eiffel special object */
extern char *cmalloc(unsigned int nbytes);				/* Allocate a C object */
extern char *gmalloc(unsigned int nbytes);				/* Garbage collector's allocation */
extern char *xmalloc(unsigned int nbytes, int type, int gc_flag);				/* Low level allocation routine */
extern char *xcalloc(unsigned int nelem, unsigned int elsize);				/* Calloc */
extern void xfree(register char *ptr);				/* Free */
extern void xfreechunk(char *ptr);					/* Free memory chunks */
extern char *crealloc(char *ptr, unsigned int nbytes);			/* Reallocate a C object */
extern char *xrealloc(register char *ptr, register unsigned int nbytes, int gc_flag);			/* Reallocate with GC turned on/off */
extern char *sprealloc(char *ptr, long int nbitems);			/* Reallocate an Eiffel special object */
extern struct emallinfo *meminfo(int type);	/* Memory statistics */

/*
 * Shared variables
 */
extern struct emallinfo m_data;		/* Accounting info from malloc */
extern struct emallinfo c_data;		/* Accounting info from malloc for C */
extern struct emallinfo e_data;		/* Accounting info from malloc for Eiffel */
extern struct ck_list cklst;		/* Head and tail of chunck list */
extern uint32 gen_scavenge;			/* Is Generation Scavenging running ? */
extern struct sc_zone sc_from;		/* Scavenging 'from' zone */
extern struct sc_zone sc_to;		/* Scavenging 'to' zone */
extern struct stack hec_stack;		/* The hector stack (objects seen from C) */
extern long eiffel_usage;			/* For memory statistics */

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
rt_shared char *eif_set(char *object, unsigned int nbytes, uint32 type);				/* Set Eiffel object prior use */

#ifndef TEST
extern int cc_for_speed;			/* Priority to speed or memory? */
#endif

#ifdef __cplusplus
}
#endif

#endif
