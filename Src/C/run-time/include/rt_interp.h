/*
	description: "Interpreter declarations and definitions."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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

#ifndef _rt_interp_h_
#define _rt_interp_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_interp.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
extern struct opstack op_stack;               /* Operational stack */
#endif

/* Requesting values via ivalue() */
#define IV_LOCAL	0				/* Nth local wanted */
#define IV_ARG		1				/* Nth argument wanted */
#define IV_CURRENT	2				/* Current value wanted */
#define IV_RESULT	3				/* Result value wanted */

/* Kinds of once routines */
#define ONCE_MARK_NONE             0	/* Do-routine */
#define ONCE_MARK_THREAD_RELATIVE  1	/* Thread-relative once routine */
#define ONCE_MARK_PROCESS_RELATIVE 2	/* Process-relative once routine */
#define ONCE_MARK_OBJECT_RELATIVE  3	/* Object-relative once routine */
#define ONCE_MARK_ATTRIBUTE        4	/* Attribute */

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
#define BC_NOTUSED_27		27
#define	BC_NOTUSED_28		28
#define BC_NOTUSED_29		29
#define BC_NOTUSED_30		30
#define BC_CREATE_TYPE		31
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
#define BC_INT32			47
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
#define BC_NHOOK			66
#define BC_AND				67
#define BC_SLASH			68
#define BC_MOD				69
#define BC_PLUS				70
#define BC_OR				71
#define BC_ADDR				72
#define BC_STRING			73
#define BC_AND_THEN			74
#define BC_OR_ELSE			75
#define BC_SPCREATE			76
#define BC_TUPLE_ACCESS		77
#define BC_JMP_T			78
#define BC_TUPLE_ASSIGN		79
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
#define BC_NOTUSED_95		95
#define BC_HOOK				96
#define BC_NOTUSED_97			97
#define BC_ARRAY			98
#define BC_RETRIEVE_OLD		99
#define BC_FLOAT			100
#define BC_OLD				101
#define BC_ADD_STRIP		102
#define BC_END_STRIP		103
#define BC_NOTUSED_104		104
#define BC_RAISE_PREC		105
#define BC_GOTO_BODY		106
#define BC_NOT_REC			107
#define BC_END_PRE			108
#define BC_CAST_NATURAL		109
#define BC_CAST_INTEGER    	110
#define BC_CAST_REAL_32    	111
#define BC_CAST_REAL_64  	112
#define BC_INV_NULL  		113
#define BC_SEPARATE			114
#define BC_END_EVAL_OLD		115
#define BC_START_EVAL_OLD	116
#define BC_OBJECT_ADDR		117
#define BC_NOTUSED_118		118
#define BC_NOTUSED_119		119
#define BC_NOTUSED_120		120
#define BC_NOTUSED_121		121
#define BC_NOTUSED_122		122
#define BC_NOTUSED_123		123
#define BC_NOTUSED_124		124
#define BC_NOTUSED_125		125
#define BC_NOTUSED_126		126
#define BC_NOTUSED_127		127
#define BC_NOTUSED_128		(unsigned char) 128
#define BC_OBJECT_EXPR_ADDR	(unsigned char) 129
#define BC_RESERVE			(unsigned char) 130
#define BC_POP				(unsigned char) 131

#define BC_REF_TO_PTR		(unsigned char) 132
#define BC_RCREATE		(unsigned char) 133

/* Byte code for builtins */
#define BC_BUILTIN	(unsigned char) 134
#define BC_BUILTIN_UNKNOWN	(unsigned char) 1
#define BC_BUILTIN_TYPE__HAS_DEFAULT	(unsigned char) 2
#define BC_BUILTIN_TYPE__DEFAULT	(unsigned char) 3
#define BC_BUILTIN_TYPE__TYPE_ID	(unsigned char) 4
#define BC_BUILTIN_TYPE__RUNTIME_NAME	(unsigned char) 5
#define BC_BUILTIN_TYPE__GENERIC_PARAMETER_TYPE	(unsigned char) 6
#define BC_BUILTIN_TYPE__GENERIC_PARAMETER_COUNT	(unsigned char) 7

/* Byte code for expression creation */
#define BC_CAST_CHAR32		(unsigned char) 135
#define BC_NULL_POINTER		(unsigned char) 136
#define BC_BASIC_OPERATIONS	(unsigned char) 137
#define BC_MAX				(unsigned char) 1
#define BC_MIN				(unsigned char) 2
#define BC_GENERATOR		(unsigned char) 3
#define BC_OFFSET			(unsigned char) 4
#define BC_ZERO				(unsigned char) 5
#define BC_ONE				(unsigned char) 6
#define BC_THREE_WAY_COMPARISON	(unsigned char) 7
#define BC_IS_NAN			(unsigned char) 8
#define BC_IS_NEGATIVE_INFINITY	(unsigned char) 9
#define BC_IS_POSITIVE_INFINITY	(unsigned char) 10
#define BC_NAN			(unsigned char) 11
#define BC_NEGATIVE_INFINITY	(unsigned char) 12
#define BC_POSITIVE_INFINITY	(unsigned char) 13
#define BC_INT_BIT_OP		(unsigned char) 138
#define BC_INT_BIT_AND		(unsigned char) 1
#define BC_INT_BIT_OR		(unsigned char) 2
#define BC_INT_BIT_XOR		(unsigned char) 3
#define BC_INT_BIT_NOT		(unsigned char) 4
#define BC_INT_BIT_SHIFT_LEFT	(unsigned char) 5
#define BC_INT_BIT_SHIFT_RIGHT	(unsigned char) 6
#define BC_INT_BIT_TEST		(unsigned char) 7
#define BC_INT_SET_BIT		(unsigned char) 8
#define BC_INT_SET_BIT_WITH_MASK		(unsigned char) 9

