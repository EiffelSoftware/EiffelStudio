/*

 ######     #    ######           #####   #   #  #####   ######   ####		   #    #
 #          #    #                  #      # #   #    #  #       #			   #    #
 #####      #    #####              #       #    #    #  #####    ####		   ######
 #          #    #                  #       #    #####   #            #   ###  #    #
 #          #    #                  #       #    #       #       #    #   ###  #    #
 ######     #    #      #######     #       #    #       ######   ####    ###  #    #

	Structures and types defining global variables.

 */

#ifndef _eif_types_h_
#define _eif_types_h_

#include "eif_constants.h"

	/* except.h */
/* Structure used as the execution vector. This is for both the execution
 * stack (eif_stack) and the exception trace stack (eif_trace).
 */
struct ex_vect {
	unsigned char ex_type;		/* Function call, pre-condition, etc... */
	unsigned char ex_retry;		/* True if function has been retried */
	unsigned char ex_rescue;	/* True if function entered its rescue clause */
	union {
		unsigned int exu_lvl;	/* Level for multi-branch backtracking */
		int exu_sig;			/* Signal number */
		int exu_errno;			/* Error number reported by kernel */
		struct {
			char *exua_name;	/* The assertion tag */
			char *exua_where;	/* The routine name where assertion was found */
			int exua_from;		/* And its origin (where it was written) */
			char *exua_oid;		/* Object ID (value of Current) */
		} exua;					/* Used by assertions */
		struct {
			char *exur_jbuf;	/* Execution buffer address, null if none */
			char *exur_id;		/* Object ID (value of Current) */
			char *exur_rout;	/* The routine name */
			int exur_orig;		/* Origin of the routine */
		} exur;					/* Used by routines */
	} exu;
};

/*
 * Stack used by the exception vector of each routine. It is implemented
 * with small chunks linked together. These structure look like the one used
 * by the garbage collector, only the type of the items stored changes...
 */
struct stxchunk {
	struct stxchunk *sk_next;	/* Next chunk in stack */
	struct stxchunk *sk_prev;	/* Previous chunk in stack */
	struct ex_vect *sk_arena;	/* Arena where objects are stored */
	struct ex_vect *sk_end;		/* Pointer to first element beyond the chunk */
};

struct xstack {
	struct stxchunk *st_hd;		/* Head of chunk list */
	struct stxchunk *st_tl;		/* Tail of chunk list */
	struct stxchunk *st_cur;	/* Current chunk in use (where top is) */
	struct ex_vect *st_top;		/* Top in chunk (pointer to next free item) */
	struct ex_vect *st_end;		/* Pointer to first element beyond chunk */
	struct ex_vect *st_bot;		/* Bottom of stack (for eif_trace only) */
};

/* Structure used while printing the exception trace stack. It is built using
 * some look-ahead inside the stack.
 */
struct exprint {
	unsigned char retried;	/* Routine has been retried */
	unsigned char rescued;	/* Routine entered in a rescue clause */
	unsigned char code;		/* Exception code */
	unsigned char last;		/* The very last exception record */
	unsigned char previous;	/* Previous exception code printed */
	char *rname;			/* Routine name of enclosing call */
	char *tag;				/* Exception tag of current exception */
	char *obj_id;			/* Object's ID */
	int from;				/* Where the routine comes from */
};

/* Improved string structure (with number of bytes used and length)
 * for the exception trace string 
 */
typedef struct _smart_string {
	char *area;		/* Pointer to zone where data is stored */
	long used;		/* Number of bytes actually used */
	long size;		/* Length of the area */
} SMART_STRING;


	/* ----------------------------------------------------------------- */
	/*	interp.h */
	/* ----------------------------------------------------------------- */

	/* Stack data structures */
struct item {
	uint32 type;				/* Union's discriminent */
	union {
		char itu_char;			/* A character value */
		long itu_long;			/* An integer value */
		float itu_float;		/* A real value */
		double itu_double;		/* A double value */
		char *itu_ref;			/* A reference value */
		char *itu_bit;			/* A bit reference value */
		char *itu_ptr;			/* A routine pointer */
	} itu;
};

	/* Stack used by the interpreter (operational stack) */
struct opstack {
	struct stochunk *st_hd;		/* Head of chunk list */
	struct stochunk *st_tl;		/* Tail of chunk list */
	struct stochunk *st_cur;	/* Current chunk in use (where top is) */
	struct item *st_top;		/* Top (pointer to next free location) */
	struct item *st_end;		/* First element beyond current chunk */
};

struct stochunk {
	struct stochunk *sk_next;	/* Next chunk in stack */
	struct stochunk *sk_prev;	/* Previous chunk in stack */
	struct item *sk_arena;		/* Arena where objects are stored */
	struct item *sk_end;		/* Pointer to first element beyond the chunk */
};


	/* ----------------------------------------------------------------- */
	/*	malloc.h */
	/* ----------------------------------------------------------------- */

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


	/* ----------------------------------------------------------------- */
	/*	sig.h */
	/* ----------------------------------------------------------------- */

/* Structure used as FIFO stack for signal buffering. I really do not expect
 * this stack to overflow, so it has a huge fixed size--RAM. Should it really
 * overflow, we would panic immediately :-(.
 */
struct s_stack {
	int s_min;				/* Minimum value of circular buffer */
	int s_max;				/* Maximum value of circular buffer */
	char s_pending;			/* Are any signals pending? */
	char s_buf[SIGSTACK];	/* The circular buffer used as a FIFO stack */
};


#endif	 /* _eif_types_h */
