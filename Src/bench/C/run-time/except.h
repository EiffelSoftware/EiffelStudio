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

#ifdef __cplusplus
extern "C" {
#endif

#include "portable.h"
#include "malloc.h"
#include "garcol.h"
#include <setjmp.h>
#ifdef __VMS
#define cma$tis_errno_get_addr CMA$TIS_ERRNO_GET_ADDR
	/* this routine is in the library in capital letters */
	/* need to redefine this before including errno.h */
#endif
#include <errno.h>    /* needed in error.c, except.c, retrieve.c */

/* Structure used as the execution vector. This is for both the execution
 * stack (eif_stack) and the exception trace stack (eif_trace).
 */
struct ex_vect {
	unsigned char ex_type;		/* Function call, pre-condition, etc... */
	unsigned char ex_retry;		/* True if function has been retried */
	unsigned char ex_rescue;	/* True if function entered its rescue clause */
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
			char *exur_jbuf;	/* Execution buffer address, null if none */
			char *exur_id;		/* Object ID (value of Current) */
			char *exur_rout;	/* The routine name */
			int exur_orig;		/* Origin of the routine */
		} exur;					/* Used by routines */
	} exu;
};

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

/*
 * Stack used by the exception vector of each routine. It is implemented
 * with small chunks linked together. These structure look like the one used
 * by the garbage collector, only the type of the items stored changes...
 */
struct xstack {
	struct stxchunk *st_hd;		/* Head of chunk list */
	struct stxchunk *st_tl;		/* Tail of chunk list */
	struct stxchunk *st_cur;	/* Current chunk in use (where top is) */
	struct ex_vect *st_top;		/* Top in chunk (pointer to next free item) */
	struct ex_vect *st_end;		/* Pointer to first element beyond chunk */
	struct ex_vect *st_bot;		/* Bottom of stack (for eif_trace only) */
};

struct stxchunk {
	struct stxchunk *sk_next;	/* Next chunk in stack */
	struct stxchunk *sk_prev;	/* Previous chunk in stack */
	struct ex_vect *sk_arena;	/* Arena where objects are stored */
	struct ex_vect *sk_end;		/* Pointer to first element beyond the chunk */
};

/* Structure used to record general flags. These are the value to take into
 * account for the last exception that occurred, which might not be in the
 * stack yet if manually or system raised.
 */
struct eif_except {
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
#define EN_OSTK		97			/* Run-time exception catching */
#define EN_ILVL		98			/* In level: pseudo-type for execution trace */
#define EN_OLVL		99			/* Out level: pseudo-type for execution trace */
#ifndef WORKBENCH
#define EN_NEX		25			/* Number of internal exceptions */
#else
#define EN_DOL		26			/* $ applied to melted feature */
#define EN_NEX		26			/* Number of internal exceptions */
#endif

/* Exported data structures (used by the generated C code) */
extern struct xstack eif_stack;	/* Stack of all the Eiffel calls */
extern struct xstack eif_trace;	/* Unsolved exception trace */
extern struct eif_except exdata;	/* Exception handling global flags */

/* Exported routines (used by the generated C code or run-time) */
extern void expop();			/* Pops an execution vector off */
extern void eraise();			/* Raise an Eiffel exception */
extern void xraise();			/* Raise an exception with no tag */
extern void eviol();			/* Eiffel violation of last assertion */
extern void enomem();			/* Raises an "Out of memory" exception */
extern struct ex_vect *exret();	/* Retries execution of routine */
extern void exhdlr();			/* Call signal handler */
extern void exinv();			/* Invariant record */
extern void exasrt();			/* Assertion record */
extern void exfail();			/* Signals: reached end of a rescue clause */
extern void panic();			/* Run-time raised panic */
extern void fatal_error();			/* Run-time raised fatal errors */
extern void exok();				/* Resumption has been successful */
extern void esfail();			/* Eiffel system failure */
extern void ereturn();			/* Return to lastly recorded rescue entry */
extern struct ex_vect *exget();	/* Get a new vector on stack */
extern void excatch();			/* Set exception catcher from C to interpret */
extern void exresc();			/* Signals entry in rescue clause */
#ifndef WORKBENCH
extern struct ex_vect *exft();	/* Set execution stack in final mode */
#endif
extern struct ex_vect *exset();	/* Set execution stack on routine entrance */
extern struct ex_vect *exnext();	/* Read next eif_trace item from bottom */

/* Routines for run-time usage only */
extern struct ex_vect *extop();	/* Top of Eiffel stack */
extern void esdie();

/* Eiffel interface with class EXCEPTIONS */
extern long eeocode();			/* Original exception code */
extern char *eeotag();			/* Original exception tag */
extern char *eeoclass();		/* Original class where exception occurred */
extern char *eeorout();			/* Original routine where exception occurred */
extern long eelcode();			/* Last exception code */
extern char *eeltag();			/* Last exception tag */
extern char *eelclass();		/* Last class where exception occurred */
extern char *eelrout();			/* Last routine where exception occurred */
extern void eetrace();			/* Print/No Print of exception history table */
extern void eecatch();			/* Catch exception */
extern void eeignore();			/* Ignore exception */
extern char *eename();			/* Exception description */


#ifdef __cplusplus
}
#endif

#endif
