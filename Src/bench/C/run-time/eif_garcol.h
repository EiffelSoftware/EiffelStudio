/*

  ####     ##    #####    ####    ####   #               #    #
 #    #   #  #   #    #  #    #  #    #  #               #    #
 #       #    #  #    #  #       #    #  #               ######
 #  ###  ######  #####   #       #    #  #        ###    #    #
 #    #  #    #  #   #   #    #  #    #  #        ###    #    #
  ####   #    #  #    #   ####    ####   ######   ###    #    #

	Declarations for garbage collector routines.
*/

#ifndef _eif_garcol_h_
#define _eif_garcol_h_

#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_struct.h"
#ifndef TEST
#include "eif_plug.h"		/* Not wanted when runnning tests */
#endif

#include "eif_malloc.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef VXWORKS
#define STACK_CHUNK		400		/* Size of a stack chunk */
#else
#define STACK_CHUNK		1000	/* Size of a stack chunk */
#endif
#define MIN_FREE		100		/* Below that, chunk is nearly full */
#define TH_ALLOC		65536	/* Allocation threshold (64 K)*/
#define TH_ALLOC_MIN	8192	/* Minimal allocation threshold (8 K).*/
#define OBJ_MAX			1500	/* Maximum # of young objects in moved_set */
#define TO_MAX			7		/* Maximum number of allocable 'to' */
#define CHUNK_MIN		5		/* Minimum Eiffel chunk # to activate plsc() */
#define PLSC_PER		8		/* Period of plsc in acollect */
#define SPOILT_TBL		3		/* Size of spoilt chunks recording table */

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
#define EO_UPPER	0xffff0000		/* Mask to get upper half of flags */
#define EO_MOVED	(EO_NEW | EO_MARK)

/*
 * For aging -- edit with care.
 */
#define AGE_ONE		0x02000000		/* First birthday time */
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

#ifndef EIF_THREADS
extern struct stack memory_set;	/* Memory set stack.	*/
#endif	/* !EIF_THREADS */

extern int is_in_rem_set (EIF_REFERENCE obj);	/* Is obj in rem-set? */
extern int is_in_special_rem_set (EIF_REFERENCE obj);	/* Is obj in special_rem_set? */
/* General-purpose exported functions */
RT_LNK void plsc(void);					/* Partial scavenging */
extern void urgent_plsc(EIF_REFERENCE *object);			/* Partial scavenge with given local root */
extern void mksp(void);					/* Mark and sweep algorithm */
RT_LNK void reclaim(void);				/* Reclaim all the objects */
RT_LNK int collect(void);				/* Generation-based collector */
extern int epush(register struct stack *stk, register EIF_REFERENCE value);					/* Push an addess on a run-time stack */
extern char **st_alloc(register struct stack *stk, register int size);			/* Creates an empty stack */
extern  int st_extend(register struct stack *stk, register int size);         
/* Extends a stack */
extern int acollect(void);				/* Automatic garbage collection */
extern int scollect(int (*gc_func) (void), int i);				/* Collection with statistics */
extern void st_truncate(register struct stack *stk);			/* Truncate stack if necessary */
extern void st_wipe_out(register struct stchunk *chunk);			/* Remove unneeded chunk from stack */
RT_LNK void eremb(EIF_REFERENCE obj);				/* Remembers old object */
RT_LNK void erembq(EIF_REFERENCE obj);				/* Quick veersion (no GC call) of eremb */
extern void special_erembq(EIF_REFERENCE obj, EIF_INTEGER offst);				
							/* Quick version (no GC call) of eremb for
							 *special objects full of references.*/
#ifdef EIF_REM_SET_OPTIMIZATION
extern int special_erembq_replace(EIF_REFERENCE old, EIF_REFERENCE val);				
							/* Replace `old' by `val' in special_rem_set. */
extern int eif_promote_special (register EIF_REFERENCE object);		
							/* Does an special refers to young ones ? */
extern int is_in_special_rem_set (register EIF_REFERENCE object);
#endif	/* EIF_REM_SET_OPTIMIZATION */
RT_LNK char *onceset(void);				/* Recording of once function result */
extern EIF_REFERENCE *eif_once_set_addr (EIF_REFERENCE once);
	/* Get stack address of "once" from "once_set". */
extern int refers_new_object(register EIF_REFERENCE object);		/* Does an object refers to young ones ? */
RT_LNK void gc_stop(void);				/* Stop the garbage collector */
RT_LNK void gc_run(void);				/* Restart the garbage collector */
extern char *to_chunk(void);			/* Base address of partial 'to' chunk */
extern void gfree(register union overhead *zone);	/* Garbage collector's free routine */


#ifdef __cplusplus
}
#endif

#endif
