/*

 ######  #    #   ####   ######  #####    #####          #    #
 #        #  #   #    #  #       #    #     #            #    #
 #####     ##    #       #####   #    #     #            ######
 #         ##    #       #       #####      #     ###    #    #
 #        #  #   #    #  #       #          #     ###    #    #
 ######  #    #   ####   ######  #          #     ###    #    #

	Exception handling declarations.
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

/* Macros for easy access */
#define ex_jbuf		exu.exur.exur_jbuf
#define ex_id		exu.exur.exur_id
#define ex_rout		exu.exur.exur_rout
#define ex_orig		exu.exur.exur_orig
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
#define echorg		exdata.ex_org
#define echotag		exdata.ex_otag
#define echrt		exdata.ex_rt
#define echort		exdata.ex_ort
#define echclass	exdata.ex_class
#define echoclass	exdata.ex_oclass

/* Flags for ex_nomem */
#define MEM_FULL	0x01	/* A simple "Out of memory" condition */
#define MEM_FSTK	0x02	/* The exception trace stack is full */
#define MEM_PANIC	0x04	/* We are in panic mode */
#define MEM_FATAL	0x08	/* Fatal error has occurred */
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

#define EN_OSTK		97			/* Run-time exception catching */
#define EN_ILVL		98			/* In level: pseudo-type for execution trace */
#define EN_OLVL		99			/* Out level: pseudo-type for execution trace */

/* Maximum number of internal exceptions (EN_NEX) defined in
 * eif_constants.h
 */

/* Exported routines (used by the generated C code or run-time) */
RT_LNK void expop(register1 struct xstack *stk);	/* Pops an execution vector off */
RT_LNK void eraise(EIF_CONTEXT char *tag, long num);		/* Raise an Eiffel exception */
RT_LNK void com_eraise(EIF_CONTEXT char *tag, long num);	/* Raise an EiffelCOM exception */
RT_LNK void xraise(EIF_CONTEXT int code);			/* Raise an exception with no tag */
RT_LNK void eviol(EIF_CONTEXT_NOARG);			/* Eiffel violation of last assertion */
RT_LNK void enomem(EIF_CONTEXT_NOARG);			/* Raises an "Out of memory" exception */
RT_LNK struct ex_vect *exret(EIF_CONTEXT register1 struct ex_vect *rout_vect);	/* Retries execution of routine */
RT_LNK void exhdlr(EIF_CONTEXT Signal_t (*handler)(int), int sig);			/* Call signal handler */
RT_LNK void exinv(EIF_CONTEXT register2 char *tag, register3 char *object);			/* Invariant record */
RT_LNK void exasrt(EIF_CONTEXT char *tag, int type);			/* Assertion record */
RT_LNK void exfail(EIF_CONTEXT_NOARG);			/* Signals: reached end of a rescue clause */
RT_LNK void eif_panic(EIF_CONTEXT char *msg);			/* Run-time raised panic */
RT_LNK void fatal_error(EIF_CONTEXT char *msg);			/* Run-time raised fatal errors */
RT_LNK void exok(EIF_CONTEXT_NOARG);				/* Resumption has been successful */
RT_LNK void exclear(EIF_CONTEXT_NOARG);				/* Clears the exception stack */
RT_LNK void esfail(EIF_CONTEXT_NOARG);			/* Eiffel system failure */
RT_LNK void ereturn(EIF_CONTEXT_NOARG);			/* Return to lastly recorded rescue entry */
RT_LNK struct ex_vect *exget(register2 struct xstack *stk);	/* Get a new vector on stack */
RT_LNK void excatch(jmp_buf *jmp);			/* Set exception catcher from C to interpret */
RT_LNK void exresc(EIF_CONTEXT register2 struct ex_vect *rout_vect);			/* Signals entry in rescue clause */

#ifndef WORKBENCH
RT_LNK struct ex_vect *exft(void);	/* Set execution stack in final mode */
#endif
RT_LNK struct ex_vect *exset(EIF_CONTEXT char *name, int origin, char *object); /* Set execution stack on routine entrance */
RT_LNK struct ex_vect *new_exset(EIF_CONTEXT char *name, int origin, char *object, unsigned char loc_nb, unsigned char arg_nb, int bid); /* Set execution stack on routine entrance */
RT_LNK struct ex_vect *exnext(EIF_CONTEXT_NOARG);	/* Read next eif_trace item from bottom */

/* Routines for run-time usage only */
RT_LNK struct ex_vect *extop(register1 struct xstack *stk);	/* Top of Eiffel stack */
RT_LNK void esdie(int code);

/* Eiffel interface with class EXCEPTIONS */
RT_LNK long eeocode(EIF_CONTEXT_NOARG);			/* Original exception code */
RT_LNK char *eeotag(EIF_CONTEXT_NOARG);			/* Original exception tag */
RT_LNK char *eeoclass(EIF_CONTEXT_NOARG);		/* Original class where exception occurred */
RT_LNK char *eeorout(EIF_CONTEXT_NOARG);			/* Original routine where exception occurred */
RT_LNK long eelcode(EIF_CONTEXT_NOARG);			/* Last exception code */
RT_LNK char *eeltag(EIF_CONTEXT_NOARG);			/* Last exception tag */
RT_LNK char *eelclass(EIF_CONTEXT_NOARG);		/* Last class where exception occurred */
RT_LNK char *eelrout(EIF_CONTEXT_NOARG);			/* Last routine where exception occurred */
RT_LNK void eetrace(EIF_CONTEXT char b);			/* Print/No Print of exception history table */
RT_LNK void eecatch(EIF_CONTEXT long ex);			/* Catch exception */
RT_LNK void eeignore(EIF_CONTEXT long ex);			/* Ignore exception */
RT_LNK char *eename(long ex);			/* Exception description */

RT_LNK EIF_REFERENCE stack_trace_string(EIF_CONTEXT_NOARG);		/* Exception stack as an Eiffel string */

#ifdef __cplusplus
}
#endif

#endif
