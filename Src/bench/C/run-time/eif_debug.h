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

/* Start of workbench-specific features */
#ifdef WORKBENCH
#include "eif_interp.h"
#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Execution status */
#define DX_CONT		0			/* Continue until next breakpoint */
#define DX_STEP		1			/* Advance one step */
#define DX_NEXT		2			/* Advance until next line */

/* Commands for breakpoint setting */
#define DT_SET			0	/* Activate breakpoint (breakpoint is an user one)  - eiffel side: Break_set from IPC_SHARED */
#define DT_REMOVE		1	/* Remove breakpoint (breakpoint is an user one)  - eiffel side: Break_remove from IPC_SHARED */
#define DT_SET_STACK	2	/* Activate a stack breakpoint - eiffel side: Break_set_stack_depth from IPC_SHARED */
#define DT_SET_STEPINTO	3	/* Activate the stepinto mode  - eiffel side: Break_set_stepinto from IPC_SHARED */

/* Commands for local variable modifying */
#define DLT_ARGUMENT	0	/* DLT=DebugLocalType, the type is an argument of a function */
#define DLT_LOCALVAR	1	/* the type is a local variable inside a function */
#define DLT_RESULT		2	/* the type is the Result of the current feature */
#define DLM_TYPE		0xC0000000 /* DLM=DebugLocalMask, mask the first 2 bits */
#define DLM_DEPTH		0x3FFFFFFF /* mask the low 30 bits */

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
extern void dstart(void);					/* Beginning of melted feature execution */
extern void dexset(struct ex_vect *exvect);	/* Associate context with Eiffel call stack */
extern void drun(int body_id);				/* Starting execution of debugged feature */
extern void dostk(void);					/* Set operational stack context */

/* execution with breakpoints control */
RT_LNK void dstop(struct ex_vect *exvect, uint32 offset);	/* Breakable point reached */
RT_LNK void dstop_nested(struct ex_vect *exvect, uint32 offset);	/* Breakable point reached (nested call) */
extern void dsync(void);									/* (Re)synchronize d_data cached information */
extern void dsetbreak(int body_id, uint32 offset, int what);/* Set/remove breakpoint in feature */
extern void dstatus(int dx);								/* Update execution status (RESUME request) */

/* Debugging stack handling */
extern void initdb(void);								/* Create debugger stack and once list */
extern struct dcall *dpush(register struct dcall *val);	/* Push value on stack */
extern struct dcall *dpop(void);						/* Pop value off stack */
extern struct dcall *dtop(void);						/* Current top value */
extern void dmove(int offset);							/* Move active routine cursor */

/* Breakpoint handling */
extern rt_shared void dbreak(EIF_CONTEXT int why);		/* Program execution stopped */

/* Once list handling */
RT_LNK uint32 *onceadd(uint32 id);		/* Add once body_id to list */	
RT_LNK uint32 *onceitem(register uint32 id);		/* Item with body_id in list */

/* Once result evaluation */
extern struct item *docall(EIF_CONTEXT register uint32 body_id, register int arg_num);	/* Evaluate result of already called once func*/ /* %%ss mt !last caller */

/* Downloading byte code from compiler */
extern void drecord_bc(uint16 body_idx, uint16 body_id, unsigned char *addr);		/* Record new byte code in run-time tables */

/* Computing position within program */
extern void ewhere(struct where *where);

/* frozen stack (used to record local variables address) */ 
extern struct item	*c_stack_allocate(register int size);
extern struct item	*c_opush(register struct item *val);
extern struct item	*c_opop(void);
extern struct item	*c_otop(void);
extern struct item 	*c_oitem(uint32 n);
extern int			c_stack_extend(register int size);
extern void 		c_npop(register int nb_items);
extern void			c_wipe_out(register struct stochunk *chunk);
extern void 		c_stack_truncate(void);
RT_LNK void 		clean_local_vars (int n);
RT_LNK void 		insert_local_var (uint32 type, void *ptr);

/* Macro used to get a calling context on top of the stack */
#define dget()	dpush((struct dcall *) 0)

#endif
/* End of workbench-specific features */

/*
 * The following defines made visible even when WORKBENCH is not defined to
 * make code in except.c compile without having spurious #ifdef requests.
 */

/* Program status flags */
#define PG_RUN				0		/* Program running */
#define PG_RAISE			1		/* Explicitely raised exception */
#define PG_VIOL				2		/* Implicitely raised exception */
#define PG_BREAK			3		/* Break point */
#define PG_INTERRUPT		4		/* Application interrupted */
#define PG_NEWBREAKPOINT	5		/* New breakpoint(s) added while running */
#define PG_STEP				6		/* Step completed */
#define PG_OVERFLOW			7		/* A possible stack overflow has been detected */


/**************/
/* newdebug.h */
/**************/
#define ITEM_SZ			sizeof(struct item)

#define clocnum exvect->ex_locnum
#define cargnum exvect->ex_argnum
#define cresult c_oitem(start + clocnum + cargnum + 1)
#define cloc(x) c_oitem(start + clocnum - (x))
#define carg(x) c_oitem(start + clocnum + cargnum + 1 - (x))
#define ccurrent c_oitem(start + clocnum)

#ifdef __cplusplus
}
#endif

#endif
