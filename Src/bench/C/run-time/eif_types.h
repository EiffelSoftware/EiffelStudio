/*

 ######     #    ######
 #          #    #
 #####      #    #####
 #          #    #
 #          #    #
 ######     #    #      #######

 #####   #   #  #####   ######   ####           #    #
   #      # #   #    #  #       #               #    #
   #       #    #    #  #####    ####           ######
   #       #    #####   #            #   ###    #    #
   #       #    #       #       #    #   ###    #    #
   #       #    #       ######   ####    ###    #    #

	Structures and types defining global variables.
	All type definitions are concentrates here because we need
	to put them in a context when running multithreaded apps.

*/

#ifndef _eif_types_h_
#define _eif_types_h_

#include "eif_portable.h"
#include "eif_constants.h"
#ifdef EIF_TID
#include "eif_threads.h"
#endif	/* EIF_TID */
#ifdef EIF_THREADS
#include "eif_threads.h"
#endif
#include <setjmp.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Organized on a per-file basis - the following
 * definitions come from the mentioned files */

	/*-----------*/
	/*  debug.h  */
	/*-----------*/

/* Moved at end, because relies on many structures below */


	/*------------*/
	/*  except.h  */
	/*------------*/

/* Structure used as the execution vector. This is for both the execution
 * stack (eif_stack) and the exception trace stack (eif_trace).
 */
struct ex_vect {
	unsigned char	ex_type;	/* Function call, pre-condition, etc... */
	unsigned char	ex_retry;	/* True if function has been retried */
	unsigned char	ex_rescue;	/* True if function entered its rescue clause */
#ifdef WORKBENCH
	int				ex_linenum;	/* current line number (line number <=> breakpoint slot) */
	int 			ex_bodyid;	/* body id of the feature */
	unsigned char	ex_locnum;	/* number of local variables in the function */
	unsigned char	ex_argnum;	/* number of arguments of the function */
#endif
	union {
		unsigned int exu_lvl;	/* Level for multi-branch backtracking */
		int exu_sig;			/* Signal number */
		int exu_errno;			/* Error number reported by kernel */
		struct {
			char *exua_name;	/* The assertion tag */
			char *exua_where;	/* The routine name where assertion was found */
			int exua_from;		/* And its origin (where it was written) */
			EIF_REFERENCE exua_oid;		/* Value of Current */
		} exua;					/* Used by assertions */
		struct {
			jmp_buf *exur_jbuf;	/* Execution buffer address, null if none */
			EIF_REFERENCE exur_id;		/* Value of Current */
			char *exur_rout;	/* The routine name */
			int exur_orig;		/* Origin of the routine */
		} exur;					/* Used by routines */
	} exu;
};

/* same structure as above. used in a finalized EiffelStudio to retrieve information
 * about a debugged application (so with line number and so on, even if final mode
 */
struct debug_ex_vect {
	unsigned char	ex_type;	/* Function call, pre-condition, etc... */
	unsigned char	ex_retry;	/* True if function has been retried */
	unsigned char	ex_rescue;	/* True if function entered its rescue clause */

	int				dex_linenum;	/* current line number (line number <=> breakpoint slot) */
	int 			dex_bodyid;	/* body id of the feature */
	unsigned char	dex_locnum;	/* number of local variables in the function */
	unsigned char	dex_argnum;	/* number of arguments of the function */

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
			jmp_buf *exur_jbuf;	/* Execution buffer address, null if none */
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

/* Structure used to record general flags. These are the value to take into
 * account for the last exception that occurred, which might not be in the
 * stack yet if manually or system raised.
 */
struct eif_exception {
	unsigned char ex_val;	/* Exception code (raised) */
	unsigned char ex_nomem;	/* An "Out of memory" exception occurred */
	unsigned char ex_nsig;	/* Number of last signal received */
	unsigned int ex_level;	/* Exception level (rescue branches) */
	unsigned char ex_org;	/* Original exception at this level */
 	char *ex_tag;			/* Assertion tag */
	char *ex_otag;			/* Tag associated with original exception */
	char *ex_rt;			/* Routine associated with current exception */
	char *ex_ort;			/* Routine associated with original exception */
	int ex_class;			/* Class associated with current exception */
	int ex_oclass;			/* Class associated with original exception */
};


