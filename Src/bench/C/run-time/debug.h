/*

 #####   ######  #####   #    #   ####           #    #
 #    #  #       #    #  #    #  #    #          #    #
 #    #  #####   #####   #    #  #               ######
 #    #  #       #    #  #    #  #  ###   ###    #    #
 #    #  #       #    #  #    #  #    #   ###    #    #
 #####   ######  #####    ####    ####    ###    #    #

	Data structures and functions used by debugger.
*/

#ifndef _debug_h_
#define _debug_h_

#ifdef __cplusplus
extern "C" {
#endif

/* Start of workbench-specific features */
#ifdef WORKBENCH
#include "interp.h"
#include "except.h"

/* Call context. Each call to a debuggable byte code is recorded into a calling
 * context, which enable the user to move upwards and downwards and thus fetch
 * the corresponding local variables and parameters. We also record the position
 * of the associated execution vector within the Eiffel stack, which enables
 * easy stack dumps.
 */
struct dcall {					/* Debug context call */
	char *dc_start;				/* Start of current byte code */
	struct stochunk *dc_cur;	/* Current operational stack chunk */
	struct item *dc_top;		/* Current operational stack top */
	struct ex_vect *dc_exec;	/* Execution vector on Eiffel stack */
	int dc_status;				/* Execution status for this routine */
	int dc_body_id;				/* Body ID of current feature */
};

/* Execution status */
#define DX_CONT		0			/* Continue until next breakpoint */
#define DX_STEP		1			/* Advance one step */
#define DX_NEXT		2			/* Advance until next line */

/* Commands for breakpoint setting */
#define DT_SET		0			/* Activate breakpoint */
#define DT_REMOVE	1			/* Remove breakpoint */

/* For fastest reference, the debugging informations for the current routine
 * are held in the debugger status structure.
 */
struct dbinfo {
	char *db_start;				/* Start of current byte code (dcall) */
	int db_status;				/* Execution status (dcall) */
};

/*
 * Stack used by the debugger (context stack)
 */

struct dbstack {
	struct stdchunk *st_hd;		/* Head of chunk list */
	struct stdchunk *st_tl;		/* Tail of chunk list */
	struct stdchunk *st_cur;	/* Current chunk in use (where top is) */
	struct dcall *st_top;		/* Top (pointer to next free location) */
	struct dcall *st_end;		/* First element beyond current chunk */
};

struct stdchunk {
	struct stdchunk *sk_next;	/* Next chunk in stack */
	struct stdchunk *sk_prev;	/* Previous chunk in stack */
	struct dcall *sk_arena;		/* Arena where objects are stored */
	struct dcall *sk_end;		/* Pointer to first element beyond the chunk */
};

/*
 * List of body_ids (uint32)
 */

struct id_list {
	struct idlchunk *idl_hd;	/* Head of chunk list */
	struct idlchunk *idl_tl;	/* Tail of chunk list */
	uint32 *idl_last;			/* Last (pointer to next free location) */
	uint32 *idl_end;			/* First element beyond current chunk */
};

struct idlchunk {
	struct idlchunk *idl_next;	/* Next chunk in list */
	struct idlchunk *idl_prev;	/* Previous chunk in list */
	uint32 *idl_arena;			/* Arena where objects are stored */
	uint32 *idl_end;			/* Pointer to first element beyond the chunk */
};

/*
 * Program status (saved when breakpoint reached, restored upon continuation).
 */

struct pgcontext {				/* Program context */
	struct dbstack pg_debugger;	/* Debugger's context stack */
	struct opstack pg_interp;	/* Interpreter's operational stack */
	struct xstack pg_stack;		/* Calling stack */
	struct xstack pg_trace;		/* Pending exceptions */
	struct dcall *pg_active;	/* Active routine */
	char *pg_IC;				/* Current IC value */
	int pg_status;				/* Cause of suspension */
	int pg_calls;				/* Amount of calling contexts in stack */
	int pg_index;				/* Index of active routine within stack */
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

/* Debugging data structures */
extern struct dbinfo d_data;	/* Global debugger information */
extern struct dbstack db_stack;	/* Calling context stack */
extern struct pgcontext d_cxt;	/* Program context */

/* Context set up */
extern void dstart();			/* Beginning of melted feature execution */
extern void dexset();			/* Associate context with Eiffel call stack */
extern void drun();				/* Starting execution of debugged feature */
extern void dostk();			/* Set operational stack context */

/* Step by step execution control */
extern void dstep();			/* A single "step" has been reached */
extern void dnext();			/* A single "next" (end of call) reached */
extern void dline();			/* End of line (semicolon) reached */
extern void dsync();			/* (Re)synchronize d_data cached information */
extern void dsetbreak();		/* Set/remove breakpoint in feature */
extern void dstatus();			/* Update execution status (RESUME request) */

/* Debugging stack handling */
extern void initdb();			/* Create debugger stack and once list */
extern struct dcall *dpush();	/* Push value on stack */
extern struct dcall *dpop();	/* Pop value off stack */
extern struct dcall *dtop();	/* Current top value */
extern void dmove();			/* Move active routine cursor */

/* Breakpoint handling */
extern rt_shared void dbreak();	/* Program execution stopped */

/* Once list handling */
extern uint32 *onceadd();		/* Add once body_id to list */	
extern uint32 *onceitem();		/* Item with body_id in list */

/* Once result evaluation */
extern struct item *docall();	/* Evaluate result of already called once func*/

/* Downloading byte code from compiler */
extern int dmake_room();		/* Pre-extend melting table */
extern void drecord_bc();		/* Record new byte code in run-time tables */

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

