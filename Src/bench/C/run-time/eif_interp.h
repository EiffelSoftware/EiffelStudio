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

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_globals.h"
#include <stdio.h>		/* %%zs added: for FILE definition line 91 */
#include "eif_portable.h"
#include "eif_struct.h"


/* %%ss moved to eif_types.h : struct item */ 

/* Macros for easy reference */
#define it_char		itu.itu_char
#define it_long		itu.itu_long
#define it_float	itu.itu_float
#define it_double	itu.itu_double
#define it_ref		itu.itu_ref
#define it_ptr		itu.itu_ptr
#define it_bit		itu.itu_bit

/* %%ss moved to eif_types.h : struct opstack, struct stochunk */

/* Interpreter interface to outside world */
extern void call_disp(uint32 dtype, char *object);			/* Function to call dispose routines */ 
extern void xinterp(EIF_CONTEXT char *icval);				/* Compound from a given address */
extern void xiinv(EIF_CONTEXT char *icval, int where);				/* Invariant interpreter */
extern void xinitint(void);				/* Initialize the interpreter */
extern struct item *opush(register struct item *val);		/* Push value on operational stack */
extern struct item *opop(void);			/* Remove value from operational stack */
extern struct item *otop(void);			/* Top of the stack */
extern struct item *ivalue(EIF_CONTEXT int code, int num);		/* Value request from current routine */
extern void sync_registers(EIF_CONTEXT struct stochunk *stack_cur, struct item *stack_top);		/* Resynchronize registers on routine */

/* Requesting values via ivalue() */
#define IV_LOCAL	0				/* Nth local wanted */
#define IV_ARG		1				/* Nth argument wanted */
#define IV_CURRENT	2				/* Current value wanted */
#define IV_RESULT	3				/* Result value wanted */

/* Macro used to prepare a cell on top of the stack */
#define iget()	opush((struct item *) 0)	/* Push empty cell on stack */

/* extern char *IC; *//* Byte code to interpret */ /* %%ss */
/* extern struct opstack op_stack;*//* Operational stack */ /* %%ss */
extern void idump(FILE *fd, char *start);

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
#define BC_DOUBLE			48
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
#define BC_RETRIEVE_OLD		99
#define BC_FLOAT			100	
#define BC_OLD				101
#define BC_ADD_STRIP		102
#define BC_END_STRIP		103
#define BC_LBIT_ASSIGN		104
#define BC_RAISE_PREC		105
#define BC_GOTO_BODY		106
#define BC_NOT_REC			107
#define BC_END_PRE			108
#define BC_END_FST_PRE		109
#define BC_CAST_LONG     	110
#define BC_CAST_FLOAT    	111
#define BC_CAST_DOUBLE  	112
#define BC_INV_NULL  		113
#define BC_CREAT_INV		114
#define BC_END_EVAL_OLD		115
#define BC_START_EVAL_OLD	116
#define BC_OBJECT_ADDR		117
#define BC_PFEATURE			118
#define BC_PFEATURE_INV		119
#define BC_PEXTERN			120
#define BC_PEXTERN_INV		121
#define BC_PARRAY			122
#define BC_PATTRIBUTE		123
#define BC_PATTRIBUTE_INV	124
#define BC_PEXP_ASSIGN		125
#define BC_PASSIGN			126
#define BC_PREVERSE			127
#define BC_PCLIKE			(char) 128
#define BC_OBJECT_EXPR_ADDR	(char) 129
#define BC_RESERVE			(char) 130
#define BC_POP				(char) 131

#define BC_REF_TO_PTR		(char) 132

#ifdef CONCURRENT_EIFFEL
/* Instructions for Concurrent Eiffel */
#define BC_SEP_SET			(char) 150
#define BC_SEP_UNSET		(char) 151
#define BC_SEP_RESERVE		(char) 152
#define BC_SEP_FREE			(char) 153
#define BC_SEP_TO_SEP		(char) 154
#define BC_SEP_RAISE_PREC	(char) 155
#define BC_SEP_CREATE		(char) 156
#define BC_SEP_CREATE_END	(char) 157

#define BC_SEP_ATTRIBUTE_INV	(char) 158
#define BC_SEP_EXTERN_INV	(char) 159
#define BC_SEP_FEATURE_INV	(char) 160

#define BC_SEP_PATTRIBUTE_INV	(char) 161
#define BC_SEP_PEXTERN_INV	(char) 162
#define BC_SEP_PFEATURE_INV	(char) 163

#define BC_SEP_EXTERN		(char) 164
#define BC_SEP_FEATURE		(char) 165
#define BC_SEP_PEXTERN		(char) 166
#define BC_SEP_PFEATURE		(char) 167

/* NOTE: We can get rid of the following instructions:
 * BC_SEP_FEATURE
 * BC_SEP_PFEATURE
 * BC_SEP_EXTERN
 * BC_SEP_PEXTERN
*/
#endif

#ifdef __cplusplus
}
#endif

#endif