	/*------------*/
	/*	garcol.h  */
	/*------------*/

/*
 * General information structure.
 */
struct gacinfo {
	unsigned long nb_full;		/* Number of full GC collections */
	unsigned long nb_partial;	/* Number of partial collections */
	unsigned long mem_used;		/* State of memory after previous run */
	unsigned long mem_copied;	/* Amount of memory copied by the scavenging */
	unsigned long mem_move;		/* Size of the 'from' spaces */
	int gc_to;					/* Number of 'to' zone allocated for plsc */
	char status;				/* Describes the collecting status */
};

struct gacstat {
	long mem_used;			/* State of memory after previous run */
	long mem_collect;		/* Memory collected during previous run */
	long mem_avg;			/* Average memory collected in a cycle */
	long real_avg;			/* Average amount of real cs used by plsc() */
	long real_time;			/* Amount of real cs used by last plsc() */
	long real_iavg;			/* Average real time between two collections */
	long real_itime;		/* Real time between two collections */
	double cpu_avg;			/* Average amount of CPU used by plsc() */
	double sys_avg;			/* Average kernel time used by plsc() */
	double cpu_iavg;		/* Average CPU time between two collections */
	double sys_iavg;		/* Average kernel time between collections */
	double cpu_time;		/* Amount of CPU used by last plsc() */
	double sys_time;		/* Average kernel time used by last plsc() */
	double cpu_itime;		/* CPU time between two collections */
	double sys_itime;		/* Average kernel time between collections */
};

/*
 * Stack used by local variables, remembered set, etc... It is implemented
 * with small chunks linked together.
 */
struct stack {
	struct stchunk *st_hd;	/* Head of chunk list */
	struct stchunk *st_tl;	/* Tail of chunk list */
	struct stchunk *st_cur;	/* Current chunk in use (where top is) */
	char **st_top;			/* Top in chunk (pointer to next free location) */
	char **st_end;			/* Pointer to first element beyond current chunk */
};

struct stchunk {
	struct stchunk *sk_next;	/* Next chunk in stack */
	struct stchunk *sk_prev;	/* Previous chunk in stack */
	char **sk_arena;			/* Arena where objects are stored */
	char **sk_end;				/* Pointer to first element beyond the chunk */
};


	/*---------------------*/
	/*	interp.h & debug.h */
	/*---------------------*/

	/* Stack data structures for features */
struct item {
	uint32 type;				/* Type of the item (SK_INT, SK_BOOL, SK_DOUBLE, ...) */
	union {
		/* values (melted feature) */
		EIF_CHARACTER itu_char;		/* SK_CHAR, SK_BOOL - a character value */
		EIF_INTEGER_8 itu_int8;		/* SK_INT8 = a 8 bits integer value */
		EIF_WIDE_CHAR itu_wchar;	/* SK_WCHAR - a unicode character value */
		EIF_INTEGER_16 itu_int16;	/* SK_INT16 = a 16 bits integer value */
		EIF_INTEGER_32 itu_int32;	/* SK_INT32 - a 32 bits integer value */
		EIF_REAL itu_float;			/* SK_FLOAT - a real value */
		EIF_DOUBLE itu_double;		/* SK_DOUBLE - a double value */
		EIF_INTEGER_64 itu_int64;	/* SK_INT64 - a 64 bits integer value */
		EIF_REFERENCE itu_ref;		/* SK_REF / SK_STRING - a reference value */
		EIF_REFERENCE itu_bit;		/* SK_BIT - a bit reference value */
		EIF_POINTER itu_ptr;		/* SK_POINTER - a routine pointer */
	} itu;

	/* address (frozen feature) - should not be part of the union since we are filling */
	/* the union from the address in the function 'ivalue' */
	void *it_addr;			/* SK_INT, SK_CHAR, ... - address where value can be found */
};

	/* Stack used by the interpreter (operational stack) */
struct stochunk {
	struct stochunk *sk_next;	/* Next chunk in stack */
	struct stochunk *sk_prev;	/* Previous chunk in stack */
	struct item *sk_arena;		/* Arena where objects are stored */
	struct item *sk_end;		/* Pointer to first element beyond the chunk */
};

struct opstack {
	struct stochunk *st_hd;		/* Head of chunk list */
	struct stochunk *st_tl;		/* Tail of chunk list */
	struct stochunk *st_cur;	/* Current chunk in use (where top is) */
	struct item *st_top;		/* Top (pointer to next free location) */
	struct item *st_end;		/* First element beyond current chunk */
};


	/*------------*/
	/*	malloc.h  */
	/*------------*/

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
#ifdef EIF_TID
        EIF_THR_TYPE *ovs_tid;          /* thread id of creator thread */
#endif  /* EIF_TID */
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


	/*------------*/
	/*	search.h  */
	/*------------*/

/*
 * Search table declarations.
 */
struct s_table {
	uint32 s_size;		/* Search table size */
	uint32 s_count;		/* Count of inserted keys */
	char **s_keys;		/* Search table keys */
};


