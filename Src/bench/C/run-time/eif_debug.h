/*

 #####   ######  #####   #    #   ####           #    #
 #    #  #       #    #  #    #  #    #          #    #
 #    #  #####   #####   #    #  #               ######
 #    #  #       #    #  #    #  #  ###   ###    #    #
 #    #  #       #    #  #    #  #    #   ###    #    #
 #####   ######  #####    ####    ####    ###    #    #

	Data structures and functions used by debugger.
*/

#ifndef _eif_debug_h_
#define _eif_debug_h_

#ifdef __cplusplus
extern "C" {
#endif

/* Start of workbench-specific features */
#ifdef WORKBENCH
#include "eif_interp.h"
#include "eif_except.h"

/* Execution status */
#define DX_CONT		0			/* Continue until next breakpoint */
#define DX_STEP		1			/* Advance one step */
#define DX_NEXT		2			/* Advance until next line */

/* Commands for breakpoint setting */
#define DT_SET		0			/* Activate breakpoint */
#define DT_REMOVE	1			/* Remove breakpoint */

/*
 * List of body_ids (uint32)
 */

struct idlchunk {
	struct idlchunk *idl_next;	/* Next chunk in list */
	struct idlchunk *idl_prev;	/* Previous chunk in list */
	uint32 *idl_arena;			/* Arena where objects are stored */
	uint32 *idl_end;			/* Pointer to first element beyond the chunk */
};

/*
 * Position within stopped program.
 */

struct where {					/* Where the program stopped */
	char *wh_name;				/* Feature name */
	char *wh_obj;				/* Address of object (snapshot) */
	int wh_origin;				/* Written type (where feature comes from) */
	int wh_type;				/* Dynamic type of Current */
	long wh_offset;				/* Offset within byte code if relevant */
};


/* Context set up */
extern void dstart(void);			/* Beginning of melted feature execution */
extern void dexset(struct ex_vect *exvect);			/* Associate context with Eiffel call stack */
extern void drun(int body_id);				/* Starting execution of debugged feature */
extern void dostk(void);			/* Set operational stack context */

/* Step by step execution control */
extern void dstep();			/* A single "step" has been reached */ /* %%zs undefined */
extern void dnext(void);			/* A single "next" (end of call) reached */
extern void dline();			/* End of line (semicolon) reached */ /* %%zs undefined */
extern void dsync(void);			/* (Re)synchronize d_data cached information */
extern void dsetbreak(int body_id, uint32 offset, int what);		/* Set/remove breakpoint in feature */
extern void dstatus(int dx);			/* Update execution status (RESUME request) */

/* Debugging stack handling */
extern void initdb(void);			/* Create debugger stack and once list */
extern struct dcall *dpush(register struct dcall *val);	/* Push value on stack */
extern struct dcall *dpop(void);	/* Pop value off stack */
extern struct dcall *dtop(void);	/* Current top value */
extern void dmove(int offset);			/* Move active routine cursor */

/* Breakpoint handling */
extern rt_shared void dbreak(EIF_CONTEXT int why);	/* Program execution stopped */

/* Once list handling */
extern uint32 *onceadd(uint32 id);		/* Add once body_id to list */	
extern uint32 *onceitem(register uint32 id);		/* Item with body_id in list */

/* Once result evaluation */
extern struct item *docall(EIF_CONTEXT register uint32 body_id, register int arg_num);	/* Evaluate result of already called once func*/ /* %%ss mt !last caller */

/* Downloading byte code from compiler */
extern int dmake_room(int new_entries_number);		/* Pre-extend melting table */
extern void drecord_bc(int body_idx, int body_id, char *addr);		/* Record new byte code in run-time tables */

/* Macro used to get a calling context on top of the stack */
#define dget()	dpush((struct dcall *) 0)

#endif
/* End of workbench-specific features */

/*
 * The following defines made visible even when WORKBENCH is not defined to
 * make code in except.c compile without having spurious #ifdef requests.
 */

/* Program status flags */
#define PG_RUN			0		/* Program running */
#define PG_RAISE		1		/* Explicitely raised exception */
#define PG_VIOL			2		/* Implicitely raised exception */
#define PG_BREAK		3		/* Break point */
#define PG_INTERRUPT	4		/* Application interrupted */

#ifdef __cplusplus
}
#endif

#endif

