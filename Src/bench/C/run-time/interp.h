/*

    #    #    #   #####  ######  #####   #####           #    #
    #    ##   #     #    #       #    #  #    #          #    #
    #    # #  #     #    #####   #    #  #    #          ######
    #    #  # #     #    #       #####   #####    ###    #    #
    #    #   ##     #    #       #   #   #        ###    #    #
    #    #    #     #    ######  #    #  #        ###    #    #

	Interpreter declarations and definitions.
*/

#ifndef _interp_h_
#define _interp_h_

#include "portable.h"
#include "struct.h"

/*
 * Stack data structures.
 */

struct item {
	uint32 type;				/* Union's discriminent */
	union {
		char itu_char;			/* A character value */
		long itu_long;			/* An integer value */
		float itu_float;		/* A real value */
		double itu_double;		/* A double value */
		char *itu_ref;			/* A reference value */
		char *itu_bit;			/* A bit reference value */
		fnptr itu_ptr;			/* A routine pointer */
	} itu;
};

/* Macros for easy reference */
#define it_char		itu.itu_char
#define it_long		itu.itu_long
#define it_float	itu.itu_float
#define it_double	itu.itu_double
#define it_ref		itu.itu_ref
#define it_ptr		itu.itu_ptr
#define it_bit		itu.itu_bit

/*
 * Stack used by the interpreter (operational stack)
 */

struct opstack {
	struct stochunk *st_hd;		/* Head of chunk list */
	struct stochunk *st_tl;		/* Tail of chunk list */
	struct stochunk *st_cur;	/* Current chunk in use (where top is) */
	struct item *st_top;		/* Top (pointer to next free location) */
	struct item *st_end;		/* First element beyond current chunk */
};

struct stochunk {
	struct stochunk *sk_next;	/* Next chunk in stack */
	struct stochunk *sk_prev;	/* Previous chunk in stack */
	struct item *sk_arena;		/* Arena where objects are stored */
	struct item *sk_end;		/* Pointer to first element beyond the chunk */
};

/* Interpreter interface to outside world */
extern void call_disp();			/* Function to call dispose routines */ 
extern void xinterp();				/* Compound from a given address */
extern void xiinv();				/* Invariant interpreter */
extern void xinitint();				/* Initialize the interpreter */
extern struct item *opush();		/* Push value on operational stack */
extern struct item *opop();			/* Remove value from operational stack */
extern struct item *otop();			/* Top of the stack */
extern struct item *ivalue();		/* Value request from current routine */
extern void sync_registers();		/* Resynchronize registers on routine */

/* Requesting values via ivalue() */
#define IV_LOCAL	0				/* Nth local wanted */
#define IV_ARG		1				/* Nth argument wanted */
#define IV_CURRENT	2				/* Current value wanted */
#define IV_RESULT	3				/* Result value wanted */

/* Macro used to prepare a cell on top of the stack */
#define iget()	opush((struct item *) 0)	/* Push empty cell on stack */

extern char *IC;					/* Byte code to interpret */
extern struct opstack op_stack;		/* Operational stack */

/*
 * Byte-code tokens
 */

#define BC_START			0					
#define BC_PRECOND			1	
#define BC_POSTCOND			2	
#define	BC_DEFERRED			3
#define BC_REVERSE			4
#define BC_CHECK			5
#define BC_ASSERT			6
#define BC_NULL				7
#define BC_PRE				8
#define BC_PST				9
#define BC_CHK				10
#define BC_LINV				11
#define BC_LVAR				12
#define BC_INV				13
#define BC_END_ASSERT		14
#define BC_TAG				15
#define BC_NOTAG			16
#define BC_JMP_F			17
#define BC_JMP				18
#define BC_LOOP				19
#define BC_END_VARIANT		20
#define BC_INIT_VARIANT		21
#define BC_DEBUG			22
#define BC_RASSIGN			23
#define BC_LASSIGN			24
#define BC_ASSIGN			25
#define BC_CREATE			26
#define BC_CTYPE			27
#define	BC_CARG				28
#define BC_CLIKE			29
#define BC_CCUR				30
#define BC_INSPECT			31
#define BC_RANGE			32
#define BC_INSPECT_EXCEP	33
#define BC_LREVERSE			34
#define BC_RREVERSE			35
#define BC_FEATURE			36
#define BC_METAMORPHOSE		37
#define BC_CURRENT			38
#define BC_ROTATE			39
#define BC_FEATURE_INV		40
#define BC_ATTRIBUTE		41
#define BC_ATTRIBUTE_INV	42
#define BC_EXTERN			43
#define BC_EXTERN_INV		44
#define BC_CHAR				45
#define BC_BOOL				46
#define BC_INT				47
#define BC_FLOAT			48
#define BC_RESULT			49
#define BC_LOCAL			50
#define BC_ARG				51
#define BC_UPLUS			52
#define BC_UMINUS			53
#define BC_NOT				54
#define BC_LT				55
#define BC_GT				56
#define BC_MINUS			57
#define BC_XOR				58
#define BC_GE				59
#define BC_EQ				60
#define BC_NE				61
#define BC_STAR				62
#define BC_POWER			63
#define BC_LE				64
#define BC_DIV				65
#define BC_BREAK			66
#define BC_AND				67
#define BC_SLASH			68
#define BC_MOD				69
#define BC_PLUS				70
#define BC_OR				71
#define BC_ADDR				72
#define BC_STRING			73
#define BC_AND_THEN			74
#define BC_OR_ELSE			75
#define BC_PROTECT			76
#define BC_RELEASE			77
#define BC_JMP_T			78
#define BC_DEBUGABLE		79
#define BC_RESCUE			80
#define BC_END_RESCUE		81
#define BC_RETRY			82
#define BC_EXP_ASSIGN		83
#define BC_CLONE			84
#define BC_EXP_EXCEP		85
#define BC_VOID				86
#define BC_NONE_ASSIGN		87
#define BC_LEXP_ASSIGN		88
#define BC_REXP_ASSIGN		89
#define BC_CLONE_ARG		90
#define BC_NO_CLONE_ARG		91
#define BC_FALSE_COMPAR		92
#define BC_TRUE_COMPAR		93
#define BC_STANDARD_EQUAL	94
#define BC_BIT_STD_EQUAL	95
#define BC_NEXT				96
#define BC_BIT				97
#define BC_ARRAY			98
#define BC_INSERT			99
#define BC_END_INSERT		100	
#define BC_OLD				101
#define BC_ADD_STRIP		102
#define BC_END_STRIP		103
#define BC_LBIT_ASSIGN		104
#define BC_RAISE_PREC		105
#define BC_GOTO_BODY		106
#define BC_NOT_REC			107
#define BC_END_PRE			108
#define BC_END_FST_PRE		109

#endif