/* New basic types */
#define BC_WCHAR			(unsigned char) 139
#define BC_INT8				(unsigned char) 140
#define BC_INT16			(unsigned char) 141
#define BC_INT64			(unsigned char) 142

/* Conversion */
#define BC_CAST_CHAR8		(unsigned char) 143

/* Once manifest strings */
#define BC_ONCE_STRING		(unsigned char) 144
#define BC_ALLOCATE_ONCE_STRINGS	(unsigned char) 145

/* Conditional cloning and equality */
#define BC_CCLONE		(unsigned char) 146
#define BC_CEQUAL		(unsigned char) 147

#define BC_OBJECT_TEST		(unsigned char) 148

/* Object reattachment */
#define BC_BOX			(unsigned char) 149

#define BC_UINT8			(unsigned char) 150
#define BC_UINT16			(unsigned char) 151
#define BC_UINT32			(unsigned char) 152
#define BC_UINT64			(unsigned char) 153
#define BC_FLOOR			(unsigned char) 154
#define BC_CEIL				(unsigned char) 155
#define BC_CATCALL			(unsigned char) 156
#define BC_START_CATCALL	(unsigned char) 157
#define BC_END_CATCALL		(unsigned char) 158
#define BC_IS_ATTACHED		(unsigned char) 159
#define BC_SPECIAL_EXTEND	(unsigned char) 160
#define BC_QLIKE			(unsigned char) 161
#define BC_NOTUSED_162		(unsigned char) 162
#define BC_GUARD			(unsigned char) 163
#define BC_CREATION		(unsigned char) 164
#define BC_NOTUSED_165		(unsigned char) 165
#define BC_WAIT_ARG		(unsigned char) 166
#define BC_TUPLE_CATCALL	(unsigned char) 167

/* Manifest tuple */
#define BC_TUPLE	(unsigned char) 168
#define BC_NOTUSED_169		(unsigned char) 169

/* Unicode*/
#define BC_STRING32	(unsigned char) 170
#define BC_ONCE_STRING32	(unsigned char) 171

/* Implementation (used for once per object) */
#define BC_TRY				(unsigned char) 172
#define BC_TRY_END			(unsigned char) 173
#define BC_TRY_END_EXCEPT	(unsigned char) 174
#define BC_DO_RESCUE		(unsigned char) 175
#define BC_DO_RESCUE_END	(unsigned char) 176

/* Always failing postcondition */
#define BC_POSTFAIL	(unsigned char) 177

#define MAX_CODE                177    /* Maximum legal byte code */

	/* Structure to get and set variable value in the debugger */
typedef struct tag_EIF_DEBUG_VALUE {
	EIF_TYPED_VALUE value; /* Value of the requested item   */
	void * address;        /* Address of the requested item */
} EIF_DEBUG_VALUE;


extern void metamorphose_top(struct stochunk * scur, EIF_TYPED_VALUE * volatile stop); /* Converts the top-level item on the operational stack from a basic type to a reference type */

extern void call_disp(EIF_TYPE_INDEX dtype, char *object);	/* Function to call dispose routines */
extern void call_copy (EIF_TYPE_INDEX dtype, EIF_REFERENCE Current, EIF_REFERENCE other); /* Function to call copy routines */
extern EIF_BOOLEAN call_is_equal (EIF_TYPE_INDEX dtype, EIF_REFERENCE Current, EIF_REFERENCE other); /* Function to call is_equal routines */
extern void xiinv(unsigned char *icval, int where);			/* Invariant interpreter */
extern EIF_TYPED_VALUE *otop(void);									/* Top of the stack */
extern void ivalue(EIF_DEBUG_VALUE * value, int code, uint32 num, uint32 start);	/* Value request from current routine */
extern void sync_registers(struct stochunk *stack_cur, EIF_TYPED_VALUE *stack_top);		/* Resynchronize registers on routine */

extern void idump(FILE *fd, char *start);
extern void opstack_reset(struct opstack *stk);

extern void dynamic_eval(int routine_id, int static_dtype, int is_basic_type, rt_uint_ptr nb_pushed);	/* Dynamic evaluation of a feature */
extern void dynamic_eval_dbg(int routine_id, int static_dtype, int is_basic_type, EIF_TYPED_VALUE* previous_otop, rt_uint_ptr nb_pushed, int* exception_occurred, EIF_TYPED_VALUE *result);

extern EIF_TYPE_INDEX get_compound_id (EIF_REFERENCE);
extern EIF_REFERENCE rt_melted_arg (int a_pos);

#ifdef __cplusplus
}
#endif

#endif
