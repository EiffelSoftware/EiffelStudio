/*
	description: "[
			Structures and types defining global variables.
			All type definitions are concentrates here because we need
			to put them in a context when running multithreaded apps.
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
	int				ex_linenum;	/* current line number (line number <=> breakpoint slot) */
#if defined(WORKBENCH) || defined(EIF_IPC)
	BODY_INDEX 		ex_bodyid;	/* body id of the feature */
	uint32			ex_locnum;	/* number of local variables in the function */
	uint32			ex_argnum;	/* number of arguments of the function */
#endif
	union {
		unsigned int exu_lvl;	/* Level for multi-branch backtracking */
		int exu_sig;			/* Signal number */
		int exu_errno;			/* Error number reported by kernel */
		struct {
			char *exua_name;	/* The assertion tag */
			char *exua_where;	/* The routine name where assertion was found */
			EIF_TYPE_INDEX exua_from;		/* And its origin (where it was written) */
			EIF_REFERENCE exua_oid;		/* Value of Current */
		} exua;					/* Used by assertions */
		struct {
			jmp_buf *exur_jbuf;			/* Execution buffer address, null if none */
			EIF_REFERENCE exur_id;		/* Value of Current */
			char *exur_rout;			/* The routine name */
			EIF_TYPE_INDEX exur_orig;	/* Origin of the routine */
			EIF_TYPE_INDEX exur_dtype;	/* Origin of the routine */
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
	EIF_TYPE_INDEX from;	/* Where the routine comes from */
};

/* Improved string structure (with number of bytes used and length)
 * for the exception trace string 
 */
typedef struct _smart_string {
	char *area;			/* Pointer to zone where data is stored */
	size_t used;		/* Number of bytes actually used */
	size_t size;		/* Length of the area */
} SMART_STRING;

/* Structure used to record general flags. These are the value to take into
 * account for the last exception that occurred, which might not be in the
 * stack yet if manually or system raised.
 */
struct eif_exception {
	int ex_val;				/* Exception code (raised) */
	unsigned char ex_nomem;	/* An "Out of memory" exception occurred */
	int ex_nsig;			/* Number of last signal received */
	unsigned int ex_level;	/* Exception level (rescue branches) */
 	char *ex_tag;			/* Assertion tag */
	char *ex_rt;			/* Routine associated with current exception */
	EIF_TYPE_INDEX ex_class;/* Class associated with current exception */
	int ex_entry;			/* Is entry or exit of a routine when evaluating invariant. */
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
	rt_uint_ptr mem_used;		/* State of memory after previous run */
	rt_uint_ptr mem_copied;	/* Amount of memory copied by the scavenging */
	rt_uint_ptr mem_move;		/* Size of the 'from' spaces */
	int gc_to;					/* Number of 'to' zone allocated for plsc */
	char status;				/* Describes the collecting status */
};

struct gacstat {
	long count;				/* Number of full or partial collection so far. */
	rt_uint_ptr mem_used;			/* State of memory after previous run */
	rt_uint_ptr mem_collect;		/* Memory collected during previous run */
	rt_uint_ptr mem_avg;			/* Average memory collected in a cycle */
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
	double cpu_total_time;	/* Total CPU time since beginning of application */
	double sys_total_time;	/* Total CPU time since beginning of application */
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

typedef union tag_EIF_VALUE {
	EIF_REFERENCE  r;  /* SK_REF     - reference                */
	EIF_POINTER    p;  /* SK_POINTER - pointer                  */
	EIF_BOOLEAN    b;  /* SK_BOOL    - boolean                  */
	EIF_CHARACTER  c1; /* SK_CHAR    - character                */
	EIF_WIDE_CHAR  c4; /* SK_WCHAR   - unicode character        */
	EIF_INTEGER_8  i1; /* SK_INT8    - 8 bits integer           */
	EIF_INTEGER_16 i2; /* SK_INT16   - 16 bits integer          */
	EIF_INTEGER_32 i4; /* SK_INT32   - 32 bits integer          */
	EIF_INTEGER_64 i8; /* SK_INT64   - 64 bits integer          */
	EIF_NATURAL_8  n1; /* SK_UINT8   - 8 bits unsigned integer  */
	EIF_NATURAL_16 n2; /* SK_UINT16  - 16 bits unsigned integer */
	EIF_NATURAL_32 n4; /* SK_UINT32  - 32 bits unsigned integer */
	EIF_NATURAL_64 n8; /* SK_UINT64  - 64 bits unsigned integer */
	EIF_REAL_32    r4; /* SK_REAL32  - 32 bits real             */
	EIF_REAL_64    r8; /* SK_REAL64  - 64 bits real             */
} EIF_VALUE;
	
typedef struct tag_EIF_TYPED_VALUE {
	EIF_VALUE item; /* Associated value                     */
	uint32 type;    /* Type of item (SK_BOOL, SK_CHAR, ...) */
} EIF_TYPED_VALUE;

/* Shortcuts to access typed value */
#define it_b  item.b
#define it_c1 item.c1
#define it_c4 item.c4
#define it_i1 item.i1
#define it_i2 item.i2
#define it_i4 item.i4
#define it_i8 item.i8
#define it_n1 item.n1
#define it_n2 item.n2
#define it_n4 item.n4
#define it_n8 item.n8
#define it_r4 item.r4
#define it_r8 item.r8
#define it_r  item.r
#define it_p  item.p


	/* Stack data structures for frozen features */
typedef struct tag_EIF_TYPED_ADDRESS {
	void *it_addr;			/* Address of associated value */
	uint32 type;			/* Type of item (SK_INT, SK_BOOL, SK_DOUBLE, ...) */
} EIF_TYPED_ADDRESS;


	/* Stack used by the interpreter (byte code operational stack) */
struct stochunk {
	struct stochunk *sk_next;	/* Next chunk in stack */
	struct stochunk *sk_prev;	/* Previous chunk in stack */
	EIF_TYPED_VALUE *sk_arena;	/* Arena where objects are stored */
	EIF_TYPED_VALUE *sk_end;	/* Pointer to first element beyond the chunk */
};

struct opstack {
	struct stochunk *st_hd;		/* Head of chunk list */
	struct stochunk *st_tl;		/* Tail of chunk list */
	struct stochunk *st_cur;	/* Current chunk in use (where top is) */
	EIF_TYPED_VALUE *st_top;	/* Top (pointer to next free location) */
	EIF_TYPED_VALUE *st_end;	/* First element beyond current chunk */
};

	/* Stack used by the interpreter (C code operational stack) */
struct c_stochunk {
	struct c_stochunk *sk_next;	/* Next chunk in stack */
	struct c_stochunk *sk_prev;	/* Previous chunk in stack */
	EIF_TYPED_ADDRESS *sk_arena;	/* Arena where objects are stored */
	EIF_TYPED_ADDRESS *sk_end;	/* Pointer to first element beyond the chunk */
};

struct c_opstack {
	struct c_stochunk *st_hd;		/* Head of chunk list */
	struct c_stochunk *st_tl;		/* Tail of chunk list */
	struct c_stochunk *st_cur;	/* Current chunk in use (where top is) */
	EIF_TYPED_ADDRESS *st_top;	/* Top (pointer to next free location) */
	EIF_TYPED_ADDRESS *st_end;	/* First element beyond current chunk */
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
			char *ovu_fwd;		/* Forwarding pointer */
			struct {
				EIF_TYPE_INDEX dtype;
				EIF_TYPE_INDEX dftype;
				uint16 flags;
			} ovs;
		} ovu;
		rt_uint_ptr ovs_size;
#ifdef EIF_TID
        EIF_THR_TYPE *ovs_tid;          /* thread id of creator thread */
#endif  /* EIF_TID */
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
	rt_uint_ptr ml_total;			/* Total space used by malloc */
	rt_uint_ptr ml_used;			/* Real space used, in bytes */
	rt_uint_ptr ml_over;			/* Overhead space, in bytes */
};


	/*------------*/
	/*	search.h  */
	/*------------*/

/*
 * Search table declarations.
 */
struct s_table {
	size_t s_size;		/* Search table size */
	size_t s_count;		/* Count of inserted keys */
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

#ifdef WORKBENCH
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
	BODY_INDEX dc_body_id;		/* Body ID of current feature */
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

/* For fastest reference, the debugging informations for the current routine
 * are held in the debugger status structure.
 */

/* Debugger information (local to a thread) */
struct dbinfo {
	unsigned char *db_start;			/* Start of current byte code (dcall) */
	int db_status;						/* Execution status (dcall) */
	uint32 db_callstack_depth;			/* number of routines on the eiffel stack */
	uint32 db_callstack_depth_stop;		/* depth from which we must stop (step-by-step, stepinto..) */
	char db_stepinto_mode;				/* is stepinto activated ? */
	char db_discard_breakpoints;		/* when set, discard all breakpoints. (not used for run-no-stop)*/
                                        /* and after the end of the root creation. it avoids the    	*/
                                        /* application to stop after its end when garbage collector 	*/
                                        /* destroys objects                                         	*/
};

/* List of offset. It tells where the breakpoint inside a feature are */
struct offset_list { 
	uint32 offset;
	struct offset_list *next;
};

/* Breakpoint table. there is one entry per feature where you can find a breakpoint */
struct db_bpinfo {
	BODY_INDEX body_id;					/* body_id of the feature where breakpoints are located */
	struct offset_list *first_offset;	/* list of all offset where a breakpoint is enabled */
										/* (ordered from smaller to bigger one) */
	struct offset_list *last_offset_list;	/* sublist starting at the last visited offset */
	uint32 last_offset;
	struct db_bpinfo *next;				/* next body id in the list */
};

/* Debugger information (global to all threads) */
struct dbglobalinfo {
	struct db_bpinfo **db_bpinfo;		/* breakpoints hash table */
};

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

#endif /* WORKBENCH */

#ifdef __cplusplus
}
#endif

#endif	 /* _eif_types_h */
