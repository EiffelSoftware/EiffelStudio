/*

  ####     ##    #####    ####    ####   #               #    #
 #    #   #  #   #    #  #    #  #    #  #               #    #
 #       #    #  #    #  #       #    #  #               ######
 #  ###  ######  #####   #       #    #  #        ###    #    #
 #    #  #    #  #   #   #    #  #    #  #        ###    #    #
  ####   #    #  #    #   ####    ####   ######   ###    #    #

	Declarations for garbage collector routines.
*/

#ifndef _garcol_h_
#define _garcol_h_

#include "portable.h"
#include "struct.h"
#ifndef TEST
#include "plug.h"		/* Not wanted when runnning tests */
#endif

#include "malloc.h" 	/* %%ss added for overhead */

#ifdef __cplusplus
extern "C" {
#endif

#define STACK_CHUNK		1000	/* Size of a stack chunk */
#define MIN_FREE		100		/* Below that, chunk is nearly full */
#define TH_ALLOC		100000	/* Allocation threshold */
#define OBJ_MAX			1500	/* Maximum # of young objects in moved_set */
#define TO_MAX			7		/* Maximum number of allocable 'to' */
#define CHUNK_MIN		5		/* Minimum Eiffel chunk # to activate plsc() */
#define PLSC_PER		3		/* Period of plsc in acollect */
#define SPOILT_TBL		20		/* Size of spoilt chunks recording table */
#define TENURE_MAX		(1<<AGE_BITS)	/* Non reached age */

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

/*
 * Eiffel flags -- edit with care.
 */
#define EO_MARK		0x80000000		/* Garbage collector's mark */
#define EO_CREAT	0x40000000		/* Assertion loop control flag: in creation routine */
#define EO_STOP		0x20000000		/* Stop on this object */
#define EO_AGE		0x1e000000		/* Object's age before immortality */
#define EO_SPEC		0x01000000		/* Object is special (C area) */
#define EO_REF		0x00800000		/* Special object is full of references */
#define EO_STORE	0x00400000		/* Mark for objects to be stored */
#define EO_OLD		0x00200000		/* Object belongs to the old generation */
#define EO_REM		0x00100000		/* Object belongs to the remembered set */
#define EO_NEW		0x00080000		/* Object is new, outside scavenge zone */
#define EO_C		0x00040000		/* Object is a C one (malloc'ed) */
#define EO_EXP		0x00020000		/* Object is an expanded one */
#define EO_COMP		0x00010000		/* Composite (has expanded or special) */
#define EO_TYPE		0x0000ffff		/* Mask to get the dynamic type */
#define EO_MOVED	(EO_NEW | EO_MARK)

/*
 * For aging -- edit with care.
 */
#define AGE_ONE		0x02000000		/* First birthday time */
#define AGE_BITS	4				/* How many bits are used to store age */
#define AGE_OFFSET	25				/* Age starts at bit 25 and lasts 4 bits */

/*
 * Garbage collector's status.
 */
#define GC_GEN		0x01			/* Full GC with generation scavenging */
#define GC_PART		0x02			/* Full GC with partial scavenging */
#define GC_FAST		0x04			/* Fast GC (generation based) */
#define GC_STOP		0x08			/* Garbage collection is stopped */
#define GC_SIG		0x10			/* Entered in a signal handler */

/*
 * Generation scavenging's status.
 */
#define GS_STOP		0x00000008		/* Generation scavenging is stopped */
#define GS_SET		0x00000004		/* Generation scavenging to be set */
#define GS_ON		0x00000002		/* Generation scavenging is set */
#define GS_OFF		0x00000001		/* Generation scavenging is off */

/*
 * Garbage collector's statistics
 */
#define GST_NBR		2				/* Number of distinct algorithms */
#define GST_PART	0				/* Index for partial collection stats */
#define GST_GEN		1				/* Index for generation collection stats */

/* General-purpose exported functions */
extern void plsc(void);					/* Partial scavenging */
extern void urgent_plsc(char **object);			/* Partial scavenge with given local root */
extern void mksp(void);					/* Mark and sweep algorithm */
extern void reclaim(void);				/* Reclaim all the objects */
extern int collect(void);				/* Generation-based collector */
extern int epush(register struct stack *stk, register char *value);					/* Push an addess on a run-time stack */
extern char **st_alloc(register struct stack *stk, register int size);			/* Creates an empty stack */
extern int acollect(void);				/* Automatic garbage collection */
extern int scollect(int (*gc_func) (void), int i);				/* Collection with statistics */
extern void st_truncate(register struct stack *stk);			/* Truncate stack if necessary */
extern void st_wipe_out(register struct stchunk *chunk);			/* Remove unneeded chunk from stack */
extern void eremb(char *obj);				/* Remembers old object */
extern void erembq(char *obj);				/* Quick veersion (no GC call) of eremb */
extern void onceset(register char **ptr);				/* Recording of once function result */
extern int refers_new_object(register char *object);		/* Does an object refers to young ones ? */
extern void gc_stop(void);				/* Stop the garbage collector */
extern void gc_run(void);				/* Restart the garbage collector */
extern char *to_chunk(void);			/* Base address of partial 'to' chunk */
extern void gfree(register union overhead *zone);	/* Garbage collector's free routine */

/* Exported data-structure declarations */
extern struct stack loc_set;			/* Local variable stack */
extern struct stack loc_stack;			/* Local indirection stack */
extern struct stack once_set;			/* Once functions */
extern struct gacinfo g_data;			/* Garbage collection status */
extern struct gacstat g_stat[GST_NBR];	/* Collection statistics */
extern struct stack moved_set;			/* Describes the new generation */
extern struct chunk *last_from;			/* Last 'from' chunk used by plsc() */
extern struct sc_zone ps_from;			/* Partial scavenging 'from' zone */
extern struct sc_zone ps_to;			/* Partial scavenging 'to' zone */

/* To start timing or not for GC-profiling */
extern int gc_ran;				/* Has the GC been running */
extern int gc_running;			/* Is the GC currently running */
extern double last_gc_time;		/* Time spent during the last run */

/* Exported variables */
extern char *root_obj;			/* Address of the 'root' object */
extern uint32 tenure;			/* Tenure value for next generation cycle */
extern long th_alloc;			/* Allocation threshold (in bytes) */
extern long plsc_per;			/* Period of plsc() in acollect() */
extern int gc_monitor;			/* GC monitoring flag */
extern int r_fides;				/* moved here from retrieve.c */


#ifdef __cplusplus
}
#endif

#endif
