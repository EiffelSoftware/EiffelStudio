/*
	description: "Data structures and functions used by debugger."
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

#ifndef _eif_debug_h_
#define _eif_debug_h_

/* Start of workbench-specific features */
#ifdef WORKBENCH
#include "eif_interp.h"
#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
#ifdef WORKBENCH
RT_LNK struct dbinfo d_data;	/* Global debugger information */
#endif
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
extern void drun(BODY_INDEX body_id);				/* Starting execution of debugged feature */
extern void dostk(void);					/* Set operational stack context */

/* execution with breakpoints control */
RT_LNK void dstop(struct ex_vect *exvect, uint32 offset);	/* Breakable point reached */
RT_LNK void dstop_nested(struct ex_vect *exvect, uint32 offset);	/* Breakable point reached (nested call) */
extern void dsync(void);									/* (Re)synchronize d_data cached information */
extern void dsetbreak(BODY_INDEX body_id, int offset, int what);/* Set/remove breakpoint in feature */
extern void dbreak_clear_table(void);							/* Clear all known bps */
extern void dstatus(int dx);								/* Update execution status (RESUME request) */

/* Debugging stack handling */
extern void initdb(void);								/* Create debugger stack and once list */
extern struct dcall *dpush(register struct dcall *val);	/* Push value on stack */
extern struct dcall *dpop(void);						/* Pop value off stack */
extern struct dcall *dtop(void);						/* Current top value */
extern void dmove(int offset);							/* Move active routine cursor */

#ifdef WORKBENCH

/* RT addons in Eiffel */
#define RTDBG_EVENT_ENTER_FEATURE		10	/*  See {RT_EXTENSION}.Op_enter_feature */
#define RTDBG_EVENT_LEAVE_FEATURE		11	/*  See {RT_EXTENSION}.Op_leave_feature */ 
#define RTDBG_EVENT_RESCUE_FEATURE		12	/*  See {RT_EXTENSION}.Op_rescue_feature */ 

#define RTDBG_EVENT_REPLAY_RECORD		15	/*  See {RT_EXTENSION}.Op_exec_replay_record */
#define RTDBG_EVENT_REPLAY				16	/*  See {RT_EXTENSION}.Op_exec_replay */
#define RTDBG_EVENT_REPLAY_QUERY		17	/*  See {RT_EXTENSION}.Op_exec_replay_query */

#define RTDBG_EVENT_OBJECT_STORAGE_SAVE	31	/*  See {RT_EXTENSION}.Op_object_storage_save */
#define RTDBG_EVENT_OBJECT_STORAGE_LOAD	32	/*  See {RT_EXTENSION}.Op_object_storage_load */

#define RTDBG_OP_REPLAY_RECORD			0	/* See {RT_EXTENSION}.Op_exec_replay_record */
#define RTDBG_OP_REPLAY_BACK			1	/* See {RT_DBG_EXECUTION_RECORDER}.Direction_back */
#define RTDBG_OP_REPLAY_FORTH			2	/* See {RT_DBG_EXECUTION_RECORDER}.Direction_forth */
#define RTDBG_OP_REPLAY_LEFT			3	/* See {RT_DBG_EXECUTION_RECORDER}.Direction_left */
#define RTDBG_OP_REPLAY_RIGHT			4	/* See {RT_DBG_EXECUTION_RECORDER}.Direction_right */

/* Macro related to RT_ eiffel class and Execution replay
 *  RT_ENTER_EIFFELCODE enter into RT_ Eiffel class code
 *  RT_EXIT_EIFFELCODE  exit from RT_ Eiffel class code
 *  RTDBGE	notify RT_ debugger when entering a feature
 *  RTDBGL	notify RT_ debugger when leaving a feature
 *  RTDBGR  notify RT_ debugger when entering a rescue clause
 */

extern void rt_ext_notify_event (int op, char* curr, int cid, int fid, int dep, char* pfn);
		
#define RT_ENTER_EIFFELCODE is_inside_rt_eiffel_code = 1;
#define RT_EXIT_EIFFELCODE is_inside_rt_eiffel_code = 0;
#define RTDBGE(cid,fid,curr,dep,fn)	\
		rt_ext_notify_event (RTDBG_EVENT_ENTER_FEATURE, curr, cid, fid, dep, fn);
#define RTDBGL(cid,fid,curr,dep)	\
		rt_ext_notify_event (RTDBG_EVENT_LEAVE_FEATURE, curr, cid, fid, dep, (char*) NULL);
#define RTDBGR(curr,dep)	\
		rt_ext_notify_event (RTDBG_EVENT_RESCUE_FEATURE, curr, 0, 0, dep, (char*) NULL);

#endif /* WORKBENCH */

/* Breakpoint handling */
extern void dbreak(EIF_CONTEXT int why);		/* Program execution stopped */

/* Once result evaluation */
extern EIF_TYPED_VALUE *docall(EIF_CONTEXT register BODY_INDEX body_id, register int arg_num);	/* Evaluate result of already called once func*/

/* Downloading byte code from compiler */
extern void drecord_bc(BODY_INDEX body_idx, BODY_INDEX body_id, unsigned char *addr);		/* Record new byte code in run-time tables */

/* Computing position within program */
extern void ewhere(struct where *where);

/* frozen stack (used to record local variables address) */ 
extern EIF_TYPED_ADDRESS	*c_stack_allocate(register int size);
extern EIF_TYPED_ADDRESS	*c_opush(register EIF_TYPED_ADDRESS *val);
extern EIF_TYPED_ADDRESS	*c_opop(void);
extern EIF_TYPED_ADDRESS	*c_otop(void);
extern EIF_TYPED_ADDRESS 	*c_oitem(uint32 n);
extern int			c_stack_extend(register int size);
extern void 		c_npop(register int nb_items);
extern void			c_wipe_out(register struct c_stochunk *chunk);
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
#define PG_CATCALL			8		/* A catcall has been detected */


/**************/
/* newdebug.h */
/**************/

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