    /*---------*/
    /*  sig.h  */
    /*---------*/

/* Structure used as FIFO stack for signal buffering. I really do not expect
 * this stack to overflow, so it has a huge fixed size--RAM. Should it really
 * overflow, we would panic immediately :-(.
 */
struct s_stack {
    int s_min;              /* Minimum value of circular buffer */
    int s_max;              /* Maximum value of circular buffer */
    char s_pending;         /* Are any signals pending? */
    char s_buf[SIGSTACK];   /* The circular buffer used as a FIFO stack */
};


	/*-----------*/
	/*  debug.h  */
	/*-----------*/

/* Call context. Each call to a debuggable byte code is recorded into a calling
 * context, which enable the user to move upwards and downwards and thus fetch
 * the corresponding local variables and parameters. We also record the position
 * of the associated execution vector within the Eiffel stack, which enables
 * easy stack dumps.
 */
struct dcall {					/* Debug context call */
	unsigned char *dc_start;	/* Start of current byte code */
	void *dc_cur;				/* Current operational stack chunk (struct c_opchunk for frozen features) */
	void *dc_top;				/* Current operational stack top (type is struct i_item for melted feature,
								 * and struct c_item for frozen feature) */
	struct ex_vect *dc_exec;	/* Execution vector on Eiffel stack */
	int dc_status;				/* Execution status for this routine */
	int dc_body_id;				/* Body ID of current feature */
};

/*
 * Stack used by the debugger (context stack)
 */

struct stdchunk {
	struct stdchunk *sk_next;	/* Next chunk in stack */
	struct stdchunk *sk_prev;	/* Previous chunk in stack */
	struct dcall *sk_arena;		/* Arena where objects are stored */
	struct dcall *sk_end;		/* Pointer to first element beyond the chunk */
};

struct dbstack {
	struct stdchunk *st_hd;		/* Head of chunk list */
	struct stdchunk *st_tl;		/* Tail of chunk list */
	struct stdchunk *st_cur;	/* Current chunk in use (where top is) */
	struct dcall *st_top;		/* Top (pointer to next free location) */
	struct dcall *st_end;		/* First element beyond current chunk */
};

struct id_list {
	struct idlchunk *idl_hd;		/* idl_hd */
	struct idlchunk *idl_tl;		/* idl_tl */
	uint32 *idl_last;				/* idl_last */
	uint32 *idl_end;				/* idl_end */
};

/* For fastest reference, the debugging informations for the current routine
 * are held in the debugger status structure.
 */

/* Debugger information (local to a thread) */
struct dbinfo {
	unsigned char *db_start;			/* Start of current byte code (dcall) */
	int db_status;						/* Execution status (dcall) */
#ifdef WORKBENCH
	uint32 db_callstack_depth;			/* number of routines on the eiffel stack */
	uint32 db_callstack_depth_stop;		/* depth from which we must stop (step-by-step, stepinto..) */
	char db_stepinto_mode;				/* is stepinto activated ? */
#endif /* WORKBENCH */
};

#ifdef WORKBENCH
/* List of offset. It tells where the breakpoint inside a feature are */
struct offset_list { 
	uint32 offset;
	struct offset_list *next;
};

/* Breakpoint table. there is one entry per feature where you can find a breakpoint */
struct db_bpinfo {
	int body_id;						/* body_id of the feature where breakpoints are located */
	struct offset_list *first_offset;	/* list of all offset where a breakpoint is enabled */
										/* (ordered from smaller to bigger one) */
	struct offset_list *last_offset_list;	/* sublist starting at the last visited offset */
	uint32 last_offset;
	struct db_bpinfo *next;				/* next body id in the list */
};

/* Debugger information (global to all threads) */
struct dbglobalinfo {
	char db_discard_breakpoints;		/* when set, discard all breakpoints. used for run-no-stop, */
										/* and after the end of the root creation. it avoids the    */
										/* application to stop after its end when garbage collector */
										/* destroys objects                                         */
	struct db_bpinfo **db_bpinfo;		/* breakpoints hash table */
#ifdef EIF_THREADS
	EIF_MUTEX_TYPE *db_mutex;			/* Mutex to protect `dstop' against concurrent accesses     */
#endif /* EIF_THREADS */
};
#endif /* WORKBENCH */

/* Program status (saved when breakpoint reached, restored upon continuation). */
struct pgcontext {				/* Program context */
	struct dbstack pg_debugger;	/* Debugger's context stack */
	struct opstack pg_interp;	/* Interpreter's operational stack */
	struct xstack pg_stack;		/* Calling stack */
	struct xstack pg_trace;		/* Pending exceptions */
	struct dcall *pg_active;	/* Active routine */
	unsigned char *pg_IC;		/* Current IC value */
	int pg_status;				/* Cause of suspension */
	int pg_calls;				/* Amount of calling contexts in stack */
	int pg_index;				/* Index of active routine within stack */
};

#ifdef __cplusplus
}
#endif

#endif	 /* _eif_types_h */
