/*
	description: "Exception handling declarations."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
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

#ifndef _except_h
#define _except_h

#include "eif_globals.h"
#include "eif_portable.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include <setjmp.h>
#include <errno.h>    /* needed in error.c, except.c, retrieve.c */

#ifdef __cplusplus
extern "C" {
#endif

	
#ifndef EIF_THREADS
	/* Exported data structures (used by the generated C code) */
RT_LNK struct xstack eif_stack;	/* Stack of all the Eiffel calls */
RT_LNK struct eif_exception exdata;	/* Exception handling global flags */
#endif

/* Macros for easy access */
#define ex_jbuf		exu.exur.exur_jbuf
#define ex_id		exu.exur.exur_id
#define ex_rout		exu.exur.exur_rout
#define ex_orig		exu.exur.exur_orig
#define ex_dtype	exu.exur.exur_dtype
#define ex_sig		exu.exu_sig
#define ex_errno	exu.exu_errno
#define ex_lvl		exu.exu_lvl
#define ex_name		exu.exua.exua_name
#define ex_where	exu.exua.exua_where
#define ex_from		exu.exua.exua_from
#define ex_oid		exu.exua.exua_oid

/* Short names for easier access */
#define echmem		exdata.ex_nomem
#define echtg		exdata.ex_tag
#define echval		exdata.ex_val
#define echsig		exdata.ex_nsig
#define echlvl		exdata.ex_level
#define echrt		exdata.ex_rt
#define echclass	exdata.ex_class
#define echentry	exdata.ex_entry
#define echerror	exdata.ex_error_handled
#define echpanic	exdata.ex_panic_handled

/* Flags for ex_nomem */
#define MEM_FULL	0x01	/* A simple "Out of memory" condition */
#define MEM_FSTK	0x02	/* The exception trace stack is full */
#define MEM_PANIC	0x04	/* We are in panic mode */
#define MEM_FATAL	0x08	/* Fatal error has occurred */
#define MEM_RECU	0x10	/* Flag infinit calls when no memory to raise NO_MORE_MEMERY exception. */
#define MEM_SPEC	(MEM_PANIC | MEM_FATAL)		/* Disable longjmp flag */

/* Available types for execution vector. They start at EX_START and must NOT
 * conflict with EN_* constants for GC purposes. Also it is wise to keep them
 * below 127 to avoid sign extension--RAM.
 */
#define EX_START	100			/* First value for EX_* constants */
#define EX_CALL		100			/* Function call */
#define EX_PRE		101			/* Precondition checking */
#define EX_POST		102			/* Postcondition checking */
#define EX_CINV		103			/* Invariant checking (routine exit) */
#define EX_RESC		104			/* Rescue clause */
#define EX_RETY		105			/* Retried call */
#define EX_LINV		106			/* In loop invariant */
#define EX_VAR		107			/* In loop variant */
#define EX_CHECK	108			/* In check instruction */
#define EX_HDLR		109			/* In signal handler routine */
#define EX_INVC		110			/* Invariant checking (routine entrance) */
#define EX_OSTK		111			/* Run-time exception catching */
#define EX_OLD		112			/* Old expression evaluation at entry of routines */

/* Predefined exception numbers. Value cannot start at 0 because this may need
 * a propagation via longjmp and USG implementations turn out a 0 to be 1.
 */
#define EN_VOID		1			/* Feature applied to void reference */
#define EN_MEM		2			/* No more memory */
#define EN_PRE		3			/* Pre-condition violated */
#define EN_POST		4			/* Post-condition violated */
#define EN_FLOAT	5			/* Floating point exception (signal SIGFPE) */
#define EN_CINV		6			/* Class invariant violated */
#define EN_CHECK	7			/* Assertion violated */
#define EN_FAIL		8			/* Routine failure */
#define EN_WHEN		9			/* Unmatched inspect value */
#define EN_VAR		10			/* Non-decreasing loop variant */
#define EN_LINV		11			/* Loop invariant violated */
#define EN_SIG		12			/* Operating system signal */
#define EN_BYE		13			/* Eiffel run-time panic */
#define EN_RESC		14			/* Exception in rescue clause */
#define EN_OMEM		15			/* Out of memory (cannot be ignored) */
#define EN_RES		16			/* Resumption failed (retry did not succeed) */
#define EN_CDEF		17			/* Create on deferred */
#define EN_EXT		18			/* External event */
#define EN_VEXP		19			/* Void assigned to expanded */
#define EN_HDLR		20			/* Exception in signal handler */
#define EN_IO		21			/* I/O error */
#define EN_SYS		22			/* Operating system error */
#define EN_RETR		23			/* Retrieval error */
#define EN_PROG		24			/* Developer exception */
#define EN_FATAL	25			/* Eiffel run-time fatal error */
#define EN_DOL		26			/* $ applied to melted feature */
#define EN_ISE_IO	27			/* I/O error raised by the ISE Eiffel runtime */
#define EN_COM		28			/* COM error raised by EiffelCOM runtime */
#define EN_RT_CHECK	29			/* Runtime check error such as out-of-bound array access */
#define EN_OLD		30			/* Old violation */
#define EN_SEL		31			/* Serialization failure */

#define EN_OSTK		97			/* Run-time exception catching */
#define EN_ILVL		98			/* In level: pseudo-type for execution trace */
#define EN_OLVL		99			/* Out level: pseudo-type for execution trace */

#define TRACE_SZ	4096		/* Preallocated size for trace string */

/* Exported routines (used by the generated C code or run-time) */
RT_LNK void expop(struct xstack *stk);	/* Pops an execution vector off */
#ifdef EIF_IL_DLL
#define com_eraise(tag,num) eraise (tag,num)
#define eraise(tag,num) RaiseException(num, 0, 0, NULL)
#define enomem() RaiseException(EN_OMEM, 0, 0, NULL)
#else
RT_LNK void eraise(EIF_CONTEXT char *tag, long num);		/* Raise Eiffel exception */
RT_LNK void com_eraise(EIF_CONTEXT char *tag, long num);	/* Raise EiffelCOM exception */
RT_LNK void enomem(void);										/* Raises "Out of memory" exception */
#endif

RT_LNK EIF_REFERENCE eif_check_call_on_void_target (EIF_REFERENCE);
RT_LNK void eif_check_catcall_at_runtime (EIF_REFERENCE, EIF_TYPE_INDEX, char *, int, EIF_TYPE_INDEX);

RT_LNK void eviol(EIF_CONTEXT_NOARG);			/* Eiffel violation of last assertion */
RT_LNK struct ex_vect *exret(EIF_CONTEXT struct ex_vect *rout_vect);	/* Retries execution of routine */
RT_LNK void exinv(EIF_CONTEXT char *tag, char *object);			/* Invariant record */
RT_LNK void exasrt(EIF_CONTEXT char *tag, int type);			/* Assertion record */
RT_LNK void exfail(EIF_CONTEXT_NOARG);			/* Signals: reached end of a rescue clause */
RT_LNK void eif_panic(EIF_CONTEXT char *msg);			/* Run-time raised panic */
RT_LNK void fatal_error(EIF_CONTEXT char *msg);			/* Run-time raised fatal errors */
RT_LNK void exok(EIF_CONTEXT_NOARG);				/* Resumption has been successful */
RT_LNK void exclear(EIF_CONTEXT_NOARG);				/* Clears the exception stack */
RT_LNK void esfail(EIF_CONTEXT_NOARG);			/* Eiffel system failure */
RT_LNK void exresc(EIF_CONTEXT struct ex_vect *rout_vect);			/* Signals entry in rescue clause */
RT_LNK struct ex_vect * extre(EIF_CONTEXT_NOARG);		/* Enter try section */
RT_LNK struct ex_vect * extrl(EIF_CONTEXT_NOARG);		/* Leave try section */
RT_LNK void xraise(EIF_CONTEXT int code);			/* Raise an exception with no tag */

#ifndef WORKBENCH
RT_LNK struct ex_vect *exft(void);	/* Set execution stack in final mode */
#endif
RT_LNK struct ex_vect *exset(EIF_CONTEXT char *name, EIF_TYPE_INDEX origin, char *object); /* Set execution stack on routine entrance */
RT_LNK struct ex_vect *new_exset(EIF_CONTEXT char *name, EIF_TYPE_INDEX origin, char *object, uint32 loc_nb, uint32 arg_nb, BODY_INDEX bid); /* Set execution stack on routine entrance */

/* Routines for run-time usage only */
RT_LNK void esdie(int code);

/* Used by EiffelCom */
RT_LNK char *eename(long ex);			/* Exception description */
RT_LNK char eedefined(long ex);			/* Is `ex' defined? */

/* Eiffel interface with class EXCEPTIONS */
RT_LNK void eetrace(EIF_CONTEXT char b);			/* Print/No Print of exception history table */

RT_LNK EIF_REFERENCE stack_trace_string(EIF_CONTEXT_NOARG);		/* Exception stack as an Eiffel string */
RT_LNK EIF_REFERENCE last_exception (EIF_CONTEXT_NOARG);		/* Get `last_exception' of EXCEPTION_MANAGER */
RT_LNK void oraise(EIF_REFERENCE ex);							/* Called by EXCEPTION_MANAGER to raise an existing exception */
RT_LNK void draise(long code, char *meaning, char *message);	/* Called by Eiffel code to raise an existing exception object*/
RT_LNK void set_last_exception (EIF_REFERENCE ex);				/* Set `last_exception' of EXCEPTION_MANAGER with `ex'. */
RT_LNK void chk_old(EIF_REFERENCE ex);							/* Check if ex is NULL, if not raise an OLD_VIOLATION */
RT_LNK struct ex_vect *exold(void);								/* Push excution stack at entrance of old expression evaluation */
RT_LNK void init_emnger (void);									/* Initialize once object and preallocate trace string */
RT_LNK void ereturn(EIF_CONTEXT_NOARG);							/* Return to lastly recorded rescue entry */

#ifdef __cplusplus
}
#endif

#endif
