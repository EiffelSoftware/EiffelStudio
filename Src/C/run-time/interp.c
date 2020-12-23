/*
	description: "The byte code interpreter."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2020, Eiffel Software."
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
			 Telephone /R805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="interp.c" header="eif_interp.h" version="$Id$" summary="Byte code interpreter for Eiffel byte code.">
*/

#ifdef WORKBENCH

#include "eif_portable.h"
#include "eif_project.h"
#include "rt_interp.h"
#include "rt_bc_reader.h"
#include "rt_malloc.h"
#include "eif_plug.h"
#include "eif_eiffel.h"
#include "rt_macros.h"
#include "rt_hashin.h"
#include "eif_cecil.h"
#include "eif_hector.h"
#include "rt_except.h"
#include "eif_local.h"
#include "eif_copy.h"
#include "rt_debug.h"
#include "rt_sig.h"
#include <math.h>
#include "eif_main.h"
#include "rt_gen_conf.h"
#include "rt_gen_types.h"
#include "eif_misc.h"
#include "rt_assert.h"
#include "rt_wbench.h"
#include "rt_garcol.h"
#include "rt_struct.h"
#include "rt_main.h" /* For debug_mode: we need to move dynamic_eval */
#include "eif_helpers.h"
#include "eif_rout_obj.h"
#include "eif_built_in.h"
#include "eif_macros.h"
#include "eif_stack.h"

/*#define SEP_DEBUG */  /**/
/*#define DEBUG 6 */ 	/**/
/*#define TEST */ /**/
#ifdef TEST
#include <stdio.h>
#endif

#include "rt_globals_access.h"

#define dprintf(n) if (DEBUG & n) printf

#define ASSERT_MAX		10			/* Automatically generated assert tags */
#define ASSERT_LENGTH	12			/* Length of "Number 9999" */
#define REGISTER_SIZE	40			/* Reasonable size of register array */
#define BIGGER_LIMIT	150			/* Number of calls before reducing size */
#define SPECIAL_REG		4			/* Number or special registers */
#define ITEM_SZ			sizeof(EIF_TYPED_VALUE)

/* Accessing the register array 'iregs' (some values have hardcoded locations
 * for faster reference, others are computed via macros). I assume local
 * variables are more likely to be used in a routine than arguments, hence
 * they are located before arguments in the array--RAM.
 */
#define icurrent	(*iregs)						/* Value of Current */
#define iresult		(*(iregs+1))					/* Result of function */
#define ilocnum	(*(iregs+2))					/* Number of locals */
#define iargnum		(*(iregs+3))					/* Number of arguments */
#define loc(n)		(*(iregs+3+(n)))				/* Locals from 1 to locnum */
#define arg(n)		(*(iregs+3+locnum+(n)))		/* Arguments from 1 to argnum */
#define nbregs		(locnum+argnum+SPECIAL_REG)	/* Total # of registers */
#define icur_dtype	Dtype(icurrent->it_ref)			/* Dtype of current */
#define icur_dftype	Dftype(icurrent->it_ref)		/* Dftype of current */
/* Interpreter routine flag */
#define INTERP_CMPD 1			/* Interpretation of a compound */
#define INTERP_INVA	2			/* Interpretation of invariant */

/* Access to precursor type */

#define GET_PTYPE   (get_int16(&IC))

#ifndef EIF_THREADS

/*
doc:	<attribute name="op_stack" return_type="struct opstack" export="shared">
doc:		<summary>Operational stack. This is the stack used by the virtual stack machine, in a reverse polish notation manner (RPN). All the operations defined by the interpreter take their argument(s) from the stack and push the result back onto the stack. Of course, optimizations are here to avoid useless stack manipulations.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data and `eif_gc_mutex'</synchronization>
doc:	</attribute>
*/
rt_shared struct opstack op_stack = { /* %%ss mt */
	(struct stopchunk *) 0,		/* st_hd */
	(struct stopchunk *) 0,		/* st_tl */
	(struct stopchunk *) 0		/* st_cur */
};

/*
doc:	<attribute name="IC" return_type="unsigned char *" export="public">
doc:		<summary>The interpreter counter is the location in byte code of the next instruction to be fetched. Its behaviour is similar to the one of PC in a central processing unit.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public unsigned char *IC = NULL;

/*
doc:	<attribute name="iregs" return_type="EIF_TYPED_VALUE **" export="private">
doc:		<summary>Interpreter registers. To speed-up access of the local parameters and variables, they are all gathered in a separate array (automagically resized). The value of Current comes first, then Result (whether it is needed or not), then all the arguments (number held in global argnum) and then the locals (number held in global locnum). They can be viewed as the interpreter's registers and are saved/backed upon each call. The 'argnum' and 'locnum' are also part of the interpreter's registers, but for faster access, they are copied to C global vars--RAM. Size of this structure is store in `iregsz'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
doc:	<attribute name="iregsz" return_type="size_t" export="private">
doc:		<summary>Size of `iregs' array (bytes)</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
doc:	<attribute name="argnum" return_type="uint32" export="private">
doc:		<summary>Number of arguments in `iregs'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
doc:	<attribute name="locnum" return_type="int" export="private">
doc:		<summary>Number of locals in `iregs'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private EIF_TYPED_VALUE **iregs = NULL;
rt_private size_t iregsz = 0;	/* Size of 'iregs' array (bytes) */
rt_private uint32 argnum = 0;		/* Number of arguments */
rt_private uint32 locnum = 0;		/* Number of locals */

/*
doc:	<attribute name="tagval" return_type="unsigned long" export="private">
doc:		<summary>Records number of interpreter's call. To optimize registers resync, we keep track of a tag value which is updated each time we enter in an interpreted routine. This gives us the ability to know if other interpreted routines where called since we left a given routine due to a function call. If none have been called, then the registers have no reason to have changed.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private unsigned long tagval = 0L;

/*
doc:	<attribute name="inv_mark_table" return_type="char *" export="private">
doc:		<summary>Invariant checking: marking table to avoid checking twice the same invariant.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>Dtype.</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private char *inv_mark_table = NULL;
#endif /* EIF_THREADS */

/* Error message */
rt_private char *RT_BOTCHED_MSG = "Operational stack botched";
rt_private char *RT_UNKNOWN_TYPE_MSG = "unknown entity type";

/* Monadic and diadic operator handling */
rt_private void monadic_op(int code);				/* Execute a monadic operation */
rt_private void diadic_op(int code);				/* Execute a diadic operation */
rt_private void eif_interp_gt(EIF_TYPED_VALUE *first, EIF_TYPED_VALUE *second);	/* > operation */
rt_private void eif_interp_ge(EIF_TYPED_VALUE *first, EIF_TYPED_VALUE *second);	/* >= operation */
rt_private void eif_interp_lt(EIF_TYPED_VALUE *first, EIF_TYPED_VALUE *second);	/* < operation */
rt_private void eif_interp_le(EIF_TYPED_VALUE *first, EIF_TYPED_VALUE *second);	/* <= operation */
rt_private void eif_interp_eq (EIF_TYPED_VALUE *f, EIF_TYPED_VALUE *s);			/* == operation */

/* Min and max operation */
rt_private void eif_three_way_comparison (void);	/* Execute `three_way_comparison'. */
rt_private void eif_interp_min_max (int code);	/* Execute `min' or `max' depending
														   on value of `type' */
rt_private void eif_interp_generator__s1 (struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top);	/* generate the 8-bit name of the basic type */
rt_private void eif_interp_generator__s4 (struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top);	/* generate the 32-bit name of the basic type */
rt_private void eif_interp_offset (void);	/* execute `offset' on character and pointer type */
rt_private void eif_interp_bit_operations (void);	/* execute bit operations on integers */
rt_private void eif_interp_builtins (struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top); /* execute basic operations on basic types */
rt_private void eif_interp_basic_operations (struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top); /* execute basic operations on basic types */

/* Assertion checking */
rt_private void icheck_inv(EIF_REFERENCE obj, struct stopchunk *scur, EIF_TYPED_VALUE *stop, int where);				/* Invariant check */
rt_private void irecursive_chkinv(EIF_TYPE_INDEX dtype, EIF_REFERENCE obj, struct stopchunk *scur, EIF_TYPED_VALUE *stop, int where);		/* Recursive invariant check */

/* Getting constants */
rt_shared EIF_TYPE_INDEX get_compound_id(EIF_REFERENCE obj);		/* Get a compound type id */
rt_shared EIF_TYPE rt_get_compound_id(EIF_REFERENCE obj);			/* Get a compound type id */
rt_private EIF_TYPE get_creation_type(void);		/* Get a creation type id */
rt_shared EIF_REFERENCE rt_melted_arg (int a_pos);

/* Interpreter interface */
rt_public void exp_call(void);				/* Sets IC before calling interpret */ /* %%ss undefine */
rt_public void xinterp(unsigned char *icval, rt_uint_ptr nb_pushed);	/* Sets IC before calling interpret */
rt_public void xinitint(void);			/* Initialization of the interpreter */
rt_private void interpret(int flag, int where);	/* Run the interpreter */

/* Dbg evaluation */
rt_shared int dbg_store_exception_trace (char* trace);

/* Feature call and/or access  */
rt_private int icall(int routine_id, int ptype);					/* Interpreter dispatcher (in water) */
rt_private void rt_attribute_access(int routine_id, uint32 type);	/* Access to an attribute */
rt_private void address(int32 aid);													/* Address of a routine */
rt_private void assign(long offset, uint32 type);									/* Assignment in an attribute */
rt_private void reverse_attribute(long offset, uint32 type);						/* Reverse assignment to attribute */
rt_private void reverse_local(EIF_TYPED_VALUE * it, EIF_TYPE_INDEX type);						/* Reverse assignment to local or result*/
rt_private void interp_check_options_start (struct eif_opt *opt, EIF_TYPE_INDEX dtype, struct stopchunk *scur, EIF_TYPED_VALUE *stop);

/* Calling protocol */
rt_private void put_once_result (EIF_TYPED_VALUE * ptr, uint32 rtype, MTOT OResult); /* Save local result to permanent once storage */
rt_private void get_once_result (MTOT OResult, uint32 rtype, EIF_TYPED_VALUE *ptr);   /* Retrieve local result from permanent once storage */

rt_private void init_var(EIF_TYPED_VALUE *ptr, uint32 type, EIF_REFERENCE current_ref); /* Initialize to 0 a variable entity */
rt_private void init_registers(void);			/* Intialize registers in callee */
rt_private void allocate_registers(void);		/* Allocate the register array */
rt_shared void sync_registers(struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top); /* Resynchronize the register array */
rt_private void pop_registers(void);						/* Remove local vars and arguments */
rt_private void create_expanded_locals (struct stopchunk * scur, EIF_TYPED_VALUE * stop); /* Initialize expanded locals */
rt_private void create_expanded_result (struct stopchunk * scur, EIF_TYPED_VALUE * stop); /* Initialize expanded result */

/* Operational stack handling routines */
#ifdef DEBUG
rt_private void dump_stack(void);							/* Dumps the operational stack */
rt_public void idump(FILE *, char *);						/* Byte code dumping */
rt_private void iinternal_dump(FILE *, char *);				/* Internal (compound) dumping */
#endif

/* Those macros are used to save and restore the ``x'' stack context to/from
 * ``y'' and ``z'', which are respectively the current chunk and the current
 * top pointer on the stack. The STACK_PRESERVE declares the variables ``dcur''
 * and ``dtop'' for the debbuger stack and ``scur'' / ``stop'' for the
 * interpreter operational stack.
 * STACK_PRESERVE_FOR_OLD is used for preservation at old evaluation in case of exception.
 * There is always a wrapper to the function interpret() (which is private), and
 * that wrapper is responsible for getting calling context, setting an exception
 * trap (to clean up the stacks when an exception occurs) and removing all that
 * extra information when interpret() returns successfully.
 */
#define STACK_PRESERVE \
	struct dcall * volatile dtop;				\
	struct stdbchunk * volatile dcur;			\
	EIF_TYPED_VALUE * volatile stop;				\
	struct stopchunk * volatile scur

#define STACK_PRESERVE_FOR_OLD \
	struct dcall * volatile dtop_o;				\
	struct stdbchunk * volatile dcur_o;			\
	EIF_TYPED_VALUE * volatile stop_o;				\
	struct stopchunk * volatile scur_o


#define SAVE(stack,cur,top) \
	(cur) = (stack).st_cur;			\
	(top) = ((stack).st_cur ? (stack).st_cur->sk_top : NULL);

#define RESTORE(stack,cur,top) \
	if (cur) {								\
		(stack).st_cur = (cur);			\
		(cur)->sk_top = (top);			\
	} else { /* There was no chunk allocated when saving, but allocated at execution in between */ \
		(stack).st_cur = (stack).st_head; \
		(stack).st_cur->sk_top = (stack).st_cur->sk_arena;  \
	}

/* Macros to handle exceptions in routine body:
 * SET_RESCUE(rescue,exenv) - set rescue handler (if any)
 */

#define SET_RESCUE(r,e)                                                            \
	if (r) {                                                         \
			/* Set exception handler address. */                  \
		if (!setjmp(e)) {                                         \
				/* Register address to rescue on exception.*/ \
			exvect->ex_jbuf = &e;                             \
		}                                                             \
		else {                                                        \
				/* There is an exception. */                  \
				/* Jump to rescue clause. */                  \
			IC = r;                                          \
		}                                                             \
	}

rt_public void metamorphose_top(struct stopchunk * scur, EIF_TYPED_VALUE * volatile stop)
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	EIF_REFERENCE new_obj = NULL;
	uint32 head_type;
	EIF_TYPED_VALUE * last;	/* Last pushed value */
	unsigned long stagval;

	last = EIF_STACK_TOP_ADDRESS(op_stack);
	CHECK("last not null", last);
	if ((last->type & SK_HEAD) == SK_EXP)
		return; /* Leave an expanded object as is. */
	last = eif_opstack_pop_address(&op_stack);
	stagval = tagval;
	head_type = last->type & SK_HEAD;
	switch (head_type) {
	case SK_BOOL: new_obj = RTLN(egc_bool_dtype); *new_obj = last->it_char; break;
	case SK_CHAR8:	new_obj = RTLN(egc_char_dtype); *new_obj = last->it_char; break;
	case SK_CHAR32:	new_obj = RTLN(egc_wchar_dtype); *(EIF_CHARACTER_32 *) new_obj = last->it_wchar; break;
	case SK_UINT8: new_obj = RTLN(egc_uint8_dtype); *(EIF_NATURAL_8 *) new_obj = last->it_uint8; break;
	case SK_UINT16: new_obj = RTLN(egc_uint16_dtype); *(EIF_NATURAL_16 *) new_obj = last->it_uint16; break;
	case SK_UINT32: new_obj = RTLN(egc_uint32_dtype); *(EIF_NATURAL_32 *) new_obj = last->it_uint32; break;
	case SK_UINT64: new_obj = RTLN(egc_uint64_dtype); *(EIF_NATURAL_64 *) new_obj = last->it_uint64; break;
	case SK_INT8: new_obj = RTLN(egc_int8_dtype); *(EIF_INTEGER_8 *) new_obj = last->it_int8; break;
	case SK_INT16: new_obj = RTLN(egc_int16_dtype); *(EIF_INTEGER_16 *) new_obj = last->it_int16; break;
	case SK_INT32: new_obj = RTLN(egc_int32_dtype); *(EIF_INTEGER_32 *) new_obj = last->it_int32; break;
	case SK_INT64: new_obj = RTLN(egc_int64_dtype); *(EIF_INTEGER_64 *) new_obj = last->it_int64; break;
	case SK_REAL32: new_obj = RTLN(egc_real32_dtype); *(EIF_REAL_32 *) new_obj = last->it_real32; break;
	case SK_REAL64: new_obj = RTLN(egc_real64_dtype); *(EIF_REAL_64 *) new_obj = last->it_real64; break;
	case SK_POINTER: new_obj = RTLN(egc_point_dtype); *(EIF_REFERENCE *) new_obj = last->it_ptr; break;
	case SK_REF:			/* Had to do this for bit operations */
		new_obj = last->it_ref;
		break;
	default:
		eif_panic("illegal metamorphose type");
	}
	last = eif_opstack_push_empty(&op_stack);
	last->type = SK_REF;
	last->it_ref = new_obj;
	if (tagval != stagval)				/* If G.C calls melted dispose */
		sync_registers(scur, stop);
}

rt_public void xinterp(unsigned char *icval, rt_uint_ptr nb_pushed)
{
	/* Starts interpretation at IC = icval. It is the interpreter entry
	 * point for C code. When an exception occurs in the interpreted
	 * code, before propagating it to the C code, the operational stack
	 * must be cleaned.
	 */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	jmp_buf exenv;			/* C code call to interpreter exec. vector */
	STACK_PRESERVE;			/* Stack contextual informations */
	EIF_OBJECT volatile se = NULL;	/* Protected existing exception object */
	EIF_REFERENCE la = NULL;/* Last exception object, used to save RTLA */
	RTXDR;					/* Store stack contexts */

	/* Protect the existing exception object if any */
	la = RTLA;
	if (la){
		se = eif_protect (la);
	}

	IC = icval;				/* Where interpretation starts */
	tagval++;				/* One more call to interpreter */

	/* Initialization of the calling context. This is used by the debugger to
	 * actually fetch local context and get values of parameters and locals out
	 * of the operational stack.
	 */

	dstart();					/* Get calling record */
	SAVE(db_stack, dcur, dtop);	/* Save debugger stack */
	SAVE(op_stack, scur, stop);	/* Save operation stack */


	/* Recoding a pseudo execution vector in the Eiffel execution stack gives
	 * us a hook for bactracking: the exception mechanism will honor the
	 * setjmp buffer we place in it, so that control is transfered back here
	 * for clean-up. But other than that, the pseudo vector is ignored.
	 */

	excatch(&exenv);	/* Record pseudo execution vector */

	/* If we return from a longjmp, an exception has occurred. We restore the
	 * saved debugging context, then extract the top record to also restore the
	 * operational stack context. Once this clean-up is done, the exception is
	 * propagated.
	 */

	if (setjmp(exenv)) {
		RTXSC;							/* Restore stack contexts */
		RESTORE(db_stack, dcur, dtop);	/* Restore debugger stack */
		RESTORE(op_stack, scur, stop);	/* Restore operation stack */
		if (nb_pushed) {
			eif_opstack_npop(&op_stack, nb_pushed);				/* Removed the pushed arguments. */
		}
		if (se){						/* Release exception object */
			eif_wean (se);
		}
		eif_dbstack_pop_address(&db_stack);							/* Pop off our own record */
		ereturn(MTC_NOARG);						/* Propagate exception */
	}

#ifdef DEBUG
	if (DEBUG & 4) {
		fprintf(stdout, "****************** begin melted Feature *************\n");
		idump(stdout, IC);				/* Dump byte code for feature */
		fprintf(stdout, "****************** end melted feature ***************\n");
	}
#endif

	/* Normal execution procedure: interpret the byte code as a compound and,
	 * upon successful return, remove the execution vector on top of the Eiffel
	 * stack.
	 */
	(void) interpret(MTC INTERP_CMPD, 0);	/* Start interpretation */

	/* Release protection on the exception object */
	if (se){
		set_last_exception (eif_access (se));
		eif_wean (se);
	} else {
		set_last_exception ((EIF_REFERENCE) 0); /* Clean `last_exception' */
	}

	expop(&eif_stack);					/* Pop pseudo vector */
	eif_dbstack_pop_address(&db_stack);								/* Remove calling context */
}

rt_public void xiinv(unsigned char *icval, int where)

				/* Invariant checked after or before ? */
{
	/* Starts interpretation of invariant at IC = icval. */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	jmp_buf exenv;			/* C code call to interpreter exec. vector */
	STACK_PRESERVE;			/* Stack contextual informations */
	EIF_OBJECT volatile se = NULL;	/* Protected existing exception object */
	EIF_REFERENCE la = NULL;/* Last exception object, used to save RTLA */
	RTXDR;					/* Save stack contexts */

	/* Protect the existing exception object if any */
	la = RTLA;
	if (la){
		se = eif_protect (la);
	}

	IC = icval;					/* Where interpretation starts */
	tagval++;					/* One more call to interpreter */
	dstart();					/* Get calling record */
	SAVE(db_stack, dcur, dtop);	/* Save debugger stack */
	SAVE(op_stack, scur, stop);	/* Save operation stack */
	excatch(&exenv);	/* Record pseudo execution vector */

	if (setjmp(exenv)) {
		RTXSC;							/* Restore stack contexts */
		RESTORE(db_stack, dcur, dtop);	/* Restore debugger stack */
		RESTORE(op_stack, scur, stop);	/* Restore operation stack */
		if (se){						/* Release exception object */
			eif_wean (se);
		}
		eif_dbstack_pop_address(&db_stack);							/* Remove calling context */
		ereturn(MTC_NOARG);						/* Propagate exception */
	}

	(void) interpret(MTC INTERP_INVA, where);

	/* Release protection on the exception object */
	if (se){
		set_last_exception (eif_access (se));
		eif_wean (se);
	} else {
		set_last_exception ((EIF_REFERENCE) 0); /* Clean `last_exception' */
	}

	expop(&eif_stack);					/* Pop pseudo vector */
	eif_dbstack_pop_address(&db_stack);								/* Remove calling context */
}

rt_public void xinitint(void)
{
	/* Creation of the register array. */
	RT_GET_CONTEXT

	iregsz = REGISTER_SIZE * sizeof(EIF_TYPED_VALUE *);
	iregs = (EIF_TYPED_VALUE **) cmalloc(iregsz);
	if (iregs == (EIF_TYPED_VALUE **) 0)	/* Not enough room */
		enomem(MTC_NOARG);
}

#ifdef EIF_THREADS
/*
 * Create request chain wait until they are ready.
 */
rt_private void initialize_request_chain (void)
{
	/* Define indirect variable that is used to keep track of request chain stack. */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	RTS_SD;
	uint32 n;

		/* Register reference arguments. */
	for (n = argnum; n > 0; n--) {
		EIF_TYPED_VALUE *last = arg(n);
			/* TODO: RS: Why only register arguments when they're uncontrolled in the interpreter? */
		if ((last -> type & SK_HEAD) == SK_REF && RTS_OU (last -> it_ref)) {
			RTS_RS (last->it_ref);
		}
	}
		/* Wait for arguments to be locked. */
	RTS_RW;
}
#endif /* EIF_THREADS */

rt_private void interpret(int flag, int where)
					/* Flag set to INTERP_INVA or INTERP_CMPD */
					/* Are we checking invariant before or after compound? */
{
	/* Interprets the byte-code starting at IC. For effeciency reasons, some
	 * "globals" are used by the main interpreting loop, to save some precious
	 * CPU cycles--RAM.
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	int volatile code;			/* Current intepreted byte code */
	EIF_TYPED_VALUE *last;	/* Last pushed value */
	long volatile offset = 0;			/* Offset for jumps and al */
	long volatile offset_n = 0;		/* Nested Offset for jumps and al */
	unsigned char * volatile string;		/* Strings for assertions tag */
	EIF_TYPE_INDEX volatile type;			/* Often used to hold type values */
	EIF_TYPE volatile l_creation_type;		/* To hold creation type. */
	uint32 sk_type;
	int volatile saved_assertion;
	EIF_NATURAL_32 volatile saved_caller_assertion_level = caller_assertion_level;	/* Saves the assertion level of the caller*/
	unsigned char * volatile rescue = NULL;	/* Location of rescue clause */
	jmp_buf exenv;							/* In case we have to setjmp() */
	jmp_buf exenvo;							/* For exception during once evaluation */
	EIF_REFERENCE volatile saved_except_for_old = NULL;	/* Saved exception object for old expression evaluation */
	int ex_pos;								/* Exception object local position */
	unsigned char * volatile IC_O;			/* Backup IC for old evaluation */
	long volatile offset_o;					/* Offset for jump to the next BC_OLD/BC_END_OLD_EVAL */
	struct ex_vect * volatile exvect;		/* Routine's execution vector */
   	uint32 volatile db_cstack;				/* Debugger level depth */
	EIF_TYPED_VALUE * volatile stop = NULL;	/* To save stack context */
	struct stopchunk * volatile scur = NULL;	/* Current chunk (stack context) */
#ifdef ISE_GC
	EIF_REFERENCE ** volatile l_top = NULL;			/* Local top */
	struct stoachunk * volatile l_cur = NULL;	/* Current local chunk */
	EIF_REFERENCE ** volatile ls_top = NULL;			/* loc_stack top */
	struct stoachunk * volatile ls_cur = NULL;/* Current loc_stack chunk */
#endif
	int volatile assert_type = 0;			/* Assertion type */
	char volatile pre_success = (char) 0;	/* Flag for precondition success */
	uint32 volatile rtype = 0;				/* Result type */
	MTOT volatile OResult = (MTOT) 0;		/* Item for once data */
#ifdef EIF_THREADS
	EIF_process_once_value_t * volatile POResult = NULL;	/* Process-relative once data */
	int volatile is_process_once = 0;		/* Is once routine process-relative? */
	uint32 volatile uarg = 0;			/* Number of uncontrolled arguments */
	EIF_NATURAL_64 volatile usep = 0;                       /* Bit mask for uncontrolled separate arguments. */
	unsigned char * volatile pre_start = 0;		/* Start of a precondition. */
	char volatile has_wait_condition = '\0';        /* Is there a wait condition? */
	char volatile has_uncontrolled_argument = '\0'; /* Is uncontrolled argument used? */
	RTS_SDX;			/* Declarations for SCOOP */
	RTS_SDC;
#endif
	BODY_INDEX body_id = 0;		/* Body id of routine */
	int routine_id = 0;
	int volatile current_trace_level = 0;	/* Saved call level for trace, only needed when routine is retried */
	struct stpchunk * volatile saved_prof_chunk = NULL;	/* Saved top of `prof_stack' */
	struct prof_info * volatile l_saved_prof_top = NULL;

	long volatile once_key = 0;				/* Index in once table */
	uint32 volatile once_end_break_index = 0;				/* Index in once table */
	int  volatile is_process_or_thread_relative_once = 0;	/* Is it a process or thread relative once routine? */
	int  volatile is_object_relative_once = 0;				/* Is it a object relative once routine? */

	int  volatile create_result = 1;			/* Should result be created? */
	RTSN;							/* Save nested flag */
	STACK_PRESERVE_FOR_OLD;

	saved_assertion = in_assertion;
	exvect = NULL;
	db_cstack = 0;

	switch (*IC++)
	{
	case ONCE_MARK_THREAD_RELATIVE:
		is_process_or_thread_relative_once = 1;
		once_key = get_int32(&IC);
		once_end_break_index = get_uint32(&IC);
		break;
#ifdef EIF_THREADS
	case ONCE_MARK_PROCESS_RELATIVE:
		is_process_or_thread_relative_once = 1;
		is_process_once = 1;
		once_key = get_int32(&IC);
		once_end_break_index = get_uint32(&IC);
		break;
#endif
	case ONCE_MARK_OBJECT_RELATIVE:
		is_object_relative_once = 1;
		once_end_break_index = get_uint32(&IC);
		break;
	case ONCE_MARK_ATTRIBUTE:
		create_result = 0;
		break;
	}

	for (;;) {
#ifdef DEBUG
	dprintf(2)("0x%lX: ", IC);
#endif

	switch (code = *IC++) {		/* Read current byte-code and advance IC */

	/*
	 * Start of routine byte code.
	 */
	case BC_START:
#ifdef DEBUG
		dprintf(2)("BC_START\n");
#endif
	 	(void) get_int32(&IC);	/* Get the routine id, currently not used */
		body_id = (BODY_INDEX) get_int32(&IC);	/* Get the body id */
		rtype = get_uint32(&IC);				/* Get the result type */
		argnum = get_int16(&IC);			/* Get the argument number */
		locnum = get_int16(&IC);		/* Get the local number */
		init_registers(MTC);		/* Initialize the registers */
		caller_assertion_level = WASC(icur_dtype) & CK_SUP_REQUIRE;	/* Set the caller assertion level */

		/* Argument normalization and expanded clone of arguments (if any). */
		{
			uint32 n;
			for (n = 1; n <= argnum; n++) {
				EIF_REFERENCE ref;

				last = arg(n);
				ref = last->it_ref;
				switch (get_uint8(&IC)) {
				case EIF_EXPANDED_CODE_EXTENSION:
					if (ref == NULL)
						xraise(EN_VEXP);	/* Void assigned to expanded */
					RT_GC_PROTECT(ref);
					type = get_compound_id(MTC icurrent->it_ref);
					last->it_ref = RTLN(type);
					RT_GC_WEAN(ref);
					last->type = SK_EXP;
					eif_std_ref_copy(ref, last->it_ref);
					break;
				case EIF_REFERENCE_CODE:
#ifdef EIF_THREADS
					if (RTS_OU(ref)) {
						usep |= ((EIF_NATURAL_64) 1) << (n - 1);
						uarg++;
					}
#endif
					break;
				case EIF_BOOLEAN_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_bool = *(EIF_BOOLEAN *) ref;
						last -> type = SK_BOOL;
					}
					break;
				case EIF_CHARACTER_8_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_char = *(EIF_CHARACTER_8 *) ref;
						last -> type = SK_CHAR8;
					}
					break;
				case EIF_REAL_64_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_real64 = *(EIF_REAL_64 *) ref;
						last -> type = SK_REAL64;
					}
					break;
				case EIF_REAL_32_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_real32 = *(EIF_REAL_32 *) ref;
						last -> type = SK_REAL32;
					}
					break;
				case EIF_POINTER_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_ptr = *(EIF_POINTER *) ref;
						last -> type = SK_POINTER;
					}
					break;
				case EIF_INTEGER_8_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_int8 = *(EIF_INTEGER_8 *) ref;
						last -> type = SK_INT8;
					}
					break;
				case EIF_INTEGER_16_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_int16 = *(EIF_INTEGER_16 *) ref;
						last -> type = SK_INT16;
					}
					break;
				case EIF_INTEGER_32_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_int32 = *(EIF_INTEGER_32 *) ref;
						last -> type = SK_INT32;
					}
					break;
				case EIF_INTEGER_64_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_int64 = *(EIF_INTEGER_64 *) ref;
						last -> type = SK_INT64;
					}
					break;
				case EIF_NATURAL_8_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_uint8 = *(EIF_NATURAL_8 *) ref;
						last -> type = SK_UINT8;
					}
					break;
				case EIF_NATURAL_16_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_uint16 = *(EIF_NATURAL_16 *) ref;
						last -> type = SK_UINT16;
					}
					break;
				case EIF_NATURAL_32_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_uint32 = *(EIF_NATURAL_32 *) ref;
						last -> type = SK_UINT32;
					}
					break;
				case EIF_NATURAL_64_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_uint64 = *(EIF_NATURAL_64 *) ref;
						last -> type = SK_UINT64;
					}
					break;
				case EIF_CHARACTER_32_CODE:
					if ((last->type & SK_HEAD) == SK_REF) {
						last -> it_wchar = *(EIF_CHARACTER_32 *) ref;
						last -> type = SK_CHAR32;
					}
					break;
				}
			}
		}

		init_var(iresult, rtype, icurrent->it_ref);
		if (is_process_or_thread_relative_once) {	/* If it is a once */
#ifdef EIF_THREADS
			if (is_process_once) {
				POResult = EIF_process_once_values + once_key;
				OResult = &(POResult -> value);
			}
			else
#endif
				/* MTOI = MT Once Item */
			OResult = MTOI(once_key);
		}

		switch(flag) {				/* What are we interpreting? */
		case INTERP_CMPD:			/* A compound (i.e. Eiffel feature) */
			string = get_string8(&IC, -1);
			type = get_int16(&IC);		/* Dynamic type where feature is written */

			/* Get an execution vector for the current feature, and link it
			 * with the current debugging calling context. It is important to
			 * have those pointers from the calling context into the Eiffel
			 * stack when dumping the execution stack (because we are able to
			 * compute the relative position of the features recorded in that
			 * calling context wrt the global execution flow in the Eiffel
			 * stack).
			 */
			RTEAA((char *) string, type, (icurrent->it_ref), (unsigned char)locnum, (unsigned char)argnum, body_id);
			RTDBGEAA(type, (icurrent->it_ref), body_id);
			dexset(exvect);
				/* Save stack context */
			SAVE(op_stack, scur, stop);
			interp_check_options_start(eoption + icur_dtype, icur_dtype, scur, stop);
			dostk();					/* Record position in calling context */
			if (is_nested > 0)
				icheck_inv(MTC icurrent->it_ref, scur, stop, 0);	/* Invariant before feature application */

#ifdef DEBUG
			dprintf(1)("\tFeature %s written in %s on 0x%lx [%s]\n",
				string, System(type).cn_generator,
				icurrent->it_ref, System(Dtype(icurrent->it_ref)).cn_generator);
#endif
			break;

		case INTERP_INVA:			/* An invariant */
			string = get_string8(&IC, -1);
			type = get_int16(&IC);		/* Dynamic type where feature is written */
#ifdef DEBUG
		dprintf(1)("\tInvariant on 0x%lx [%s]\n",
			icurrent->it_ref, System(Dtype(icurrent->it_ref)).cn_generator);
#endif

			RTEAINV((char *) string, type, (icurrent->it_ref), (unsigned char)locnum, 0 /* Invariant has no body id for now */);
			dexset(exvect);
				/* Save stack context */
			SAVE(op_stack, scur, stop);
			interp_check_options_start(eoption + icur_dtype, icur_dtype, scur, stop);
			dostk();					/* Record position in calling context */
			break;

		default:
			eif_panic(MTC RT_BOTCHED_MSG);
		}

		rescue = NULL;		/* No rescue */
		if (*IC++) {
			offset = get_int32(&IC);	/* Fetch rescue offset */
			rescue = IC + offset;	/* Compute rescue start */
		}

		if (flag == INTERP_CMPD) {
			if (rescue) {	/* If there is a rescue clause */
#ifdef ISE_GC
				SAVE(loc_set, l_cur, l_top);		/* Save C local stack */
				SAVE(loc_stack, ls_cur, ls_top);	/* Save loc_stack */
#endif
				current_trace_level = trace_call_level;	/* Save trace call level */
				saved_prof_chunk = prof_stack.st_cur;
				l_saved_prof_top = (saved_prof_chunk ? saved_prof_chunk->sk_top : NULL);
			}

		}
#ifdef EIF_THREADS
			/* Initialize request chain if required. */
		if (uarg) {
			RTS_RCX;
			initialize_request_chain ();
		}
#endif

			/* Locals need to be allocated before any precondition checks
			 * in case they are used in the preconditions. */
		create_expanded_locals (scur, stop);
		if ((*IC != BC_PRECOND) && (*IC != BC_START_CATCALL)) {
			goto enter_body; /* Start execution of a routine body. */
		}
		break;

	/*
	 * Deferred compound mark.
	 */
	case BC_DEFERRED:
#ifdef DEBUG
		 dprintf(2)("BC_DEFERRED\n");
#endif
		break;


	case BC_TRY:
#ifdef DEBUG
		dprintf(2)("BC_TRY\n");
#endif
		{
			unsigned char * volatile except_part = NULL;	/* Location of try except clause */
			if (*IC++) {
				offset = get_int32(&IC);	/* Fetch except_part offset */
				except_part = IC + offset;	/* Compute except_part start */
			}
			if (except_part) {

					/* Declare variables for exception handling. */

				struct ex_vect * exvecto;

					/* Record execution vector to catch exception. */
				exvecto = extre();
					/* Set catch address. */
				exvect->ex_jbuf = &exenvo;
					/* Update routine exception vector. */
				exvect = exvecto;
				dexset(exvect);

					/* Set exception handler address. */
				if (setjmp(exenvo)) {
						/* There is an exception. */
					IC = except_part;
				}
			}
		}
		break;

	case BC_TRY_END:
#ifdef DEBUG
		dprintf(2)("BC_TRY_END\n");
#endif
				/* Remove execution vector to restore    */
				/* previous exception catch point.       */
		exvect = extrl();
		dexset(exvect);
		break;

	case BC_TRY_END_EXCEPT:
#ifdef DEBUG
		dprintf(2)("BC_TRY_END_EXCEPT\n");
#endif
		/* Propagate the exception */
		ereturn();
		break;

	/*
	 * Do+Rescue clause
	 */
	case BC_DO_RESCUE:
#ifdef DEBUG
		dprintf(2)("BC_DO_RESCUE\n");
#endif
		rescue = NULL; /* no rescue */
		if (*IC++) {
			offset = get_int32(&IC);	/* Fetch rescue offset */
			rescue = IC + offset;		/* Compute rescue start */

			if (flag == INTERP_CMPD) {
				if (rescue) {	/* If there is a rescue clause */
					SAVE(op_stack, scur, stop);

#ifdef ISE_GC
					SAVE(loc_set, l_cur, l_top);		/* Save C local stack */
					SAVE(loc_stack, ls_cur, ls_top);	/* Save loc_stack */
#endif
					current_trace_level = trace_call_level;	/* Save trace call level */
					saved_prof_chunk = prof_stack.st_cur;
					l_saved_prof_top = (saved_prof_chunk ? saved_prof_chunk->sk_top : NULL);
				}
			}

			SET_RESCUE(rescue,exenv);
		}

		break;

	case BC_DO_RESCUE_END:
#ifdef DEBUG
		dprintf(2)("BC_DO_RESCUE_END\n");
#endif
		/* compound passes without exception raised */
		break;

	/*
	 * Rescue clause beginning
	 */
	case BC_RESCUE:
#ifdef DEBUG
		dprintf(2)("BC_RESCUE\n");
#endif
		RESTORE(op_stack, scur, stop);
#ifdef ISE_GC
		RESTORE(loc_set, l_cur, l_top);
		RESTORE(loc_stack, ls_cur, ls_top);
#endif
#ifdef EIF_THREADS
		if (rt_globals->eif_thr_context_cx->is_processor) {
			RTS_SRR;
		}
#endif
		sync_registers(MTC scur, stop);
		CHECK("exvect not null", exvect);
		RTEU;
		break;

	/*
	 * Retry instruction
	 */
	case BC_RETRY:
#ifdef DEBUG
		dprintf(2)("BC_RETRY\n");
#endif
		trace_call_level = current_trace_level;
		if (saved_prof_chunk) {
			prof_stack_rewind(l_saved_prof_top);
		}
		in_assertion = saved_assertion;		/* restore saved assertion checking because
											 * we might have reached this code from
											 * an assertion checking code. */
		offset = get_int32(&IC);				/* Get the retry offset */
		IC += offset;
		exvect = exret(MTC exvect);			/* Retries a routine */
			/* Set rescue handler that was reset by the exception. */
		SET_RESCUE(rescue,exenv);
		break;

	/*
	 * Start of precondition(s).
	 */
	case BC_PRECOND:
#ifdef DEBUG
		dprintf(2)("BC_PRECOND\n");
#endif
#ifdef EIF_THREADS
			/* Record offset of a precondition block to repeat the check
			   for failing wait conditions. */
		pre_start = IC - 1;
		has_wait_condition = '\0';
		has_uncontrolled_argument = '\0';
#endif
		offset = get_int32(&IC);
		pre_success = '\01';
		if (
#ifdef EIF_THREADS
			!uarg &&
#endif /* EIF_THREADS */
			!(~in_assertion & ((WASC(icur_dtype) & CK_REQUIRE) | saved_caller_assertion_level))
		) {
				/* No precondition check? */
			IC += offset; /* Skip preconditions */
			goto enter_body; /* Start execution of a routine body. */
		}
		break;

	/*
	 * Start of postcondition(s).
	 */
	case BC_POSTCOND:
#ifdef DEBUG
		dprintf(2)("BC_POSTCOND\n");
#endif
		offset = get_int32(&IC);
		if (!(~in_assertion & WASC(icur_dtype) & CK_ENSURE))	/* No postcondition check? */
			IC += offset;						/* Skip postconditions */
		break;

	case BC_POSTFAIL:
#ifdef DEBUG
		dprintf(2)("BC_POSTFAIL\n");
#endif
		RTCT0((char *) 0, EX_POST);
		RTCF0;
		break;

		/* Catcall handling. */
	case BC_START_CATCALL:
		break;

	case BC_CATCALL:
		{
			EIF_TYPE_INDEX l_written_dtype, l_annotations;
			int l_pos;

			l_creation_type = get_creation_type();
			l_annotations = get_int16(&IC);
			l_written_dtype = get_int16(&IC);
			string = get_string8(&IC, get_int32(&IC));
			l_pos = get_int32(&IC);

			last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", last);
			RTCC(last->it_ref, l_written_dtype, (char *) string, l_pos, l_creation_type, l_annotations);
		}
		break;

	case BC_TUPLE_CATCALL:
		{
			EIF_TYPED_VALUE *l_elem;
			EIF_TYPE_INDEX l_written_dtype;
			EIF_TYPE l_dftype;
			int l_pos;

				/* Get the routine were the TUPLE assignment is done and at which position. */
			l_written_dtype = get_int16(&IC);
			string = get_string8(&IC, get_int32(&IC));
			l_pos = get_int32(&IC);

				/* Pop the element we want to insert to get to the TUPLE object. */
			l_elem = eif_opstack_pop_address(&op_stack);
				/* The TUPLE object. */
			last = EIF_STACK_TOP_ADDRESS(op_stack);
				/* We put back the element on the stack. */
			eif_opstack_push_address(&op_stack, l_elem);
			CHECK("last not null", last);

			l_dftype = eif_gen_param(Dftype(last->it_ref), l_pos);
			RTCC(l_elem->it_ref, l_written_dtype, (char *) string, l_pos, l_dftype, 0);
		}
		break;

	case BC_END_CATCALL:
		if (*IC != BC_PRECOND) {
			goto enter_body; /* Start execution of a routine body. */
		}
		break;

	/*
	 * Cast of a numeric type
	 */

	case BC_CAST_NATURAL:
		offset = get_int32(&IC);	/* Get natural size */
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		switch (last->type & SK_HEAD) {
			case SK_BOOL:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) (last->it_char ? 1 : 0); break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) (last->it_char ? 1 : 0); break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) (last->it_char ? 1 : 0); break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) (last->it_char ? 1 : 0); break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_CHAR8:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_char; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_char; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_char; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_char; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_CHAR32:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_wchar; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_wchar; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_wchar; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_wchar; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_UINT8:
				switch (offset) {
					case 8: break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_uint8; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_uint8; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_uint8; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_UINT16:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_uint16; break;
					case 16: break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_uint16; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_uint16; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_UINT32:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_uint32; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_uint32; break;
					case 32: break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_uint32; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_UINT64:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_uint64; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_uint64; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_uint64; break;
					case 64: break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_INT8:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_int8; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_int8; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_int8; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_int8; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_INT16:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_int16; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_int16; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_int16; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_int16; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_INT32:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_int32; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_int32; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_int32; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_int32; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_INT64:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_int64; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_int64; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_int64; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_int64; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_REAL32:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_real32; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_real32; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_real32; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) ((EIF_INTEGER_64) last->it_real32); break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_REAL64:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_real64; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_real64; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_real64; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) ((EIF_INTEGER_64) last->it_real64); break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_POINTER:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) (rt_uint_ptr) last->it_ptr; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) (rt_uint_ptr) last->it_ptr; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) (rt_uint_ptr) last->it_ptr; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) (rt_uint_ptr) last->it_ptr; break;
					default:
						eif_panic ("Illegal type");
				}
				break;

			default:
				eif_panic (MTC "Illegal cast operation");
			}
		switch (offset) {
			case 8: last->type = SK_UINT8; break;
			case 16: last->type = SK_UINT16; break;
			case 32: last->type = SK_UINT32; break;
			case 64: last->type = SK_UINT64; break;
			default:
				eif_panic ("Illegal type");
		}
		break;


	case BC_CAST_INTEGER:
#ifdef DEBUG
		dprintf(2)("BC_CAST_INTEGER\n");
#endif
		offset = get_int32(&IC);	/* Get integer size */
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		switch (last->type & SK_HEAD) {
			case SK_BOOL:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) (last->it_char ? 1 : 0); break;
					case 16: last->it_int16 = (EIF_INTEGER_16) (last->it_char ? 1 : 0); break;
					case 32: last->it_int32 = (EIF_INTEGER_32) (last->it_char ? 1 : 0); break;
					case 64: last->it_int64 = (EIF_INTEGER_64) (last->it_char ? 1 : 0); break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_CHAR8:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_char; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_char; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_char; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_char; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_CHAR32:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_wchar; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_wchar; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_wchar; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_wchar; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_UINT8:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_uint8; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_uint8; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_uint8; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_uint8; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_UINT16:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_uint16; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_uint16; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_uint16; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_uint16; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_UINT32:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_uint32; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_uint32; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_uint32; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_uint32; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_UINT64:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_uint64; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_uint64; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_uint64; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_uint64; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_INT8:
				switch (offset) {
					case 8: break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_int8; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_int8; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_int8; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_INT16:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_int16; break;
					case 16: break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_int16; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_int16; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_INT32:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_int32; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_int32; break;
					case 32: break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_int32; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_INT64:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_int64; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_int64; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_int64; break;
					case 64: break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_REAL32:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_real32; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_real32; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_real32; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_real32; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_REAL64:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_real64; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_real64; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_real64; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_real64; break;
					default:
						eif_panic ("Illegal type");
				}
				break;
			case SK_POINTER:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) (rt_uint_ptr) last->it_ptr; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) (rt_uint_ptr) last->it_ptr; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) (rt_uint_ptr) last->it_ptr; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) (rt_uint_ptr) last->it_ptr; break;
					default:
						eif_panic ("Illegal type");
				}
				break;

			default:
				eif_panic (MTC "Illegal cast operation");
			}
		switch (offset) {
			case 8: last->type = SK_INT8; break;
			case 16: last->type = SK_INT16; break;
			case 32: last->type = SK_INT32; break;
			case 64: last->type = SK_INT64; break;
			default:
				eif_panic ("Illegal type");
		}
		break;

	/*
	 * Cast of a numeric type
	 */

	case BC_CAST_REAL_32:
#ifdef DEBUG
		dprintf(2)("BC_CAST_REAL_32\n");
#endif
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		switch (last->type & SK_HEAD) {
			case SK_UINT8: last->it_real32 = (EIF_REAL_32) last->it_uint8; break;
			case SK_UINT16: last->it_real32 = (EIF_REAL_32) last->it_uint16; break;
			case SK_UINT32: last->it_real32 = (EIF_REAL_32) last->it_uint32; break;
			case SK_UINT64: last->it_real32 = eif_uint64_to_real32(last->it_uint64); break;
			case SK_INT8: last->it_real32 = (EIF_REAL_32) last->it_int8; break;
			case SK_INT16: last->it_real32 = (EIF_REAL_32) last->it_int16; break;
			case SK_INT32: last->it_real32 = (EIF_REAL_32) last->it_int32; break;
			case SK_INT64: last->it_real32 = (EIF_REAL_32) last->it_int64; break;
			case (SK_REAL64): last->it_real32 = (EIF_REAL_32) last->it_real64; break;
			case SK_REAL32: break;
			default:
				eif_panic (MTC "Illegal cast operation");
			}
		last->type = SK_REAL32;
		break;

	/*
	 * Cast of a numeric type
	 */

	case BC_CAST_REAL_64:
#ifdef DEBUG
		dprintf(2)("BC_CAST_REAL_64\n");
#endif
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		switch (last->type & SK_HEAD) {
			case SK_UINT8: last->it_real64 = (EIF_REAL_64) last->it_uint8; break;
			case SK_UINT16: last->it_real64 = (EIF_REAL_64) last->it_uint16; break;
			case SK_UINT32: last->it_real64 = (EIF_REAL_64) last->it_uint32; break;
			case SK_UINT64: last->it_real64 = eif_uint64_to_real64 (last->it_uint64); break;
			case SK_INT8: last->it_real64 = (EIF_REAL_64) last->it_int8; break;
			case SK_INT16: last->it_real64 = (EIF_REAL_64) last->it_int16; break;
			case SK_INT32: last->it_real64 = (EIF_REAL_64) last->it_int32; break;
			case SK_INT64: last->it_real64 = (EIF_REAL_64) last->it_int64; break;
			case SK_REAL32: last->it_real64 = (EIF_REAL_64) last->it_real32; break;
			case SK_REAL64: break;
			default:
				eif_panic (MTC "Illegal cast operation");
			}
		last->type = SK_REAL64;
		break;

	/*
	 * Cast to CHARACTER_8
	 */

	case BC_CAST_CHAR8:
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		switch (last->type & SK_HEAD) {
			case SK_UINT8: last->it_char = (EIF_CHARACTER_8) last->it_uint8; break;
			case SK_UINT16: last->it_char = (EIF_CHARACTER_8) last->it_uint16; break;
			case SK_UINT32: last->it_char = (EIF_CHARACTER_8) last->it_uint32; break;
			case SK_UINT64: last->it_char = (EIF_CHARACTER_8) last->it_uint64; break;
			case SK_INT8: last->it_char = (EIF_CHARACTER_8) last->it_int8; break;
			case SK_INT16: last->it_char = (EIF_CHARACTER_8) last->it_int16; break;
			case SK_INT32: last->it_char = (EIF_CHARACTER_8) last->it_int32; break;
			case SK_INT64: last->it_char = (EIF_CHARACTER_8) last->it_int64; break;
			case SK_CHAR8: break;
			case SK_CHAR32: last->it_char = (EIF_CHARACTER_8) last->it_wchar; break;
			}
		last->type = SK_CHAR8;
		break;

	/*
	 * Cast to CHARACTER_32
	 */

	case BC_CAST_CHAR32:
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		switch (last->type & SK_HEAD) {
			case SK_UINT8: last->it_wchar = (EIF_CHARACTER_32) last->it_uint8; break;
			case SK_UINT16: last->it_wchar = (EIF_CHARACTER_32) last->it_uint16; break;
			case SK_UINT32: last->it_wchar = (EIF_CHARACTER_32) last->it_uint32; break;
			case SK_UINT64: last->it_wchar = (EIF_CHARACTER_32) last->it_uint64; break;
			case SK_INT8: last->it_wchar = (EIF_CHARACTER_32) last->it_int8; break;
			case SK_INT16: last->it_wchar = (EIF_CHARACTER_32) last->it_int16; break;
			case SK_INT32: last->it_wchar = (EIF_CHARACTER_32) last->it_int32; break;
			case SK_INT64: last->it_wchar = (EIF_CHARACTER_32) last->it_int64; break;
			case SK_CHAR8: last->it_wchar = (EIF_CHARACTER_32) last->it_char; break;
			case SK_CHAR32: break;
			}
		last->type = SK_CHAR32;
		break;



	/*
	 * Assignment to result.
	 */
	case BC_RASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_RASSIGN\n");
#endif

		RTDBGA_LOCAL(0,rtype,0,1);
		memcpy (iresult, eif_opstack_pop_address(&op_stack), ITEM_SZ);
		/* Register once function if needed. This has to be done constantly
		 * whenever the Result is changed, in case the once calls another
		 * feature which is going to call this once feature again.
		 */
		if (is_process_or_thread_relative_once) {
			CHECK("OResult not null", OResult);
			put_once_result (iresult, rtype, OResult);
		}
		break;

	/*
	 * Assignment to an expanded result
	 */
	case BC_REXP_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_REXP_ASSIGN\n");
#endif
		{	EIF_REFERENCE ref = eif_opstack_pop_address(&op_stack)->it_ref;

			if (ref == NULL)
				xraise(EN_VEXP);	/* Void assigned to expanded */

			RTDBGA_LOCAL(0,rtype,1,1);
			eif_std_ref_copy(ref, iresult->it_ref);
			if (is_process_or_thread_relative_once) {
				last = iresult;
				switch (rtype & SK_HEAD) {	/* Result type held in rtype */
				case SK_EXP:
				case SK_REF:	/* See below */
					CHECK("OResult not null", OResult);
					*(OResult->result.EIF_REFERENCE_result) = last->it_ref;
					break;
				}
			}

		}
		break;

	/*
	 * Assignment to local variable.
	 */
	case BC_LASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_LASSIGN\n");
#endif
		code = get_int16(&IC);		/* Get the local number (from 1 to locnum) */
		RTDBGA_LOCAL(code,loc (code)->type,0,1);
		memcpy (loc (code) , eif_opstack_pop_address(&op_stack), ITEM_SZ);
		break;

	/*
	 * Assignment to an expanded local
	 */
	case BC_LEXP_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_LEXP_ASSIGN\n");
#endif
		{	EIF_REFERENCE ref = eif_opstack_pop_address(&op_stack)->it_ref;

			if (ref == NULL) {
				xraise(EN_VEXP);	/* Void assigned to expanded */
			}
			code = get_int16(&IC);		/* Get the local # (from 1 to locnum) */
			RTDBGA_LOCAL(code,loc(code)->type,1,1);
			eif_std_ref_copy(ref, loc(code)->it_ref);		/* Copy */
		}
		break;

	/*
	 * Assignment to an attribute.
	 */
	case BC_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_ASSIGN\n");
#endif
		{
			uint32 l_type;
			long att_offset;

			routine_id = get_int32(&IC);		/* Get the routine ID */
			l_type = get_uint32(&IC);			/* Get attribute meta-type */
			att_offset = RTWA(routine_id, icur_dtype);
			RTDBGA_ATTRB(icurrent->it_ref,att_offset,l_type,0,0);
			assign(att_offset, l_type);
		}
		break;

	/*
	 * Attachment to an expanded attribute
	 */
	case BC_EXP_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_EXP_ASSIGN\n");
#endif
		{
			EIF_REFERENCE ref;
			long att_offset;

			ref = eif_opstack_pop_address(&op_stack)->it_ref;		/* Expression type */
			if (ref == (EIF_REFERENCE) 0) {
				xraise(EN_VEXP);		/* Void assigned to expanded */
			}
			routine_id = get_int32(&IC);		/* Get the routine ID */
			sk_type = get_uint32(&IC);		/* Get attribute meta-type */
			att_offset = RTWA(routine_id, icur_dtype);
			RTDBGA_ATTRB(icurrent->it_ref,att_offset,sk_type,1,0);
			eif_std_ref_copy (ref, icurrent->it_ref + att_offset);
		}
		break;

	/*
	 * Attachement to NONE entity
	 */
	case BC_NONE_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_NONE_ASSIGN\n");
#endif
		(void) eif_opstack_pop_address(&op_stack);
		break;

	/*
	 * Reverse assignment to Result.
	 */
	case BC_RREVERSE:
#ifdef DEBUG
		dprintf(2)("BC_RREVERSE\n");
#endif
		l_creation_type = get_creation_type();			/* Get the reverse type */
		last = EIF_STACK_TOP_ADDRESS(op_stack);

		if ((last->it_ref) && !eif_gen_conf2(eif_new_type(Dftype(last->it_ref), ATTACHED_FLAG), l_creation_type)) {
			last->it_ref = NULL;
		}
		reverse_local (iresult, l_creation_type.id);

		/* Register once function if needed. This has to be done constantly
		 * whenever the Result is changed, in case the once calls another
		 * feature which is going to call this once feature again.
		 */
		if (is_process_or_thread_relative_once) {
			CHECK("OResult not null", OResult);
			put_once_result (iresult, rtype, OResult);
		}
		break;

	/*
	 * Reverse assignment to a local variable.
	 */
	case BC_LREVERSE:
#ifdef DEBUG
		dprintf(2)("BC_LREVERSE\n");
#endif
		code = get_int16(&IC);			/* Get local number */
		l_creation_type = get_creation_type ();
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);

		if ((last->it_ref) && !eif_gen_conf2(eif_new_type(Dftype(last->it_ref), ATTACHED_FLAG), l_creation_type)) {
			last->it_ref = NULL;
		}
		reverse_local (loc(code), l_creation_type.id);
		break;

	/*
	 * Reverse assignment to an attribute.
	 */
	case BC_REVERSE:
#ifdef DEBUG
		dprintf(2)("BC_REVERSE\n");
#endif
		{
			uint32 meta;

			routine_id = get_int32(&IC);		/* Get the routine ID */
			meta = get_uint32(&IC);		/* Get the attribute meta-type */
			l_creation_type = get_creation_type ();
			last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", last);

			if ((last->it_ref) && !eif_gen_conf2(eif_new_type(Dftype(last->it_ref), ATTACHED_FLAG), l_creation_type)) {
				last->it_ref = NULL;
			}
			reverse_attribute (RTWA(routine_id, icur_dtype), meta);
		}
		break;

	/*
	 * Object test to an object test local.
	 */
	case BC_OBJECT_TEST:
#ifdef DEBUG
		dprintf(2)("BC_OBJECT_TEST\n");
#endif
		code = get_int16(&IC);			/* Get local number */
		l_creation_type = get_creation_type ();
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);

		if ((last->it_ref) && eif_gen_conf2(eif_new_type(Dftype(last->it_ref), ATTACHED_FLAG), l_creation_type)) {
				/* Perform reattachment. */
			reverse_local (loc(code), l_creation_type.id);
				/* Put True on the stack. */
			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_BOOL;
			last->it_char = EIF_TRUE;
		} else {
				/* Replace expression value with False. */
			last->type = SK_BOOL;
			last->it_char = EIF_FALSE;
		}
		break;

	/*
	 * Find out if an attribute type is declared attached at runtime.
	 */
	case BC_IS_ATTACHED_ATTRIBUTE:

			/* Continue with attribute access based on the routine ID. */
		routine_id = get_int32(&IC);				/* Get the routine ID */

		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_BOOL;

		last->it_char = eif_is_attached_type2(wtype_gen (routine_id, Dtype(icurrent->it_ref), Dftype(icurrent->it_ref)));
		break;

	/*
	 * Clone of a reference
	 */
	case BC_CLONE:
#ifdef DEBUG
		dprintf(2)("BC_CLONE\n");
#endif
		{	EIF_REFERENCE ref;

			last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", last);
			ref = last->it_ref;
			if (ref) {
				unsigned long stagval;
				unsigned char *OLD_IC;

				stagval = tagval;
				OLD_IC = IC;
				ref = RTRCL (ref);
				IC = OLD_IC;
				if (tagval != stagval)		/* previous call can call malloc which may
								 * call the interpreter for creation
								 * routines of expanded objects.
								 */
					sync_registers(MTC scur, stop);
				last->it_ref = ref;
			}
		}
		break;

	/*
	 * Conditional clone of an object if it is expanded
	 */
	case BC_CCLONE:
#ifdef DEBUG
		dprintf(2)("BC_CLONE\n");
#endif
		{	EIF_REFERENCE ref;
			unsigned long stagval;

			stagval = tagval;
			last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", last);
			ref = last->it_ref;
			if (ref && eif_is_boxed_expanded(HEADER(ref)->ov_flags)) {
				unsigned char *OLD_IC;
				OLD_IC = IC;
				last->it_ref = RTRCL (ref);
				IC = OLD_IC;
				if (tagval != stagval)		/* previous call can call malloc which may
								 * call the interpreter for creation
								 * routines of expanded objects.
								 */
					sync_registers(MTC scur, stop);
			}
		}
		break;

	/*
	 * Exception "Void assigned to expanded"
	 */
	case BC_EXP_EXCEP:
#ifdef DEBUG
		dprintf(2)("BC_EXP_EXCEP\n");
#endif
		xraise(EN_VEXP);
		break;

	case BC_VOID:
		{
			EIF_TYPED_VALUE * l_last;
#ifdef DEBUG
			dprintf(2)("BC_VOID\n");
#endif
			l_last = eif_opstack_push_empty(&op_stack);
			l_last->it_ref = NULL;
			l_last->type = SK_REF;
		}
		break;

	/*
	 * Check instruction.
	 */
	case BC_CHECK:
#ifdef DEBUG
		dprintf(2)("BC_CHECK\n");
#endif
		offset = get_int32(&IC);	/* Jump offset in assertion is not checked */
		if (!(~in_assertion & WASC(icur_dtype) & CK_CHECK))
			/* Check assertions are not checked */
			IC += offset;
		break;

	/*
	 * An Eiffel loop construct.
	 */
	case BC_LOOP:
#ifdef DEBUG
		dprintf(2)("BC_LOOP\n");
#endif
		offset = get_int32(&IC);	/* Jump offset if assertion is not checked */
		if (!(~in_assertion & WASC(icur_dtype) & CK_LOOP))
			/* Loop assertions are not checked */
			IC += offset;
		break;


	/*
	 * Start of inline separate.
	 */
	case BC_START_SEPARATE:
#ifdef DEBUG
		dprintf(2)("BC_START_SEPARATE\n");
#endif
		{
#ifdef EIF_THREADS
			EIF_NATURAL_16 argument_count = 
#endif
			get_uint16(&IC); /* Number of arguments of the instruction. */

#ifdef EIF_THREADS
				/* Create request group. */
			RTS_RC;
				/* Add processors of uncontrolled separate arguments to the reuest group. */
			for (; argument_count > 0; -- argument_count) {
				last = eif_opstack_pop_address(&op_stack);
				if ((last -> type & SK_HEAD) == SK_REF && RTS_OU (last->it_ref)) {
					RTS_RS (last->it_ref);
				}
			}
				/* Wait to get control. */
			RTS_RW;
#endif
		}
		break;

	/*
	 * End of inline separate.
	 */
	case BC_END_SEPARATE:
#ifdef DEBUG
		dprintf(2)("BC_END_SEPARATE\n");
#endif
#ifdef EIF_THREADS
			/* Release control of the request group. */
		RTS_RD;
#endif
		break;

	/*
	 * Assertion checking.
	 */
	case BC_ASSERT:
#ifdef DEBUG
		dprintf(2)("BC_ASSERT\n");
#endif
		{
			int l_is_guard = 0;
			switch (*IC++) {
			case BC_PRE: 	assert_type = EX_PRE; break;
			case BC_PST:	assert_type = EX_POST; break;
			case BC_CHK:	assert_type = EX_CHECK; break;
			case BC_GUARD:	assert_type = EX_CHECK; l_is_guard = 1; break;
			case BC_LINV:	assert_type = EX_LINV; break;
			case BC_LVAR:	assert_type = EX_VAR; break;
			case BC_INV:	assert_type = (where ? EX_CINV : EX_INVC); break;
			default:
				eif_panic(MTC "invalid assertion code");
				/* NOTREADCHED */
			}
			switch (*IC++) {
			case BC_TAG:				/* Assertion tag */
				string = get_string8(&IC, -1);
				break;
			case BC_NOTAG:
				string = NULL;
				break;
			default:
				string = NULL;
				eif_panic(MTC "invalid tag opcode");
				/* NOTREADCHED */
			}
			if ((assert_type == EX_CINV) || (assert_type == EX_INVC)) {
				RTIT((char *) string, icurrent->it_ref);
			} else {
				if (l_is_guard) {
					RTCT0((char *) string, assert_type);
				} else {
					RTCT((char *) string, assert_type);
				}
			}
		}
		break;

	/*
	 * End of assertion.
	 */
	case BC_END_ASSERT:
#ifdef DEBUG
		dprintf(2)("BC_END_ASSERT\n");
#endif
		code = (int) eif_opstack_pop_address(&op_stack)->it_char;	/* Get the assertion
										 * boolean result
										 */
		if (*IC++) {
				/* If we are not handling a guard, we can reset `in_assertion'. */
			if (code) {
				RTCK;				/* Assertion success */
			} else {
				RTCF;				/* Assertion failure */
			}
		} else {
			if (code) {
				RTCK0;				/* Assertion success */
			} else {
				RTCF0;				/* Assertion failure */
			}
		}
		break;

	/*
	 * End of precondition in the first block.
	 */
	case BC_END_PRE:
#ifdef DEBUG
		dprintf(2)("BC_END_FST_PRE\n");
#endif
		offset = get_int32(&IC);		/* get the offset to the precondition
									 * block's corresponding "BC_GOTO_BODY"
									*/
		code = (int) eif_opstack_pop_address(&op_stack)->it_char;
									/* Get the assertion boolean result */
		if (!code) {
			pre_success = '\0';
#ifdef EIF_THREADS
			has_wait_condition |= has_uncontrolled_argument;
#endif /* EIF_THREADS */
			IC += offset;
		} else {
			RTCK;
		}
#ifdef EIF_THREADS
		has_uncontrolled_argument = '\0';
#endif /* EIF_THREADS */
		break;

	/*
	 * Raise exception.
	 */
	case BC_RAISE_PREC:
#ifdef DEBUG
		dprintf(2)("BC_RAISE_PREC\n");
#endif
		if (pre_success) {
#ifdef EIF_THREADS
				/* Remove precondition start entry. */
			pre_start = 0;
#endif /* EIF_THREADS */
			goto enter_body; /* Start execution of a routine body. */
		}
#ifdef EIF_THREADS
			/* Check if precondition is a correctness or wait condition. */
		if (has_wait_condition) {
				/* There is a failed wait condition. */
				/* Repeat precondition checks. */
				/* Remove assertion entry from the stack. */
			RTCK;
				/* Notify SCOOP scheduler that wait condition failed. */
			RTS_RF;
				/* Jump to the precondition start. */
			IC = pre_start;
		}
		else
#endif /* EIF_THREADS */
		{
				/* This is a failed correctness condition. */
				/* Raise an exception. */
			RTCF;
		}
		break;

	/*
	 * Go to the body of the routine
	 */
	case BC_GOTO_BODY:
#ifdef DEBUG
		dprintf(2)("BC_GOTO_BODY\n");
#endif
		{
			offset = get_int32(&IC); 	/* Get offset to skip remaining
									 * chained assertions.
									 */
			if (pre_success){
				IC += offset;		/* Go to the body of routine */
			}
			else {
				RTCK;		/* Remove failed exception from stack */
				pre_success = '\01'; /* Reset success for next block */
#ifdef EIF_THREADS
				has_uncontrolled_argument = '\0';
#endif /* EIF_THREADS */
			}
			break;
		}

	/*
	 * End of loop variant.
	 */
	case BC_END_VARIANT:
#ifdef DEBUG
		dprintf(2)("BC_END_VARIANT\n");
#endif
		{
			long old_val;				/* Old variant value */

			code = get_int16(&IC);		/* Get the local variant index */
			last = loc(code);
			offset = eif_opstack_pop_address(&op_stack)->it_int32;	/* Get the new variant value */
			old_val = last->it_int32;	/* Get the old variant value */
			last->it_int32 = offset;		/* Save the new variant value */
			if ((old_val == -1L || old_val > offset) && offset >= 0) {
				RTCK;
			}
			else {
				RTCF;
			}
		}
		break;

	/*
	 * Initialization of the last variant recording variable.
	 */
	case BC_INIT_VARIANT:
#ifdef DEBUG
		dprintf(2)("BC_INIT_VARIANT\n");
#endif
		code = get_int16(&IC);
		loc(code)->it_int32 = -1;
		break;

	/*
	 * Debug statement.
	 */
	case BC_DEBUG:
#ifdef DEBUG
		dprintf(2)("BC_DEBUG\n");
#endif
		offset = get_int32(&IC);	/* Number of keys */
		if (offset == 0L)
			code = WDBG(icur_dtype, NULL);		/* No debug key */
		else {
			int i;
			for (i = 0, code = 0; i < offset; i++) {
				string = get_string8(&IC, get_int32(&IC));
				code |= WDBG(icur_dtype, (char *) string);
			}
		}
		offset = get_int32(&IC);	/* Get the jump value */
		if (!code)
			IC += offset;
		break;

	/*
	 * Routine object creation instruction.
	 */
	case BC_RCREATE:
#ifdef DEBUG
		dprintf(2)("BC_RCREATE\n");
#endif
		{
			EIF_REFERENCE new_obj;						/* New object */
			unsigned long stagval;
			unsigned char *OLD_IC;
			EIF_BOOLEAN has_closed, is_basic, is_target_closed;
			int32 written_type_id_inline_agent;
			EIF_TYPED_VALUE *aclosed_operands, *aopen_map;
			int32 open_count;
			EIF_REFERENCE open_map, closed_operands;

			open_map = closed_operands = (EIF_REFERENCE) 0;
			has_closed = get_bool(&IC); /* Do we have an closed operands tuple? */
			type = get_compound_id(MTC icurrent->it_ref);

			routine_id = get_int32(&IC);
			is_basic = get_bool(&IC);
			is_target_closed = get_bool(&IC);
			written_type_id_inline_agent = get_int32(&IC);
			open_count = get_int32(&IC);

			if (open_count > 0) {
				aopen_map = eif_opstack_pop_address(&op_stack);
				open_map = (EIF_REFERENCE) (aopen_map->it_ref);
			}
			if (has_closed) {
				aclosed_operands = eif_opstack_pop_address(&op_stack);
				closed_operands = (EIF_REFERENCE) (aclosed_operands->it_ref);
#ifdef EIF_THREADS
		 		if (is_target_closed) {
		 				/* Migrate a tuple that holds closed arguments to a target processor. */
		 				/* Target is the first item of this tuple ("closed_operands"). */
					RTS_PID (closed_operands) = RTS_PID (((EIF_TYPED_VALUE *) closed_operands + 1)->it_r);
	 			}
#endif
			}
			stagval = tagval;
			OLD_IC = IC;
				/* Create new object */
			new_obj = RTLNRW(type, NULL, NULL, NULL, routine_id, open_map,
							 is_basic, is_target_closed, written_type_id_inline_agent, closed_operands, open_count);

			IC = OLD_IC;
			last = eif_opstack_push_empty(&op_stack);				/* Push a new value onto the stack */
			last->type = SK_REF;
			last->it_ref = new_obj;		/* Now it's safe for GC to see it */
#ifdef EIF_THREADS
	 		if (is_target_closed) {
	 				/* Migrate a routine object to a target processor. */
	 				/* Target is the first item of the tuple "closed_operands". */
				RTS_PID (new_obj) = RTS_PID (((EIF_TYPED_VALUE *) closed_operands + 1)->it_r);
	 		}
#endif
			if (tagval != stagval) {		/* If type is expanded we may
										 * need to sync the registers if it
										 * called the interpreter for the
										 * creation routine.
										 * Also if the creation causes melted
										 * Dispose to be called then sync_regs
										 * has to be called.
										 */
				sync_registers(MTC scur, stop);
			}
		}
		break;

	/*
	 * Creation instruction.
	 */
	case BC_CREATE:
	case BC_CREATE_TYPE:
		{
			int is_type_creation = (code == BC_CREATE_TYPE);
			char need_push = *IC++;		/* If there is a creation routine to call
							   we need to push twice the created object */

		l_creation_type = get_creation_type ();

		/* Creation of a new object. We know there will be no call to a
		 * creation routine, so it's useless to resynchronize registers--RAM.
		 */
		{
			EIF_REFERENCE new_obj;						/* New object */
			unsigned long stagval;

			stagval = tagval;
			if (is_type_creation) {
					/* Create the proper type instance. */
				EIF_TYPE_INDEX l_annotations = get_int16(&IC);
				new_obj = RTLNTY2(l_creation_type, l_annotations);
			} else {
				new_obj = RTLNSMART(l_creation_type.id);	/* Create new object */
			}
			last = eif_opstack_push_empty(&op_stack);				/* Push a new value onto the stack */
			last->type = SK_REF;
			last->it_ref = new_obj;		/* Now it's safe for GC to see it */
			if (need_push == (char) 1)
				eif_opstack_push_address(&op_stack, last);			/* If there is a creation procedure, we need to push
										   object on stack to call creation procedure */
			if (tagval != stagval)		/* If type is expanded we may
										 * need to sync the registers if it
										 * called the interpreter for the
										 * creation routine.
										 * Also if the creation causes melted
										 * Dispose to be called then sync_regs
										 * has to be called.
										 */
				sync_registers(MTC scur, stop);
		}
		}
		break;

	/*
	 * Creation instruction for SPECIAL instance.
	 */
	case BC_SPCREATE:
		{
			EIF_REFERENCE new_obj;						/* New object */
			EIF_BOOLEAN is_expanded, is_make_filled, is_make_empty;
			EIF_BOOLEAN is_basic = EIF_FALSE;
			uint32 elem_size = 0, spec_type;
			uint16 flags = 0;
			EIF_TYPED_VALUE nb_item, default_item;
			uint32 nb = 0;
			unsigned long stagval;
			unsigned char *OLD_IC;

			is_make_filled = EIF_TEST(*IC++);
			is_make_empty = EIF_TEST(*IC++);
			l_creation_type = get_creation_type ();

			is_expanded = EIF_TEST(*IC++);

			if (is_expanded) {
				elem_size = OVERHEAD + EIF_Size(get_int16(&IC));
				flags = EO_COMP;
			} else {
				spec_type = get_uint32(&IC);
				switch (spec_type & SK_HEAD) {
					case SK_CHAR8:   elem_size = sizeof(EIF_CHARACTER_8);  is_basic = EIF_TRUE; break;
					case SK_CHAR32:  elem_size = sizeof(EIF_CHARACTER_32); is_basic = EIF_TRUE; break;
					case SK_BOOL:    elem_size = sizeof(EIF_BOOLEAN);      is_basic = EIF_TRUE; break;
					case SK_UINT8:   elem_size = sizeof(EIF_NATURAL_8);    is_basic = EIF_TRUE; break;
					case SK_UINT16:  elem_size = sizeof(EIF_NATURAL_16);   is_basic = EIF_TRUE; break;
					case SK_UINT32:  elem_size = sizeof(EIF_NATURAL_32);   is_basic = EIF_TRUE; break;
					case SK_UINT64:  elem_size = sizeof(EIF_NATURAL_64);   is_basic = EIF_TRUE; break;
					case SK_INT8:    elem_size = sizeof(EIF_INTEGER_8);    is_basic = EIF_TRUE; break;
					case SK_INT16:   elem_size = sizeof(EIF_INTEGER_16);   is_basic = EIF_TRUE; break;
					case SK_INT32:   elem_size = sizeof(EIF_INTEGER_32);   is_basic = EIF_TRUE; break;
					case SK_INT64:   elem_size = sizeof(EIF_INTEGER_64);   is_basic = EIF_TRUE; break;
					case SK_REAL32:  elem_size = sizeof(EIF_REAL_32);      is_basic = EIF_TRUE; break;
					case SK_REAL64:  elem_size = sizeof(EIF_REAL_64);      is_basic = EIF_TRUE; break;
					case SK_POINTER: elem_size = sizeof(EIF_POINTER);      is_basic = EIF_TRUE; break;
					case SK_REF:     elem_size = sizeof(EIF_REFERENCE);    flags = EO_REF;      break;
					default:
						eif_panic ("Illegal type");
				}
			}

			memcpy(&nb_item, eif_opstack_pop_address(&op_stack), ITEM_SZ);
			if (is_make_filled) {
				memcpy(&default_item, eif_opstack_pop_address(&op_stack), ITEM_SZ);
			} else {
				memset(&default_item, 0, ITEM_SZ);
			}
			CHECK("valid_type", (nb_item.type & SK_HEAD) == SK_INT32);
			if (nb_item.it_int32 >= 0) {
				nb = (uint32) nb_item.it_int32;
			} else {
				eraise ("non_negative_argument", EN_RT_CHECK);
			}

				/* The allocation of the SPECIAL may callback some melted code when creating
				 * special of expanded where the call to the creation procedure goes back to
				 * the interpreter. */
			stagval = tagval;
			OLD_IC = IC;
			new_obj = special_malloc (flags, l_creation_type.id, nb, elem_size, is_basic); /* Create new object */

			last = eif_opstack_push_empty(&op_stack);				/* Push a new value onto the stack */
			last->type = SK_REF;
			last->it_ref = new_obj;		/* Now it's safe for GC to see it */

			if (stagval != tagval) {
					/* If type is expanded we may need to sync the registers if it
					 * called the interpreter for the creation routine.
					 * Also if the creation causes melted.
					 * Dispose to be called then sync_regs has to be called.
					 */
				sync_registers (scur, stop);
			}
			IC = OLD_IC;

			if (is_make_filled) {
					/* Prepare the call to `make_filled'. By pushing the computed arguments starting
					 * with the created object. */
				eif_opstack_push_address(&op_stack, last);
				eif_opstack_push_address(&op_stack, &default_item);
				eif_opstack_push_address(&op_stack, &nb_item);
			} else if (is_make_empty) {
				RT_SPECIAL_COUNT(new_obj) = 0;
			}
		}
		break;

	/*
	 * Once case of multi-branch instruction (when part).
	 */
	case BC_RANGE:
#ifdef DEBUG
		dprintf(2)("BC_RANGE\n");
#endif
		{
			EIF_TYPED_VALUE *lower, *upper;
			unsigned char *OLD_IC;			/* IC back-up */

			upper = eif_opstack_pop_address(&op_stack);				/* Get the upper bound */
			lower = eif_opstack_pop_address(&op_stack);				/* Get the lower bound */
			last = EIF_STACK_TOP_ADDRESS(op_stack);				/* Get the inspect expression value */
			CHECK("last not null", last);
			offset = get_int32(&IC);		/* Get the jump value */
			OLD_IC = IC;
			switch (last->type) {
			case SK_UINT8: if (lower->it_uint32 <= (EIF_NATURAL_32) last->it_uint8 && (EIF_NATURAL_32) last->it_uint8 <= upper->it_uint32) { IC += offset; } break;
			case SK_UINT16: if (lower->it_uint32 <= (EIF_NATURAL_32) last->it_uint16 && (EIF_NATURAL_32) last->it_uint16 <= upper->it_uint32) { IC += offset; } break;
			case SK_UINT32: if (lower->it_uint32 <= (EIF_NATURAL_32) last->it_uint32 && (EIF_NATURAL_32) last->it_uint32 <= upper->it_uint32) { IC += offset; } break;
			case SK_UINT64: if (lower->it_uint64 <= last->it_uint64 && last->it_uint64 <= upper->it_uint64) { IC += offset; } break;
			case SK_INT8: if (lower->it_int32 <= (EIF_INTEGER_32) last->it_int8 && (EIF_INTEGER_32) last->it_int8 <= upper->it_int32) { IC += offset; } break;
			case SK_INT16: if (lower->it_int32 <= (EIF_INTEGER_32) last->it_int16 && (EIF_INTEGER_32) last->it_int16 <= upper->it_int32) { IC += offset; } break;
			case SK_INT32: if (lower->it_int32 <= (EIF_INTEGER_32) last->it_int32 && (EIF_INTEGER_32) last->it_int32 <= upper->it_int32) { IC += offset; } break;
			case SK_INT64: if (lower->it_int64 <= last->it_int64 && last->it_int64 <= upper->it_int64) { IC += offset; } break;
			case SK_CHAR8: if (lower->it_wchar <= (EIF_CHARACTER_32) last->it_char && (EIF_CHARACTER_32) last->it_char <= upper->it_wchar) { IC += offset; } break;
			case SK_CHAR32: if (lower->it_wchar <= last->it_wchar && last->it_wchar <= upper->it_wchar) { IC += offset; } break;
			default:
				eif_panic(MTC "invalid inspect type");
				/* NOTREACHED */
			}
				/* We have a match for the inspect value, simply pop the expression value
				 * since we won't use it ever. */
			if (OLD_IC != IC) {
				(void) eif_opstack_pop_address(&op_stack);
			}
		}
		break;

	/*
	 * Unmatched inspect value.
	 */
	case BC_INSPECT_EXCEP:
#ifdef DEBUG
		dprintf(2)("BC_INSPECT_EXCEP\n");
#endif
			/* There was no match, let's remove the inspect expression value. */
		(void) eif_opstack_pop_address(&op_stack);
		xraise(EN_WHEN);
		break;

	/*
	 * Call on a simple type.
	 */
	case BC_METAMORPHOSE:
#ifdef DEBUG
		dprintf(2)("BC_METAMORPHOSE\n");
#endif
		metamorphose_top(scur, stop);
		break;

	/*
	 * Object reattachment.
	 */
	case BC_BOX:
#ifdef DEBUG
		dprintf(2)("BC_BOX\n");
#endif
			/* GENERIC CONFORMANCE */
		type = get_compound_id(MTC icurrent->it_ref);
		/* Creation of a new object. */
		{
			EIF_REFERENCE new_obj;		/* New object */
			unsigned long stagval;

			last = eif_opstack_pop_address(&op_stack);
			stagval = tagval;
			new_obj = RTLNSMART(type);	/* Create new object */
			last = eif_opstack_push_empty(&op_stack);			/* Push a new value onto the stack */
			last->type = SK_REF | SK_EXP;
			last->it_ref = new_obj;		/* Now it's safe for GC to see it */
			if (tagval != stagval)		/* If GC calls melted dispose */
				sync_registers(scur, stop);
		}
		break;

	/*
	 * Separate feature call prefix.
	 */
	case BC_SEPARATE:
	 	{
	 			/* Variables are not used in non-SCOOP context */
#ifdef EIF_THREADS
			EIF_TYPED_VALUE * target;
	 		uint16 n =
#endif
	 			get_uint16 (&IC);    /* Number of arguments.  */
#ifdef EIF_THREADS
	 		EIF_NATURAL_8 scoop_call_flags =
#endif
	 			get_bool (&IC); /* Indicator of a query or of an active region creation. */

			if (*IC == BC_ROTATE) {
				EIF_TYPED_VALUE old;			/* Save old value before copying */
				EIF_TYPED_VALUE prev;			/* Previous value to be copied */
				EIF_TYPED_VALUE *new;			/* Where value is to be copied */
				struct opcursor op_context;  /* To save stack's context */

#ifdef DEBUG
				dprintf(2)("BC_ROTATE\n");
#endif
				IC++;
				code = get_int16(&IC) - 1;
				new = eif_opstack_pop_address(&op_stack);
				memcpy (&prev, new, ITEM_SZ);
				eif_opstack_save_cursor(&op_stack, &op_context);
				while (code-- > 0) {
					new = eif_opstack_pop_address(&op_stack);
					memcpy (&old, new, ITEM_SZ);
					memcpy (new, &prev, ITEM_SZ);
					memcpy (&prev, &old,ITEM_SZ);
				}
				eif_opstack_restore_cursor(&op_stack, &op_context);
				eif_opstack_push_address(&op_stack, &prev);
			}
#ifdef EIF_THREADS
			target = EIF_STACK_TOP_ADDRESS(op_stack);
#define Current (icurrent -> it_ref)
			code = *IC;
			if (code == BC_OBJECT_TEST) {
				if ((target -> it_ref != (EIF_REFERENCE) 0) && ((target -> type & SK_HEAD) == SK_REF) && RTS_OS (Current, target -> it_ref)) {
						/* Replace expression result with Void because it runs on a different processor. */
					target -> it_ref = (EIF_REFERENCE) 0;
				}
					/* Avoid further processing related to separate status. */
				target = NULL;
			}
			else if (code == BC_TUPLE_ACCESS) {
					/* Check that this is not an access on void target. */
				(void) RTCW (target -> it_ref);
					/* Proceed normally if the access is not separate. */
				if (RTS_OS (icurrent->it_ref, target->it_ref)) {
						/* This is a separate access. */
					int pos;
					uint32 l_type;
					unsigned long stagval;
					unsigned char * OLD_IC;
						/* Retrieve tuple access data. */
					IC++;
					pos = get_int32(&IC);            /* Position of access. */
					l_type = get_uint32(&IC);	         /* SK_XX value of access. */
						/* Perform separate access to tuple. */
					stagval = tagval;                /* Save tag value. */
					OLD_IC  = IC;                    /* Save IC. */

					RTS_AC (0, target -> it_ref); /* Create call structure. */
					last = target;                  /* Reuse target cell for result. */
					RTS_CALL (-pos, l_type);         /* Make separate access to a tuple. */
					*last = l_scoop_result;
					if (tagval != stagval)           /* Interpreted function was called. */
						sync_registers(MTC scur, stop);
					IC = OLD_IC;
				}
					/* Avoid further processing related to separate status. */
				target = NULL;
			}
			else if (code == BC_TUPLE_ASSIGN) {
					/* Check that this is not an access on void target. */
				(void) RTCW (target -> it_ref);
					/* Proceed normally if the access is not separate. */
				if (RTS_OS (icurrent->it_ref, target->it_ref)) {
						/* This is a separate access. */
					int pos;
					unsigned long stagval;
					unsigned char * OLD_IC;
					EIF_TYPED_VALUE *source;
						/* Retrieve tuple access data. */
					IC++;
					pos = get_int32(&IC);            /* Position of access. */
						/* Perform separate access to tuple. */
					stagval = tagval;                /* Save tag value. */
					OLD_IC  = IC;                    /* Save IC. */

					RTS_AC (1, target -> it_ref); /* Create call structure. */

					(void) eif_opstack_pop_address(&op_stack);                  /* Remove target from the evaluation stack. */
					source = eif_opstack_pop_address(&op_stack);                 /* Get source value. */
						/* We use `0' for the second argument because the macro does not actually use it
							* in workbench mode. */
					RTS_AA(*source, 0, source -> type, 1); /* Record an argument. */
					RTS_CALL (-pos, SK_VOID);		/* Make separate access to a tuple. */
					if (tagval != stagval)           /* Interpreted function was called. */
						sync_registers(MTC scur, stop);
					IC = OLD_IC;
				}
				else {
						/* Revert changes performed by BC_ROTATE that swapped target and source. */
					EIF_TYPED_VALUE v;
					(void) eif_opstack_pop_address(&op_stack);
					last = EIF_STACK_TOP_ADDRESS(op_stack);
					v = *last;
					*last = *target;
					eif_opstack_push_address(&op_stack, &v);
				}
					/* Avoid further processing related to separate status. */
				target = NULL;
			}
			else {
				if (target -> it_ref == (EIF_REFERENCE) 0) {
						/* Called on a void reference? */
					eraise("", EN_VOID);	         /* Yes, raise exception */
				}
					/* Check if this is indeed a separate call. */
				if (code == BC_CREATION) {
						/* Associate new region with the target of a call. */
					if (scoop_call_flags & SCOOP_CALL_MASK_ACTIVE_CREATION) {
							/* Create a new active region. */
						RTS_PA (target -> it_ref);
					}
					else {
							/* Create a new passive region. */
						RTS_PP (target -> it_ref);
					}

				}
				else if (!RTS_OS (icurrent->it_ref, target->it_ref)) {
						/* The call is not separate, reset target to NULL */
					target = NULL;
				}
			}
			if (target) {
					/* Perform a separate call. */
				unsigned long   stagval = tagval; /* Save tag value */
				unsigned char * OLD_IC  = NULL;   /* Saved IC */

				RTS_AC (n, target -> it_ref); /* Create call structure. */
				eif_opstack_pop_address(&op_stack);                /* Remove target of a call. */
				while (n > 0) {         /* Record arguments of a call. */
					EIF_TYPED_VALUE * p = eif_opstack_pop_address(&op_stack);
						/* We use `0' for the second argument because the macro does not actually use it
							* in workbench mode. */
					RTS_AA(*p, 0, p -> type, n); /* Record an argument. */
					n--;
				};
				switch (code = *IC++)
				{
				case BC_EXTERN_INV:
				case BC_FEATURE_INV:
					string = get_string8(&IC, -1); /* Get the feature name. */
					break;
				case BC_CREATION:
					break;
				default:
					OLD_IC  = IC;
					eif_panic(MTC "illegal separate opcode");
				}
				routine_id = get_int32(&IC); /* Get the routine_id. */
				GET_PTYPE;                   /* Get precursor type. */
				OLD_IC = IC;
				if (scoop_call_flags & SCOOP_CALL_MASK_QUERY) {
					last = eif_opstack_push_empty(&op_stack);   /* Allocate a cell to store result of a call. */
					last -> type = SK_POINTER;                  /* Avoid GC on result until it is ready.      */
					RTS_CALL (routine_id, SK_POINTER);          /* Make a separate call to a function. */
					*last = l_scoop_result;
				} else {
					RTS_CALL (routine_id, SK_VOID);  /* Make a separate call to a procedure. */
				}
				if (tagval != stagval)		/* Interpreted function called */
					sync_registers(MTC scur, stop);
				IC = OLD_IC;
			}
#undef Current
#endif /* EIF_THREADS */
	 	}
	 	break;

	/*
	 * Calling an external function.
	 * Calling an Eiffel feature.
	 */
	case BC_EXTERN:
	case BC_FEATURE:
		routine_id = get_int32(&IC);				/* Get the routine ID */
		nstcall = 0;						/* Invariant check turned off */
		if (icall(routine_id, GET_PTYPE))
			sync_registers(MTC scur, stop);
		break;

	/*
	 * Calling an external in a nested expression (invariant check needed).
	 * Calling an Eiffel feature in a nested expression (invariant check).
	 */
	case BC_EXTERN_INV:
	case BC_FEATURE_INV:
		string = get_string8(&IC, -1);	/* Get the feature name. */
		if (EIF_STACK_TOP_ADDRESS(op_stack)->it_ref == (char *) 0)	/* Called on a void reference? */
			eraise((char *) string, EN_VOID);		/* Yes, raise exception */
		routine_id = get_int32(&IC);				/* Get the routine ID */

		nstcall = 1;					/* Invariant check turned on */
		if (icall(routine_id, GET_PTYPE))
			sync_registers(MTC scur, stop);
		break;

	/*
	 * Calling a creation procedure.
	 */
	case BC_CREATION:
		routine_id = get_int32(&IC);				/* Get the routine ID */
		nstcall = -1;						/* Invariant check is performed at the end */
		if (icall(routine_id, GET_PTYPE))
			sync_registers(MTC scur, stop);
		break;


		/*
		 * Access to an attribute.
		 */
	case BC_ATTRIBUTE_INV:
			/* Qualified access, we verify target is attached. */
		string = get_string8(&IC, -1);	/* Get the attribute name */
		if (EIF_STACK_TOP_ADDRESS(op_stack)->it_ref == (char *) 0) {
			eraise((char *) string, EN_VOID);
		}
	case BC_ATTRIBUTE:
			/* Continue with attribute access based on the routine ID. */
		routine_id = get_int32(&IC);				/* Get the routine ID */
		rt_attribute_access(routine_id, get_uint32(&IC));
		break;

	/*
	 * Rotate the operational stack.
	 */
	case BC_ROTATE:
#ifdef DEBUG
		dprintf(2)("BC_ROTATE\n");
#endif
		{
			EIF_TYPED_VALUE old;			/* Save old value before copying */
			EIF_TYPED_VALUE prev;			/* Previous value to be copied */
			EIF_TYPED_VALUE *new;			/* Where value is to be copied */
			struct opcursor op_context;  /* To save stack's context */

			code = get_int16(&IC) - 1;
			new = eif_opstack_pop_address(&op_stack);
			memcpy (&prev, new, ITEM_SZ);

			eif_opstack_save_cursor (&op_stack, &op_context);
			while (code-- > 0) {
				new = eif_opstack_pop_address(&op_stack);
				memcpy (&old, new, ITEM_SZ);
				memcpy (new, &prev, ITEM_SZ);
				memcpy (&prev, &old,ITEM_SZ);
			}

			eif_opstack_restore_cursor (&op_stack, &op_context);

			eif_opstack_push_address(&op_stack, &prev);
		}
		break;

	/*
	 * Access to Current.
	 */
	case BC_CURRENT:
#ifdef DEBUG
		dprintf(2)("BC_CURRENT\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_REF;
		last->it_ref = icurrent->it_ref;
		break;

	/*
	 * Character constant.
	 */
	case BC_CHAR:
#ifdef DEBUG
		dprintf(2)("BC_CHAR\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_CHAR8;
		last->it_char = *IC++;
		break;

	case BC_WCHAR:
#ifdef DEBUG
		dprintf(2)("BC_WCHAR\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_CHAR32;
		last->it_wchar = (EIF_CHARACTER_32) get_int32(&IC);
		break;

	/*
	 * Boolean constant.
	 */
	case BC_BOOL:
#ifdef DEBUG
		dprintf(2)("BC_BOOL\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_BOOL;
		last->it_char = *IC++;
		break;

	/*
	 * Natural constant.
	 */
	case BC_UINT8:
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_UINT8;
		last->it_uint8 = get_uint8 (&IC);
		break;

	case BC_UINT16:
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_UINT16;
		last->it_uint16 = get_uint16 (&IC);
		break;

	case BC_UINT32:
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_UINT32;
		last->it_uint32 = get_uint32(&IC);
		break;

	case BC_UINT64:
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_UINT64;
		last->it_uint64 = get_uint64(&IC);
		break;

	/*
	 * Integer constant.
	 */
	case BC_INT8:
#ifdef DEBUG
		dprintf(2)("BC_INT8\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_INT8;
		last->it_int8 = (EIF_INTEGER_8) (*IC++);
		break;

	case BC_INT16:
#ifdef DEBUG
		dprintf(2)("BC_INT16\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_INT16;
		last->it_int16 = (EIF_INTEGER_16) get_int16(&IC);
		break;

	case BC_INT32:
#ifdef DEBUG
		dprintf(2)("BC_INT32\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_INT32;
		last->it_int32 = (EIF_INTEGER_32) get_int32(&IC);
		break;

	case BC_INT64:
#ifdef DEBUG
		dprintf(2)("BC_INT64\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_INT64;
		last->it_int64 = get_int64(&IC);
		break;

	/*
	 * Real constant.
	 */
	case BC_FLOAT:
#ifdef DEBUG
		dprintf(2)("BC_FLOAT\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_REAL32;
		last->it_real32 = (EIF_REAL_32) get_real64(&IC);
		break;

	/*
	 * Double constant.
	 */
	case BC_DOUBLE:
#ifdef DEBUG
		dprintf(2)("BC_DOUBLE\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_REAL64;
		last->it_real64 = get_real64(&IC);
		break;

	/*
	 * Pointer constant - always null.
	 */
	case BC_NULL_POINTER:
#ifdef DEBUG
		dprintf(2)("BC_NULL_POINTER\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_POINTER;
		last->it_ptr = (char *) 0;
		break;

	/*
	 * Access to Result.
	 */
	case BC_RESULT:
#ifdef DEBUG
		dprintf(2)("BC_RESULT\n");
#endif
		eif_opstack_push_address(&op_stack, iresult);
		break;

	/*
	 * Access to a local variable.
	 */
	case BC_LOCAL:
#ifdef DEBUG
		dprintf(2)("BC_LOCAL\n");
#endif
		code = get_int16(&IC);				/* Get number (from 1 to locnum) */
		last = eif_opstack_push_empty(&op_stack);
		memcpy (last, loc(code), ITEM_SZ);
		break;

	/*
	 * Access to an argument.
	 */
	case BC_ARG:
#ifdef DEBUG
		dprintf(2)("BC_ARG\n");
#endif
		code = get_int16(&IC);				/* Get number (from 1 to argnum) */
		last = eif_opstack_push_empty(&op_stack);
		memcpy (last, arg(code), ITEM_SZ);
		break;

#ifdef EIF_THREADS
	/*
	 * Argument that may trigger a wait condition.
	 */
	case BC_WAIT_ARG:
#ifdef DEBUG
		dprintf(2)("BC_WAIT_ARG\n");
#endif
		code = get_int16(&IC);				/* Get number (from 1 to argnum) */
			/* Record if an uncontrolled argument is used. */
		if (pre_start && (usep & ((EIF_NATURAL_64) 1) << (code - 1))) {
			has_uncontrolled_argument = '\1';
		}
		break;
#endif /* EIF_THREADS */

	/*
	 * And then operator (left value).
	 */
	case BC_AND_THEN:
#ifdef DEBUG
		dprintf(2)("BC_AND_THEN\n");
#endif
		offset = get_int32(&IC);
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);
		if (!last->it_char)
			IC += offset;
		break;

	/*
	 * Or else operator (left value).
	 */
	case BC_OR_ELSE:
#ifdef DEBUG
		dprintf(2)("BC_OR_ELSE\n");
#endif
		offset = get_int32(&IC);
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);
		if (last->it_char)
			IC += offset;
		break;

	/*
	 * Monadic operators.
	 */
	case BC_UPLUS:			/* Unary plus */
	case BC_UMINUS:			/* Unary minus */
	case BC_NOT:			/* Unary negation */
		monadic_op (code);
		break;

	/*
	 * Diadic operators.
	 */
	case BC_LT:				/* Lesser than op */
	case BC_GT:				/* Greater than op */
	case BC_MINUS:			/* Minus op */
	case BC_XOR:			/* Xor op */
	case BC_GE:				/* Greater or equal op */
	case BC_EQ:				/* Equality */
	case BC_NE:				/* Not equal op */
	case BC_STAR:			/* Multiplication op */
	case BC_POWER:			/* Power op */
	case BC_LE:				/* Less or equal op */
	case BC_DIV:			/* Div op */
	case BC_AND:			/* Logical conjuntion op */
	case BC_SLASH:			/* Real division op */
	case BC_MOD:			/* Integer remainder division op */
	case BC_PLUS:			/* Addition op */
	case BC_OR:				/* Logocal disjunction op */
		diadic_op(code);
		break;

	/* Builtin operations */
	case BC_BUILTIN:
		eif_interp_builtins (scur, stop);
		break;

	/*
	 * Basic operations to improve speed and correctness of operations
	 * on basic types.
	 */
	case BC_BASIC_OPERATIONS:
		eif_interp_basic_operations (scur, stop);
		break;

	/*
	 * Bit operations on INTEGER
	 */

	case BC_INT_BIT_OP:
		eif_interp_bit_operations();
		break;

	/* Real operations: ceil and floor */
	case BC_CEIL:
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);
		CHECK("double_type", last->type == SK_REAL64);
		last->it_double = ceil(last->it_double);
		break;

	case BC_FLOOR:
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);
		CHECK("double_type", last->type == SK_REAL64);
		last->it_double = floor(last->it_double);
		break;

	/*
	 * Expanded comparison
 	 */
	case BC_STANDARD_EQUAL:
#ifdef DEBUG
	dprintf(2)("BC_STANDARD_EQUAL\n");
#endif
		{	EIF_REFERENCE ref;
			unsigned long stagval = tagval;	/* Save tag value */
			unsigned char *OLD_IC;			/* IC back-up */

			ref = eif_opstack_pop_address(&op_stack)->it_ref;
			last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", last);
			OLD_IC = IC;
			last->it_char = (char) RTEQ(ref, last->it_ref);
			IC = OLD_IC;			/* IC back-up */
			last->type = SK_BOOL;
			if (tagval != stagval) {
					/* Melted code was called, we need to resynchronize. */
				sync_registers(MTC scur, stop);
			}
		}
		break;

	/*
	 * Conditional equality test depending on an expandedness of an object type
	 */
	case BC_CEQUAL:
#ifdef DEBUG
	dprintf(2)("BC_CEQUAL\n");
#endif
		{	EIF_REFERENCE ref;
			unsigned long stagval = tagval;	/* Save tag value */
			unsigned char *OLD_IC;			/* IC back-up */

			ref = eif_opstack_pop_address(&op_stack)->it_ref;
			last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", last);
			OLD_IC = IC;
			last->it_char = (char) RTCEQ(ref, last->it_ref);
			IC = OLD_IC;
			last->type = SK_BOOL;
			if (tagval != stagval) {
					/* Melted code was called, we need to resynchronize. */
				sync_registers(MTC scur, stop);
			}
		}
		break;

	/*
	 * Obvious true comparisons
	 */
	case BC_TRUE_COMPAR:
#ifdef DEBUG
	dprintf(2)("BC_TRUE_COMPAR\n");
#endif
		(void) eif_opstack_pop_address(&op_stack);
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);
		last->type = SK_BOOL;
		last->it_char = '\01';
		break;

	/*
	 * Obvious false comparison
	 */
	case BC_FALSE_COMPAR:
#ifdef DEBUG
	dprintf(2)("BC_FALSE_COMPAR\n");
#endif
		(void) eif_opstack_pop_address(&op_stack);
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);
		last->type = SK_BOOL;
		last->it_char = '\0';
		break;

	/*
	 * Address operator.
	 */
	case BC_ADDR:
#ifdef DEBUG
		dprintf(2)("BC_ADDR\n");
#endif
		address(get_int32(&IC));
		break;

	/*
	 * Reserved space (for object address)
	 */
	case BC_RESERVE:
#ifdef DEBUG
		dprintf(2)("BC_RESERVE\n");
#endif
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_POINTER;
		last->it_ptr = NULL;
		break;
	/*
	 * Object address operator.
	 */
	case BC_OBJECT_ADDR:
		{
		EIF_TYPED_VALUE * volatile pointed_object = NULL;
	 	EIF_BOOLEAN is_attribute = EIF_FALSE;
		uint32 value_offset = get_uint32(&IC);
#ifdef DEBUG
		dprintf(2)("BC_OBJECT_ADDR\n");
#endif

		switch(*IC++) {
			case BC_LOCAL:
				code = get_int16(&IC);		/* Get number (from 1 to locnum) */
				pointed_object = loc(code);
				break;
			case BC_ARG:
				code = get_int16(&IC);		/* Get number (from 1 to argnum) */
				pointed_object = arg(code);
				break;
			case BC_RESULT:
				pointed_object = iresult;
				break;
			case BC_CURRENT:
				switch (*IC++) {
				case BC_ATTRIBUTE:
					is_attribute = EIF_TRUE;
					routine_id = get_int32(&IC);		/* Get routine ID */
					(void) get_uint32(&IC);		/* Get attribute meta-type */
					offset = RTWA(routine_id, Dtype(icurrent->it_ref));
					break;
				default:
					eif_panic(MTC "illegal access to Current");
				}

				last = eif_opstack_i_th (&op_stack, value_offset);
				last->type = SK_POINTER;
				last->it_ref = (EIF_REFERENCE) (icurrent->it_ref+offset);
				break;
			default:
				eif_panic(MTC "illegal address access");
			}
			if (is_attribute == EIF_FALSE){
				last = eif_opstack_i_th (&op_stack, value_offset);
				last->type = SK_POINTER;

				switch (pointed_object->type & SK_HEAD) {
					case SK_BOOL:
					case SK_CHAR8: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_char)); break;
					case SK_CHAR32: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_wchar)); break;
					case SK_UINT8: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_uint8)); break;
					case SK_UINT16: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_uint16)); break;
					case SK_UINT32: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_uint32)); break;
					case SK_UINT64: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_uint64)); break;
					case SK_INT8: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_int8)); break;
					case SK_INT16: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_int16)); break;
					case SK_INT32: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_int32)); break;
					case SK_INT64: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_int64)); break;
					case SK_REAL32: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_real32)); break;
					case SK_REAL64: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_real64)); break;
					case SK_POINTER: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_ptr)); break;
					default:
						eif_panic(MTC "illegal type for address access");
				}
			}
		break;
		}

	/*
	 * Expression address: $(s.to_c)
	 */
	case BC_OBJECT_EXPR_ADDR:
#ifdef DEBUG
	dprintf(2)("BC_OBJECT_EXPR_ADDR\n");
#endif
		{
		uint32 ptr_pos, value_pos;
		EIF_TYPED_VALUE *pointed_object;

		ptr_pos = get_uint32(&IC);
		value_pos = get_uint32(&IC);

		pointed_object = eif_opstack_i_th (&op_stack, value_pos);
		CHECK("pointed_object_not_null", pointed_object);
		last = eif_opstack_i_th (&op_stack, ptr_pos);
		CHECK("last not null", last);
		last->type = SK_POINTER;

		switch (pointed_object->type & SK_HEAD) {
			case SK_BOOL:
			case SK_CHAR8: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_char)); break;
			case SK_CHAR32: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_wchar)); break;
			case SK_UINT8: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_uint8)); break;
			case SK_UINT16: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_uint16)); break;
			case SK_UINT32: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_uint32)); break;
			case SK_UINT64: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_uint64)); break;
			case SK_INT8: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_int8)); break;
			case SK_INT16: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_int16)); break;
			case SK_INT32: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_int32)); break;
			case SK_INT64: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_int64)); break;
			case SK_REAL32: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_real32)); break;
			case SK_REAL64: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_real64)); break;
			case SK_POINTER: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_ptr)); break;
			default:
				eif_panic(MTC "illegal type for address access");
			}
		}
		break;

	/*
	 * Pop `n' elements from the stack (resynchronization after expression address operator)
	 */
	case BC_POP:
#ifdef DEBUG
		dprintf(2)("BC_POP\n");
#endif
		{
		uint32 i, nb_uint32 = get_uint32(&IC);
		for (i = 0; i < nb_uint32; i++)
			(void) eif_opstack_pop_address(&op_stack);
		}
		break;

	/*
	 * Manifest array
	 */

	case BC_ARRAY:
		{
			EIF_REFERENCE sp_area;
			unsigned long stagval;
			EIF_TYPED_VALUE new_obj;
			unsigned char *OLD_IC;

				/* Pop SPECIAL from stack. */
			sp_area = eif_opstack_pop_address(&op_stack)->it_ref;
			routine_id = get_int32(&IC);		  	/* Get the routine ID */

			stagval = tagval;
			OLD_IC = IC;					/* Save IC counter */
			new_obj = ((EIF_TYPED_VALUE (*)(EIF_REFERENCE)) RTWF(routine_id, Dtype(sp_area))) (sp_area);
			IC = OLD_IC;
			if (tagval != stagval) {
				sync_registers(MTC scur, stop); /* If calls melted make of array */
			}
			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_REF;
			last->it_ref = new_obj.it_r;
			break;
		}

	case BC_SPECIAL_EXTEND:
		{
			EIF_TYPED_VALUE *it;
			EIF_REFERENCE sp_area;
			rt_uint_ptr elem_size;
			EIF_INTEGER_32 l_index = get_int32(&IC);

			CHECK ("Index non-negative", l_index >= 0);

				/* Get the expression value. */
			it = eif_opstack_pop_address(&op_stack);
				/* Get the special but we leave it on top of stack. */
			sp_area = EIF_STACK_TOP_ADDRESS(op_stack)->it_ref;

			CHECK("valid_index_for_old", (!egc_has_old_special_semantic) || (l_index < RT_SPECIAL_COUNT(sp_area)));
			CHECK("valid_index_for_new", (egc_has_old_special_semantic) || (l_index <= RT_SPECIAL_COUNT(sp_area)));
			CHECK("small_enough", l_index <= RT_SPECIAL_CAPACITY(sp_area));

			switch (it->type & SK_HEAD) {
				case SK_BOOL:
				case SK_CHAR8: *((EIF_CHARACTER_8 *) sp_area + l_index) = it->it_char; break;
				case SK_CHAR32: *((EIF_CHARACTER_32 *) sp_area + l_index) = it->it_wchar; break;
				case SK_UINT8: *((EIF_NATURAL_8 *) sp_area + l_index) = it->it_uint8; break;
				case SK_UINT16: *((EIF_NATURAL_16 *) sp_area + l_index) = it->it_uint16; break;
				case SK_UINT32: *((EIF_NATURAL_32 *) sp_area + l_index) = it->it_uint32; break;
				case SK_UINT64: *((EIF_NATURAL_64 *) sp_area + l_index) = it->it_uint64; break;
				case SK_INT8: *((EIF_INTEGER_8 *) sp_area + l_index) = it->it_int8; break;
				case SK_INT16: *((EIF_INTEGER_16 *) sp_area + l_index) = it->it_int16; break;
				case SK_INT32: *((EIF_INTEGER_32 *) sp_area + l_index) = it->it_int32; break;
				case SK_INT64: *((EIF_INTEGER_64 *) sp_area + l_index) = it->it_int64; break;
				case SK_REAL32: *((EIF_REAL_32 *) sp_area + l_index) = it->it_real32; break;
				case SK_REAL64: *((EIF_REAL_64 *) sp_area + l_index) = it->it_real64; break;
				case SK_POINTER: *((EIF_POINTER *) sp_area + l_index) = it->it_ptr; break;
				case SK_EXP:
					elem_size = RT_SPECIAL_ELEM_SIZE(sp_area);
					ecopy(it->it_ref, sp_area + OVERHEAD + elem_size * (rt_uint_ptr) l_index);
					break;
				case SK_REF:
					*((EIF_REFERENCE *) sp_area + l_index) = it->it_ref;
					RTAR(sp_area, it->it_ref);
					break;
				default:
					eif_panic(MTC RT_BOTCHED_MSG);
			}

			if (!egc_has_old_special_semantic) {
				RT_SPECIAL_COUNT(sp_area)++;
			}
			break;
		}

	case BC_TUPLE_ACCESS:
		{
			int pos = get_int32(&IC);      /* Position of access. */
			uint32 l_type = get_uint32(&IC); /* SK_XX value of access. */
			EIF_TYPED_VALUE *l_last;

			l_last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", l_last);
			(void) RTCW(l_last->it_ref); /* Check that TUPLE is not Void. */
			l_last->type = l_type;         /* Stored type of accessed tuple element. */
			eif_tuple_access (l_last->it_ref, pos, l_last);
		}
		break;

	case BC_TUPLE_ASSIGN:
		{
			EIF_TYPED_VALUE *source;
			int pos = get_int32(&IC);      /* Position of access. */

			source = eif_opstack_pop_address(&op_stack);
			last = eif_opstack_pop_address(&op_stack);
			(void) RTCW(last->it_ref); /* Check that TUPLE is not Void. */
			eif_tuple_assign (last->it_ref, pos, source);
		}

		break;

	case BC_TUPLE:
#ifdef DEBUG
		dprintf(2)("BC_TUPLE\n");
#endif
		{
			long nbr_of_items;
			EIF_REFERENCE new_obj;
			short dtype;
			unsigned long stagval;
			int curr_pos = 1;	/* 1 because tuple starts at 1 */
			EIF_TYPED_VALUE *it;
			unsigned char *OLD_IC;
			EIF_BOOLEAN is_atomic;

				/*GENERIC CONFORMANCE */
			dtype = get_compound_id(MTC icurrent->it_ref);

			nbr_of_items = get_int32(&IC);	  	/* Number of items in tuple */
			is_atomic = EIF_TEST(get_int32(&IC));
			stagval = tagval;
			OLD_IC = IC;					/* Save IC counter */

			new_obj = RTLNTS(dtype, nbr_of_items, is_atomic);	/* Create new object */
			RT_GC_PROTECT(new_obj);   /* Protect new_obj */

			IC = OLD_IC;
			if (tagval != stagval)
				sync_registers(MTC scur, stop); /* If calls melted make of tuple */

			while (curr_pos < nbr_of_items) {
				/* Fill the tuple with the expressions for the manifest tuple. */

				it = eif_opstack_pop_address(&op_stack);		/* Pop expression off stack */
				switch (it->type & SK_HEAD) {
					case SK_BOOL: eif_put_boolean_item(new_obj, curr_pos, it->it_char); break;
					case SK_CHAR8: eif_put_character_item(new_obj, curr_pos, it->it_char); break;
					case SK_CHAR32: eif_put_wide_character_item(new_obj, curr_pos, it->it_wchar); break;
					case SK_UINT8: eif_put_natural_8_item(new_obj, curr_pos, it->it_uint8); break;
					case SK_UINT16: eif_put_natural_16_item(new_obj, curr_pos, it->it_uint16); break;
					case SK_UINT32: eif_put_natural_32_item(new_obj, curr_pos, it->it_uint32); break;
					case SK_UINT64: eif_put_natural_64_item(new_obj, curr_pos, it->it_uint64); break;
					case SK_INT8: eif_put_integer_8_item(new_obj, curr_pos, it->it_int8); break;
					case SK_INT16: eif_put_integer_16_item(new_obj, curr_pos, it->it_int16); break;
					case SK_INT32: eif_put_integer_32_item(new_obj, curr_pos, it->it_int32); break;
					case SK_INT64: eif_put_integer_64_item(new_obj, curr_pos, it->it_int64); break;
					case SK_REAL32: eif_put_real_32_item(new_obj, curr_pos, it->it_real32); break;
					case SK_REAL64: eif_put_real_64_item(new_obj, curr_pos, it->it_real64); break;
					case SK_POINTER: eif_put_pointer_item(new_obj, curr_pos, it->it_ptr); break;
					case SK_EXP: eif_put_reference_item(new_obj, curr_pos, RTCL(it->it_ref)); break;
					case SK_REF: eif_put_reference_item(new_obj, curr_pos, it->it_ref); break;
					default:
						eif_panic(MTC RT_BOTCHED_MSG);
				}
				curr_pos++;
			}
			RT_GC_WEAN(new_obj);			/* Release protection of `new_obj' */
			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_REF;
			last->it_ref = new_obj;
			break;
		}

	/*
	 * Retrieve old expression from local register.
	 */
	case BC_RETRIEVE_OLD:
#ifdef DEBUG
		dprintf(2)("BC_RETRIEVE_OLD\n");
#endif
		code = get_int16(&IC);             /* Get number (from 1 to locnum) */
		ex_pos = get_int16(&IC);			/* Get exception local position */
		RTCO(loc(ex_pos)->it_r);
		last = eif_opstack_push_empty(&op_stack);
		memcpy (last, loc(code), ITEM_SZ);
		break;

	/*
	 * Beginning of old evaluation
	 */
	case BC_START_EVAL_OLD:
#ifdef DEBUG
		dprintf(2)("BC_START_EVAL_OLD\n");
#endif

		offset = get_int32(&IC);		/* Get offset for skipping old evaluation block */
		if (~in_assertion & WASC(icur_dtype) & CK_ENSURE) {
			in_assertion = ~0;
			offset_o = get_int32(&IC);		/* Get position of the next BC_OLD */
			{
				RTE_OTD;
				SAVE(db_stack, dcur_o, dtop_o);
				SAVE(op_stack, scur_o, stop_o);
				saved_except_for_old = NULL;
				IC_O = IC;
				if (setjmp(exenv_o)) {
					RESTORE(op_stack,scur_o,stop_o);
					RESTORE(db_stack,dcur_o,dtop_o);
					saved_except_for_old = RTLA;
					exold (); /* Push an empty vector to pair the following poping */
					sync_registers(MTC scur_o, stop_o);
					IC = IC_O + offset_o; /* Jump to the next BC_OLD */
				}
			}
		} else {
			IC += offset;			/* Skip old evaulation */
		}
		break;

	/*
	 * End of old evaluation
	 */
	case BC_END_EVAL_OLD:
#ifdef DEBUG
		dprintf(2)("BC_END_EVAL_OLD\n");
#endif
		RTE_OP; /* Whenever the it reaches here, the old vector should be put. */
		in_assertion = 0;
		break;

	/*
	 * Place Old expression value into local register.
	 */
	case BC_OLD:
#ifdef DEBUG
		dprintf(2)("BC_OLD\n");
#endif
		if (!saved_except_for_old)
			/* If there was an exception, op_stack was not pushed the old value */
			/* Only read the position forward in IC */
		{
			last = eif_opstack_pop_address(&op_stack);
			code = get_int16(&IC);     /* Get the local number (from 1 to locnum) */
			if ((last->type & SK_HEAD) == SK_EXP) {
					/* Case of an expanded, then we need to copy its original value. */
				eif_std_ref_copy(last->it_ref, loc(code)->it_ref);
			} else {
				memcpy (loc(code), last, ITEM_SZ);
			}
		}else{
			code = get_int16(&IC);     /* Get the local number (from 1 to locnum) */
		}
		code = get_int16(&IC);		/* Get the local number for exception object */
		offset_o = get_int32(&IC);		/* Get position of the next BC_OLD */
		if (saved_except_for_old)
			loc(code)->it_r = saved_except_for_old;
			/*memcpy (loc(code), saved_except_for_old, sizeof (saved_except_for_old));*/
		else
			loc(code)->it_r = NULL;
			/*memset (loc(code), 0, sizeof(EIF_TYPED_VALUE));*/

		RTE_OP; /* Pop last old evaluation vector in the stack. */
		/* Rescue next old expression evaluation */
		{
			RTE_OTD;
			SAVE(db_stack, dcur_o, dtop_o);
			SAVE(op_stack, scur_o, stop_o);
			saved_except_for_old = NULL;
			IC_O = IC;
			if (setjmp(exenv_o)) {
				RESTORE(op_stack,scur_o,stop_o);
				RESTORE(db_stack,dcur_o,dtop_o);
				saved_except_for_old = RTLA;
				exold (); /* Push an empty vector to pair the following poping */
				sync_registers(MTC scur_o, stop_o);
				IC = IC_O + offset_o; /* Jump to the next BC_OLD */
			}
		}
		break;

	/*
	 * Add attribute name to be stripped.
	 */
	case BC_ADD_STRIP:
#ifdef DEBUG
		dprintf(2)("BC_ADD_STRIP\n");
#endif
		string = get_string8(&IC, -1);
		last = eif_opstack_push_empty(&op_stack);
		last->type = SK_REF;
		last->it_ref = (EIF_REFERENCE) string;
		break;

	/*
	 * End strip execution
	 */
	case BC_END_STRIP:
#ifdef DEBUG
		dprintf(2)("BC_END_STRIP\n");
#endif
		{	long nbr_of_items, temp;
			EIF_REFERENCE *stripped;
			EIF_REFERENCE array;
			short d_type; /* %%ss removed , s_type; */
			unsigned long stagval;

			stagval = tagval;
			d_type = get_int16(&IC);           /* Get the dynamic type */
			nbr_of_items = get_int32(&IC);
			temp = nbr_of_items;
			stripped = (EIF_REFERENCE *) cmalloc(sizeof(EIF_REFERENCE) * nbr_of_items);
			if (stripped == NULL)
				enomem(MTC_NOARG);
			while (nbr_of_items--) {
				last = eif_opstack_pop_address(&op_stack);
				stripped[nbr_of_items] = last->it_ref;
			}
			array = striparr(icurrent->it_ref, d_type, stripped, temp);
			if (tagval != stagval)
				sync_registers(MTC scur, stop); /* If G.C calls melted dispose */
			eif_rt_xfree ((EIF_REFERENCE) stripped);
			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_REF;
			last->it_ref = array;
			break;
		}

	/*
	 * Once manifest STRING.
	 */
	case BC_ONCE_STRING:
#ifdef DEBUG
		dprintf(2)("BC_ONCE_STRING\n");
#endif
		{
			unsigned long stagval;
			unsigned char *OLD_IC;
			int32 body_index;	/* routine body index */
			int32 number;	/* number of the once manifest string in routine body */
			int32 length;	/* nubmer of bytes of once manifest string */

			stagval = tagval;
			body_index = get_int32(&IC);	/* Get routine body index */
			number = get_int32(&IC);	/* Get number of the once manifest string in the routine body */
			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */

			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_REF;

			OLD_IC = IC;
			RTCOMS (last->it_ref, body_index, number, (char *) string, length, 0);
			IC = OLD_IC;

			if (tagval != stagval) {
				sync_registers(MTC scur,stop);
			}
			break;
		}

	/*
	 * Once manifest STRING_32.
	 */
	case BC_ONCE_STRING32:
#ifdef DEBUG
		dprintf(2)("BC_ONCE_STRING32\n");
#endif
		{
			unsigned long stagval;
			unsigned char *OLD_IC;
			int32 body_index;	/* routine body index */
			int32 number;	/* number of the once manifest string in routine body */
			int32 length;	/* nubmer of bytes of once manifest string */

			stagval = tagval;
			body_index = get_int32(&IC);	/* Get routine body index */
			number = get_int32(&IC);	/* Get number of the once manifest string in the routine body */
			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */

			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_REF;

			OLD_IC = IC;
			RTCOMS32 (last->it_ref, body_index, number, (char *) string, length / sizeof (EIF_CHARACTER_32), 0);
			IC = OLD_IC;

			if (tagval != stagval) {
				sync_registers(MTC scur,stop);
			}
			break;
		}

	/*
	 * Once manifest IMMUTABLE_STRING_8 .
	 */
	case BC_ONCE_IMMSTRING8:
#ifdef DEBUG
		dprintf(2)("BC_ONCE_IMMSTRING8\n");
#endif
		{
			unsigned long stagval;
			unsigned char *OLD_IC;
			int32 body_index;	/* routine body index */
			int32 number;	/* number of the once manifest string in routine body */
			int32 length;	/* nubmer of bytes of once manifest string */

			stagval = tagval;
			body_index = get_int32(&IC);	/* Get routine body index */
			number = get_int32(&IC);	/* Get number of the once manifest string in the routine body */
			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */

			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_REF;

			OLD_IC = IC;
			RTCOMIS8 (last->it_ref, body_index, number, (char *) string, length, 0);
			IC = OLD_IC;

			if (tagval != stagval) {
				sync_registers(MTC scur,stop);
			}
			break;
		}

	/*
	 * Once manifest IMMUTABLE_STRING_32.
	 */
	case BC_ONCE_IMMSTRING32:
#ifdef DEBUG
		dprintf(2)("BC_ONCE_IMMSTRING32\n");
#endif
		{
			unsigned long stagval;
			unsigned char *OLD_IC;
			int32 body_index;	/* routine body index */
			int32 number;	/* number of the once manifest string in routine body */
			int32 length;	/* nubmer of bytes of once manifest string */

			stagval = tagval;
			body_index = get_int32(&IC);	/* Get routine body index */
			number = get_int32(&IC);	/* Get number of the once manifest string in the routine body */
			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */

			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_REF;

			OLD_IC = IC;
			RTCOMIS32 (last->it_ref, body_index, number, (char *) string, length / sizeof (EIF_CHARACTER_32), 0);
			IC = OLD_IC;

			if (tagval != stagval) {
				sync_registers(MTC scur,stop);
			}
			break;
		}

	/*
	 * Allocate space to store once manifest strings.
	 */
	case BC_ALLOCATE_ONCE_STRINGS:
#ifdef DEBUG
		dprintf(2)("BC_ALLOCATE_ONCE_STRINGS\n");
#endif
		{
			unsigned long stagval;
			int32 body_index;	/* routine body index */
			int32 count;	/* total number of the once manifest strings in routine body */

			stagval = tagval;
			body_index = get_int32(&IC);	/* Get routine body index */
			count = get_int32(&IC);	/* Get total number of the once manifest string in the routine body */

			RTAOMS (body_index, count);
			if (tagval != stagval) {
				sync_registers(MTC scur,stop);
			}
			break;
		}

	/*
	 * Manifest STRING.
	 */
	case BC_STRING:
#ifdef DEBUG
		dprintf(2)("BC_STRING\n");
#endif
		{
			EIF_REFERENCE str_obj;			  /* String object created */
			unsigned long stagval;
			unsigned char *OLD_IC;
			int32 length;						/* number of bytes of the manifest string */

			stagval = tagval;

			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */
			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_INT32;		/* Protect empty cell from GC */

			/* We have to use the str_obj temporary variable instead of doing
			 * the assignment directly into last->it_ref because the GC might
			 * run a cycle when makestr() is called...
			 */

			OLD_IC = IC;
			str_obj = RTMS_EX((char *) string, length);
			IC = OLD_IC;

			last->type = SK_REF;
			last->it_ref = str_obj;
			if (tagval != stagval)
				sync_registers(MTC scur,stop);
			break;
		}

	/*
	 * Manifest STRING32.
	 */
	case BC_STRING32:
#ifdef DEBUG
		dprintf(2)("BC_STRING32\n");
#endif
		{
			EIF_REFERENCE str_obj;			  /* String object created */
			unsigned long stagval;
			unsigned char *OLD_IC;
			int32 length;						/* number of bytes of the manifest string */

			stagval = tagval;

			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */
			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_INT32;		/* Protect empty cell from GC */

			/* We have to use the str_obj temporary variable instead of doing
			 * the assignment directly into last->it_ref because the GC might
			 * run a cycle when makestr() is called...
			 */

			OLD_IC = IC;
			str_obj = RTMS32_EX((char *) string, length / sizeof (EIF_CHARACTER_32));
			IC = OLD_IC;

			last->type = SK_REF;
			last->it_ref = str_obj;
			if (tagval != stagval)
				sync_registers(MTC scur,stop);
			break;
		}

	/*
	 * Manifest IMMUTABLE_STRING_8.
	 */
	case BC_IMMSTRING8:
#ifdef DEBUG
		dprintf(2)("BC_IMMSTRING8\n");
#endif
		{
			EIF_REFERENCE str_obj;			  /* String object created */
			unsigned long stagval;
			unsigned char *OLD_IC;
			int32 length;						/* number of bytes of the manifest string */

			stagval = tagval;

			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */
			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_INT32;		/* Protect empty cell from GC */

			/* We have to use the str_obj temporary variable instead of doing
			 * the assignment directly into last->it_ref because the GC might
			 * run a cycle when makestr() is called...
			 */

			OLD_IC = IC;
			str_obj = RTMIS8_EX((char *) string, length);
			IC = OLD_IC;

			last->type = SK_REF;
			last->it_ref = str_obj;
			if (tagval != stagval)
				sync_registers(MTC scur,stop);
			break;
		}		
	/*
	 * Manifest IMMUTABLE_STRING_32.
	 */
	case BC_IMMSTRING32:
#ifdef DEBUG
		dprintf(2)("BC_IMMSTRING32\n");
#endif
		{
			EIF_REFERENCE str_obj;			  /* String object created */
			unsigned long stagval;
			unsigned char *OLD_IC;
			int32 length;						/* number of bytes of the manifest string */

			stagval = tagval;

			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */
			last = eif_opstack_push_empty(&op_stack);
			last->type = SK_INT32;		/* Protect empty cell from GC */

			/* We have to use the str_obj temporary variable instead of doing
			 * the assignment directly into last->it_ref because the GC might
			 * run a cycle when makestr() is called...
			 */

			OLD_IC = IC;
			str_obj = RTMIS32_EX((char *) string, length / sizeof (EIF_CHARACTER_32));
			IC = OLD_IC;

			last->type = SK_REF;
			last->it_ref = str_obj;
			if (tagval != stagval)
				sync_registers(MTC scur,stop);
			break;
		}

	/*
	 * Jump if top of stack is false (value is poped).
	 */
	case BC_JMP_F:				/* Jump if false */
#ifdef DEBUG
		dprintf(2)("BC_JMP_F\n");
#endif
		offset = get_int32(&IC);	/* Get jump offset */
		code = (int) eif_opstack_pop_address(&op_stack)->it_char;
		if (!code)
			IC += offset;		/* Jump */
		break;

	/*
	 * Jump if top of stack is true (value is poped).
	 */
	case BC_JMP_T:				/* Jump if true */
#ifdef DEBUG
		dprintf(2)("BC_JMP_T\n");
#endif
		offset = get_int32(&IC);	/* Get jump offset */
		code = (int) eif_opstack_pop_address(&op_stack)->it_char;
		if (code)
			IC += offset;		/* Jump */
		break;

	/*
	 * Unconditional jump.
	 */
	case BC_JMP:
#ifdef DEBUG
		dprintf(2)("BC_JMP\n");
#endif
		offset = get_int32(&IC);	/* Because get_int32(&IC) updates IC on the fly */
		IC += offset;
		break;

	/*
	 * Standard debugger hook.
	 */
	case BC_HOOK:
#ifdef DEBUG
		dprintf(2)("BC_HOOK\n");
#endif
		offset = get_int32(&IC);		/* retrieve the parameter of BC_HOOK: line number */
		dstop(EIF_STACK_TOP_ADDRESS(db_stack)->dc_exec,offset);	/* Debugger hook , dtop->dc_exec returns the current execution vector */
		break;

	/*
	 * Debugger hook for nested calls.
	 */
	case BC_NHOOK:
#ifdef DEBUG
		dprintf(2)("BC_NHOOK\n");
#endif
		{
			struct dcall *call;
			offset = get_int32(&IC);		/* retrieve the parameter of BC_NHOOK: line number */
			offset_n = get_int32(&IC);	/* retrieve the 2nd parameter of BC_NHOOK: line number */
			call = EIF_STACK_TOP_ADDRESS(db_stack);
			CHECK("call not void", call);
			dstop_nested(call->dc_exec,offset,offset_n);	/* Debugger hook - stop point reached */ /* FIXME */
		}
		break;

	/*
	 * Change the type from REFERENCE to POINTER for a stack item generated
	 * from a statement like "$object"
	 */
	case BC_REF_TO_PTR:
#ifdef DEBUG
		dprintf(2)("BC_REF_TO_PTR\n");
#endif
		{
			last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", last);
			last->type = SK_POINTER;
				/* References and pointers are store as char * so no type
				 * conversion is necessary. Only the type field has to be
				 * updated.
				 */
			break;
		}


	/*
	 * End of rescue clause
	 */
	case BC_END_RESCUE:
#ifdef DEBUG
		dprintf(2)("BC_END_RESCUE\n");
#endif
		RTEF;
		if (!is_object_relative_once) {
			return;
		}

	/*
	 * End of current Eiffel routine.
	 */
	case BC_NULL:
#ifdef DEBUG
		dprintf(2)("BC_NULL\n");
#endif
		caller_assertion_level = saved_caller_assertion_level;
		if (is_nested != 0)		/* Nested feature call (dot notation) */
			icheck_inv(MTC icurrent->it_ref, scur, stop, 1);	/* Invariant after feature application */

		CHECK("exvect not null", exvect);
		RTDBGLE;

		pop_registers();	/* Pop registers */
#ifdef EIF_THREADS
			/* Release request chain if required. */
		if (uarg) RTS_RD;
#endif
		/* leave_body: */
			/* Exit rutine body. */
		if (is_process_or_thread_relative_once) {
				/* Remove execution vector to restore    */
				/* previous exception catch point.       */
			exvect = extrl();
			dexset(exvect);
#ifdef EIF_THREADS
			if (is_process_once) {
					/* Clear field that holds locking thread id. */
				CHECK("POResult not null", POResult);
				POResult -> thread_id = NULL;
					/* Ensure memory is flushed (if required). */
				RTOPMBW;
					/* Mark evaluation as completed. */
				POResult -> completed = EIF_TRUE;
					/* Unlock mutex. */
				RTOPLU (POResult -> mutex);
			}
#endif /* EIF_THREADS */
		}
			/* Closing of trace and profiling for current routine. */
		check_options_stop(0);
		if (rescue) {
			RTEOK;	/* end routine with rescue clause by cleaning the trace stack */
		} else {
			RTEE;	/* remove execution vector from stack */
		}
		return;

	case BC_INV_NULL:
#ifdef DEBUG
		dprintf(2)("BC_INV_NULL\n");
#endif
		caller_assertion_level = saved_caller_assertion_level;
		pop_registers();	/* Pop registers */
			/* Closing of trace and profiling for current routine. */
		check_options_stop(0);
		RTEE;	/* remove execution vector from stack */
		return;

	default:
		eif_panic(MTC "illegal opcode");
		/* NOTREACHED */
	}
	continue;
		/* Setup data on entering routine body */
enter_body:
	if (is_process_or_thread_relative_once) {
		int was_executed = EIF_FALSE;
#ifdef EIF_THREADS
		if (is_process_once) {
			CHECK("POResult not null", POResult);
			if (!POResult -> mutex){
				/* Create the mutex */
				POResult -> mutex = eif_thr_mutex_create ();
			}
				/* Try to lock a mutex. */
			if (RTOPLT (POResult -> mutex)) {
					/* Mutex has been locked.                       */
					/* Check if once evaluation has been completed. */
				was_executed = POResult -> completed;
				if (!was_executed) {
						/* Evaluation is not completed. */
						/* Check if evaluation is started earlier. */
					was_executed = MTOD(OResult);
					if (!was_executed) {
							/* Evaluation has not been started yet.   */
							/* Record thread id and start evaluation. */
						POResult -> thread_id = eif_thr_thread_id();
					}
				}
				if (was_executed) {
						/* Unlock mutex. */
					RTOPLU (POResult -> mutex);
				}
			}
			else {
					/* Mutex cannot be locked.      */
					/* Evaluation has been started. */
					/* Let it to complete.          */
				RTOPW (POResult -> mutex, POResult -> thread_id);
				was_executed = EIF_TRUE;
			}
		} else {
#endif /* EIF_THREADS */
			CHECK("OResult not null", OResult);
			was_executed = MTOD(OResult);
#ifdef EIF_THREADS
		}
#endif

			/* Check if once routine was executed earlier. */
		if (was_executed) {

			dstop(EIF_STACK_TOP_ADDRESS(db_stack)->dc_exec,once_end_break_index);	/* Debugger hook , dtop->dc_exec returns the current execution vector */

				/* Yes, it was executed.      */
			if (is_process_or_thread_relative_once) {
#ifdef EIF_THREADS
				if (is_process_once) {
						/* Per thread pointer point to the process exception */
					MTOE(OResult, &(POResult -> exception));
				}
#endif
					/* Ckeck if it failed or not. */
				if (MTOF(OResult)) {
						/* Raise its exception. */
					if (*MTOF(OResult))
						oraise (*MTOF(OResult));
				}
					/* Retrieve once result. */
				get_once_result (OResult, rtype, iresult);
			}

				/* exit body */
			RTDBGLE;


				/* Pop registers */
			pop_registers();
				/* Closing of trace and profiling for current routine. */
			check_options_stop(0);
			if (rescue) {
					/* End routine with rescue clause. */
				RTEOK;
			} else {
					/* Remove execution vector from stack. */
				RTEE;
			}
			return;
		} else {
				/* This is a first-time call. */
				/* Declare variables for exception handling. */
			struct ex_vect * exvecto;

			if (is_process_or_thread_relative_once) {
					/* Mark once routine as executed. */
				MTOM(OResult);
			}
				/* Record execution vector to catch exception. */
			exvecto = extre ();
				/* Set catch address. */
			exvect->ex_jbuf = &exenvo;
				/* Update routine exception vector. */
			exvect = exvecto;
			dexset(exvect);
			if (!setjmp(exenvo)) {
				if (is_process_or_thread_relative_once) {
					switch (rtype & SK_HEAD)
					{
					case SK_EXP:
					case SK_REF:
							/* Register once result for GC. */
#ifdef EIF_THREADS
						if (is_process_once) {
							MTOP(EIF_REFERENCE, OResult, &(POResult -> reference));
							RTOC_GLOBAL(*MTOR(EIF_REFERENCE, OResult));
						}
						else
#endif
						MTOP(EIF_REFERENCE, OResult, RTOC(0));
						break;
					}
							/* Register exception object for GC. */
#ifdef EIF_THREADS
					if (is_process_once){
						MTOE(OResult, &(POResult -> exception));
						RTOC_GLOBAL(*MTOF(OResult));
					}else
#endif
					MTOE(OResult, RTOC(0));

				}
				create_expanded_locals (scur, stop);
				if (create_result) {
					create_expanded_result (scur, stop);
				}
				if (is_process_or_thread_relative_once) {
						/* Initialize permanent storage */
					put_once_result (iresult, rtype, OResult);
				}
					/* Register rescue handler (if any). */
				SET_RESCUE(rescue,exenv);
			} else {
					/* Exception occurred. */
				if (is_process_or_thread_relative_once) {
					/* Record it for future use. */
					MTOEV(OResult, RTLA);
#ifdef EIF_THREADS
					if (is_process_once) {
							/* Clear field that holds locking thread id. */
						POResult -> thread_id = NULL;
							/* Ensure memory is flushed (if required). */
						RTOPMBW;
							/* Mark evaluation as completed. */
						POResult -> completed = EIF_TRUE;
							/* Unlock mutex. */
						RTOPLU (POResult -> mutex);
					}
#endif /* EIF_THREADS */
				}
					/* Propagate the exception. */
				ereturn ();
			}
		}
	} else {
			/* Initialize expanded result */
		if (create_result) {
			create_expanded_result (scur, stop);
		}
			/* Register rescue handler (if any). */
		CHECK("exvect not null", exvect);
		SET_RESCUE(rescue,exenv);
	}
	}							/* Remember: indentation was wrong--RAM */
	/* NOTREACHED */
}

rt_private void icheck_inv(EIF_REFERENCE obj, struct stopchunk *scur, EIF_TYPED_VALUE *stop, int where)
					  		/* Current chunk (stack context) */
							/* To save stack context */
		  					/* Invariant after or before */
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	/* Check invariant on non-void object `obj' */
	unsigned char *OLD_IC;		/* IC backup */
	EIF_TYPE_INDEX dtype = Dtype(obj);

	/* Store the `where' infomation for later use */
	echentry = !where;

	if (inv_mark_table == (char *) 0)
		if ((inv_mark_table = (char *) cmalloc (scount * sizeof(char))) == (char *) 0)
			enomem(MTC_NOARG);

	memset  (inv_mark_table, 0, scount);

	if (~in_assertion & WASC(dtype) & CK_INVARIANT) {
		OLD_IC = IC;				/* Save IC */
		irecursive_chkinv(dtype, obj, scur, stop, where);
		IC = OLD_IC;				/* Restore IC */
	}
}

rt_private void irecursive_chkinv(EIF_TYPE_INDEX dtype, EIF_REFERENCE obj, struct stopchunk *scur, EIF_TYPED_VALUE *stop, int where)


					  		/* Current chunk (stack context) */
				  			/* To save stack context */
		  					/* Invariant after or before */
{
	/* Recursive invariant check. */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	EIF_TYPE_INDEX *cn_parents;
	EIF_TYPE_INDEX p_type;

	if (dtype == 0) return;		/* ANY does not have invariants */

	if ((char) 0 != inv_mark_table[dtype])	/* Already checked */
		return;
	else
		inv_mark_table[dtype] = (char) 1;	/* Mark as checked */

	/* Automatic protection of `obj' */
	RT_GC_PROTECT(obj);

	/* Recursion on parents first. */
	cn_parents = par_info(dtype)->parents;

		/* The list of parent dynamic types is always terminated by TERMINATOR,
		 * and between parents by PARENT_TYPE_SEPARATOR.
		 */
	p_type = *cn_parents++;
	while (p_type != TERMINATOR) {
			/* Currently the compiler generates annotations for parent types, but really
			 * we do not need them for checking invariants. */
		while (RT_CONF_HAS_ANNOTATION_TYPE_IN_ARRAY(p_type)) {
			p_type = *cn_parents++;
		}

			/* Call to potential parent invariant */
		irecursive_chkinv(p_type, obj, scur, stop, where);

			/* Iterate `cn_parents' until we reach the next parent or the end. */
		while ((p_type != PARENT_TYPE_SEPARATOR) && (p_type != TERMINATOR)) {
			p_type = *cn_parents++;
		}
		if (p_type == PARENT_TYPE_SEPARATOR) {
			p_type = *cn_parents++;
		}
	}

		/* Invariant check.
		 * Skip this step for an expanded object because the corresponding reference class is in the set of its parents.
		 * See test#exec091.
		 */
	if (!EIF_IS_EXPANDED_TYPE(System(dtype))) {
		BODY_INDEX body_id;
		EIF_TYPED_VALUE *last;

		CBodyId(body_id,INVARIANT_ID,dtype);
		if (body_id != INVALID_ID) {
			if (egc_frozen [body_id]) {		/* Frozen invariant */
				unsigned long stagval = tagval;	/* Tag value backup */

				((void (*)(EIF_REFERENCE, int)) egc_frozen[body_id])(obj, where);

				if (tagval != stagval)			/* Resynchronize registers */
					sync_registers(MTC scur, stop);

			} else
			{				/* Melted invariant */
				last = eif_opstack_push_empty(&op_stack);					/* Push `obj' */
				last->type = SK_REF;
				last->it_ref = obj;
					/* The proper way to start the interpretation of a melted
					* invariant code is to call `xiinv' in order to initialize the
					* calling context (which is not done by `interpret').
					* `tagval' will therefore be set, but we have to
					* resynchronize the registers anyway. --ericb
					*/
				xiinv(MTC melt[body_id], where);

				sync_registers(MTC scur, stop);		/* Resynchronize registers */
			}
		}
	}

	/* No more propection for `obj' */
	RT_GC_WEAN(obj);
}

/*
 * Monadic and diadic operations
 */

rt_private void monadic_op(int code)
{
	/* Apply the operation 'code' to the value on top of the stack */

	EIF_GET_CONTEXT
	EIF_TYPED_VALUE *first;			/* First operand */

	first = EIF_STACK_TOP_ADDRESS(op_stack);				/* Item will get modified */
	CHECK("first not null", first);

	switch (code) {				/* Execute operation */

	/*
	 * Unary plus.
	 */
	case BC_UPLUS:
#ifdef DEBUG
		dprintf(2)("BC_UPLUS\n");
#endif
		/* Nothing to be done */
		break;

	/*
	 * Unary minus.
	 */
	case BC_UMINUS:
#ifdef DEBUG
		dprintf(2)("BC_UMINUS\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_INT8:	first->it_int8 = -first->it_int8; break;
		case SK_INT16:	first->it_int16 = -first->it_int16; break;
		case SK_INT32:	first->it_int32 = -first->it_int32; break;
		case SK_INT64:	first->it_int64 = -first->it_int64; break;
		case SK_REAL32:	first->it_real32 = -first->it_real32; break;
		case SK_REAL64:	first->it_real64 = -first->it_real64; break;
		default:
			eif_panic(MTC RT_BOTCHED_MSG);
		}
		break;

	/*
	 * Unary not (boolean).
	 */
	case BC_NOT:
#ifdef DEBUG
		dprintf(2)("BC_NOT\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_BOOL: first->it_char = (EIF_BOOLEAN) !first->it_char; break;
		default:
			eif_panic(MTC RT_BOTCHED_MSG);
		}
		break;

	default:
		eif_panic(MTC "invalid monadic opcode");
		/* NOTREACHED */
	}
}

rt_private void diadic_op(int code)
{
	/* Execute the diadic operation "code" (arithmetic or boolean) and push
	 * the result back on the stack.
	 * Instead of poping the two operands and pushing the result back, we handle
	 * the references of both, poping only the second. I am relying on the fact
	 * that the last poped value remains uccorrupted in a non-freed chunk--RAM.
	 */

	EIF_GET_CONTEXT
	EIF_TYPED_VALUE *second;		/* Second operand */
	EIF_TYPED_VALUE *first;			/* First operand */

#define f first
#define s second

	s = eif_opstack_pop_address(&op_stack);			/* Fetch second operand */
	f = EIF_STACK_TOP_ADDRESS(op_stack);			/* First operand will be replace by result */
	CHECK("first not null", f);

	switch (code) {				/* Execute operation */

	/* And operation (boolean). */
	case BC_AND:
		f->it_char = (EIF_BOOLEAN) (f->it_char && s->it_char);
		break;

	/* Or operation (boolean). */
	case BC_OR:
		f->it_char = (EIF_BOOLEAN) (f->it_char || s->it_char);
		break;

	/* Xor operation (boolean). */
	case BC_XOR:
		f->it_char = (EIF_BOOLEAN) ((f->it_char && !s->it_char) ||
			(!f->it_char && s->it_char));
		break;

	/* Lesser or equal operation. */
	case BC_LE:
		eif_interp_le(f, s);
		break;

	/* Lesser than operation. */
	case BC_LT:
		eif_interp_lt (f, s);
		break;

	/* Greater or equal operation. */
	case BC_GE:
		eif_interp_ge (f, s);
		break;

	/* Greater than operation. */
	case BC_GT:
		eif_interp_gt (f, s);
		break;

	/* Equality operation. */
	case BC_EQ:
		eif_interp_eq (f, s);
		break;

	/* Different operation (not equal). */
	case BC_NE:
		eif_interp_eq (f, s);
		f->it_char = EIF_TEST(!f->it_char);
		break;

	/* Minus operation. */
	case BC_MINUS: {
		uint32 sk_type = f->type & SK_HEAD;
			/* Special case for `-' from CHARACTER_8 and CHARACTER_32 class. */
		if (sk_type == SK_CHAR8) {
			CHECK ("right operand is INTEGER_32", (s->type & SK_HEAD) == SK_INT32);
			f->it_char = f->it_char - (EIF_CHARACTER_8) s->it_int32;
		} else if (sk_type == SK_CHAR32) {
			CHECK ("right operand is NATURAL_32", (s->type & SK_HEAD) == SK_UINT32);
			f->it_wchar = f->it_wchar - s->it_uint32;
		} else {
				/* Normal case of substraction between numeric types. */
			CHECK ("same_type", (f->type & SK_HEAD) == (s->type & SK_HEAD));
			switch(sk_type) {
				case SK_UINT8: f->it_uint8 = f->it_uint8 - s->it_uint8; break;
				case SK_UINT16: f->it_uint16 = f->it_uint16 - s->it_uint16; break;
				case SK_UINT32: f->it_uint32 = f->it_uint32 - s->it_uint32; break;
				case SK_UINT64: f->it_uint64 = f->it_uint64 - s->it_uint64; break;
				case SK_INT8: f->it_int8 = f->it_int8 - s->it_int8; break;
				case SK_INT16: f->it_int16 = f->it_int16 - s->it_int16; break;
				case SK_INT32: f->it_int32 = f->it_int32 - s->it_int32; break;
				case SK_INT64: f->it_int64 = f->it_int64 - s->it_int64; break;
				case SK_REAL32: f->it_real32 = f->it_real32 - s->it_real32; break;
				case SK_REAL64: f->it_real64 = f->it_real64 - s->it_real64; break;
				default: eif_panic(MTC RT_BOTCHED_MSG);
			}
		}
		}
		break;

	/* Plus operator. */
	case BC_PLUS: {
		uint32 sk_type = f->type & SK_HEAD;
			/* Special case for `+' from CHARACTER_8 and CHARACTER_32 class. */
		if (sk_type == SK_CHAR8) {
			CHECK ("right operand is INTEGER_32", (s->type & SK_HEAD) == SK_INT32);
			f->it_char = f->it_char + (EIF_CHARACTER_8) s->it_int32;
		} else if (sk_type == SK_CHAR32) {
			CHECK ("right operand is NATURAL_32", (s->type & SK_HEAD) == SK_UINT32);
			f->it_wchar = f->it_wchar + s->it_uint32;
		} else {
				/* Normal case of addition between numeric types. */
			CHECK ("same_type", (f->type & SK_HEAD) == (s->type & SK_HEAD));
			switch(sk_type) {
				case SK_UINT8: f->it_uint8 = f->it_uint8 + s->it_uint8; break;
				case SK_UINT16: f->it_uint16 = f->it_uint16 + s->it_uint16; break;
				case SK_UINT32: f->it_uint32 = f->it_uint32 + s->it_uint32; break;
				case SK_UINT64: f->it_uint64 = f->it_uint64 + s->it_uint64; break;
				case SK_INT8: f->it_int8 = f->it_int8 + s->it_int8; break;
				case SK_INT16: f->it_int16 = f->it_int16 + s->it_int16; break;
				case SK_INT32: f->it_int32 = f->it_int32 + s->it_int32; break;
				case SK_INT64: f->it_int64 = f->it_int64 + s->it_int64; break;
				case SK_REAL32: f->it_real32 = f->it_real32 + s->it_real32; break;
				case SK_REAL64: f->it_real64 = f->it_real64 + s->it_real64; break;
				default: eif_panic(MTC RT_BOTCHED_MSG);
			}
		}
		}
		break;

	/* Power operator. */
	case BC_POWER:
		CHECK("double_type", (s->type & SK_HEAD) == SK_REAL64);
		switch (f->type & SK_HEAD) {
			case SK_UINT8: f->it_real64 = (EIF_REAL_64) pow ((EIF_REAL_64)f->it_uint8, s->it_real64); break;
			case SK_UINT16: f->it_real64 = (EIF_REAL_64) pow ((EIF_REAL_64)f->it_uint16, s->it_real64); break;
			case SK_UINT32: f->it_real64 = (EIF_REAL_64) pow ((EIF_REAL_64)f->it_uint32, s->it_real64); break;
			case SK_UINT64: f->it_real64 = (EIF_REAL_64) pow (eif_uint64_to_real64(f->it_uint64), s->it_real64); break;
			case SK_INT8: f->it_real64 = (EIF_REAL_64) pow ((EIF_REAL_64)f->it_int8, s->it_real64); break;
			case SK_INT16: f->it_real64 = (EIF_REAL_64) pow ((EIF_REAL_64)f->it_int16, s->it_real64); break;
			case SK_INT32: f->it_real64 = (EIF_REAL_64) pow ((EIF_REAL_64)f->it_int32, s->it_real64); break;
			case SK_INT64: f->it_real64 = (EIF_REAL_64) pow ((EIF_REAL_64)f->it_int64, s->it_real64); break;
			case SK_REAL32: f->it_real64 = (EIF_REAL_64) pow ((EIF_REAL_64)f->it_real32, s->it_real64); break;
			case SK_REAL64: f->it_real64 = (EIF_REAL_64) pow (f->it_real64, s->it_real64); break;
			default:
				eif_panic(MTC RT_BOTCHED_MSG);
		}
		f->type = SK_REAL64;
		break;

	/* Multiplication operator. */
	case BC_STAR: {
		uint32 sk_type = s->type & SK_HEAD;
		CHECK ("same_type", (f->type & SK_HEAD) == (s->type & SK_HEAD));
		switch(sk_type) {
			case SK_UINT8: f->it_uint8 = f->it_uint8 * s->it_uint8; break;
			case SK_UINT16: f->it_uint16 = f->it_uint16 * s->it_uint16; break;
			case SK_UINT32: f->it_uint32 = f->it_uint32 * s->it_uint32; break;
			case SK_UINT64: f->it_uint64 = f->it_uint64 * s->it_uint64; break;
			case SK_INT8: f->it_int8 = f->it_int8 * s->it_int8; break;
			case SK_INT16: f->it_int16 = f->it_int16 * s->it_int16; break;
			case SK_INT32: f->it_int32 = f->it_int32 * s->it_int32; break;
			case SK_INT64: f->it_int64 = f->it_int64 * s->it_int64; break;
			case SK_REAL32: f->it_real32 = f->it_real32 * s->it_real32; break;
			case SK_REAL64: f->it_real64 = f->it_real64 * s->it_real64; break;
			default: eif_panic(MTC RT_BOTCHED_MSG);
		}
		}
		break;

	/* Real division operator. */
	case BC_SLASH: {
		uint32 sk_type = s->type & SK_HEAD;
		CHECK ("same_type", (f->type & SK_HEAD) == (s->type & SK_HEAD));
		switch(sk_type) {
			case SK_UINT8: f->it_real64 = (EIF_REAL_64) f->it_uint8 / (EIF_REAL_64) s->it_uint8; break;
			case SK_UINT16: f->it_real64 = (EIF_REAL_64) f->it_uint16 / (EIF_REAL_64) s->it_uint16; break;
			case SK_UINT32: f->it_real64 = (EIF_REAL_64) f->it_uint32 / (EIF_REAL_64) s->it_uint32; break;
			case SK_UINT64: f->it_real64 = eif_uint64_to_real64(f->it_uint64) / eif_uint64_to_real64(s->it_uint64); break;
			case SK_INT8: f->it_real64 = (EIF_REAL_64) f->it_int8 / (EIF_REAL_64) s->it_int8; break;
			case SK_INT16: f->it_real64 = (EIF_REAL_64) f->it_int16 / (EIF_REAL_64) s->it_int16; break;
			case SK_INT32: f->it_real64 = (EIF_REAL_64) f->it_int32 / (EIF_REAL_64) s->it_int32; break;
			case SK_INT64: f->it_real64 = (EIF_REAL_64) f->it_int64 / (EIF_REAL_64) s->it_int64; break;
			case SK_REAL32: f->it_real32 = f->it_real32 / s->it_real32; break;
			case SK_REAL64: f->it_real64 = f->it_real64 / s->it_real64; break;
			default: eif_panic(MTC RT_BOTCHED_MSG);
		}
		if ((sk_type != SK_REAL64) && (sk_type != SK_REAL32))
		  		/* First type was before an integer that we divided with another
				 * integer. In that case the return type is always a REAL_64. */
			f->type = SK_REAL64;
		else
			f->type = sk_type;
		}
		break;

	/* Integer division operator. */
	case BC_DIV: {
		uint32 sk_type = s->type & SK_HEAD;
		CHECK ("same_type", (f->type & SK_HEAD) == (s->type & SK_HEAD));
		switch(sk_type) {
			case SK_UINT8: f->it_uint8 = f->it_uint8 / s->it_uint8; break;
			case SK_UINT16: f->it_uint16 = f->it_uint16 / s->it_uint16; break;
			case SK_UINT32: f->it_uint32 = f->it_uint32 / s->it_uint32; break;
			case SK_UINT64: f->it_uint64 = f->it_uint64 / s->it_uint64; break;
			case SK_INT8: f->it_int8 = f->it_int8 / s->it_int8; break;
			case SK_INT16: f->it_int16 = f->it_int16 / s->it_int16; break;
			case SK_INT32: f->it_int32 = f->it_int32 / s->it_int32; break;
			case SK_INT64: f->it_int64 = f->it_int64 / s->it_int64; break;
			default: eif_panic(MTC RT_BOTCHED_MSG);
		}
		}
		break;

	/* Modulo operator. */
	case BC_MOD: {
		uint32 sk_type = s->type & SK_HEAD;
		CHECK ("same_type", (f->type & SK_HEAD) == (s->type & SK_HEAD));
		switch(sk_type) {
			case SK_UINT8: f->it_uint8 = f->it_uint8 % s->it_uint8; break;
			case SK_UINT16: f->it_uint16 = f->it_uint16 % s->it_uint16; break;
			case SK_UINT32: f->it_uint32 = f->it_uint32 % s->it_uint32; break;
			case SK_UINT64: f->it_uint64 = f->it_uint64 % s->it_uint64; break;
			case SK_INT8: f->it_int8 = f->it_int8 % s->it_int8; break;
			case SK_INT16: f->it_int16 = f->it_int16 % s->it_int16; break;
			case SK_INT32: f->it_int32 = f->it_int32 % s->it_int32; break;
			case SK_INT64: f->it_int64 = f->it_int64 % s->it_int64; break;
			default: eif_panic(MTC RT_BOTCHED_MSG);
		}
		}
		break;

	default:
		CHECK ("Found invalid diadic opcode", 0);
	}

#undef s
#undef f
}

rt_private void eif_interp_gt(EIF_TYPED_VALUE *f, EIF_TYPED_VALUE *s) {
	switch(f->type & SK_HEAD) {
		case SK_CHAR8: f->it_char = EIF_TEST(f->it_char > s->it_char); break;
		case SK_CHAR32: f->it_char = EIF_TEST(f->it_wchar > s->it_wchar); break;
		case SK_UINT8: f->it_char = EIF_TEST(f->it_uint8 > s->it_uint8); break;
		case SK_UINT16: f->it_char = EIF_TEST(f->it_uint16 > s->it_uint16); break;
		case SK_UINT32: f->it_char = EIF_TEST(f->it_uint32 > s->it_uint32); break;
		case SK_UINT64: f->it_char = EIF_TEST(f->it_uint64 > s->it_uint64); break;
		case SK_INT8: f->it_char = EIF_TEST(f->it_int8 > s->it_int8); break;
		case SK_INT16: f->it_char = EIF_TEST(f->it_int16 > s->it_int16); break;
		case SK_INT32: f->it_char = EIF_TEST(f->it_int32 > s->it_int32); break;
		case SK_INT64: f->it_char = EIF_TEST(f->it_int64 > s->it_int64); break;
		case SK_REAL32:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real32 > s->it_real32);
			} else {
				f->it_char = EIF_TEST(eif_is_greater_real_32(f->it_real32, s->it_real32));
			}
			break;
		case SK_REAL64:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real64 > s->it_real64);
			} else {
				f->it_char = EIF_TEST(eif_is_greater_real_64(f->it_real64, s->it_real64));
			}
			break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	f->type = SK_BOOL;		/* Result is a boolean */
}

rt_private void eif_interp_ge(EIF_TYPED_VALUE *f, EIF_TYPED_VALUE *s) {
	switch(f->type & SK_HEAD) {
		case SK_CHAR8: f->it_char = EIF_TEST(f->it_char >= s->it_char); break;
		case SK_CHAR32: f->it_char = EIF_TEST(f->it_wchar >= s->it_wchar); break;
		case SK_UINT8: f->it_char = EIF_TEST(f->it_uint8 >= s->it_uint8); break;
		case SK_UINT16: f->it_char = EIF_TEST(f->it_uint16 >= s->it_uint16); break;
		case SK_UINT32: f->it_char = EIF_TEST(f->it_uint32 >= s->it_uint32); break;
		case SK_UINT64: f->it_char = EIF_TEST(f->it_uint64 >= s->it_uint64); break;
		case SK_INT8: f->it_char = EIF_TEST(f->it_int8 >= s->it_int8); break;
		case SK_INT16: f->it_char = EIF_TEST(f->it_int16 >= s->it_int16); break;
		case SK_INT32: f->it_char = EIF_TEST(f->it_int32 >= s->it_int32); break;
		case SK_INT64: f->it_char = EIF_TEST(f->it_int64 >= s->it_int64); break;
		case SK_REAL32:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real32 >= s->it_real32);
			} else {
				f->it_char = EIF_TEST(eif_is_greater_equal_real_32(f->it_real32, s->it_real32));
			}
			break;
		case SK_REAL64:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real64 >= s->it_real64);
			} else {
				f->it_char = EIF_TEST(eif_is_greater_equal_real_64(f->it_real64, s->it_real64));
			}
			break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	f->type = SK_BOOL;		/* Result is a boolean */
}

rt_private void eif_interp_lt(EIF_TYPED_VALUE *f, EIF_TYPED_VALUE *s) {
	switch(f->type & SK_HEAD) {
		case SK_CHAR8: f->it_char = EIF_TEST(f->it_char < s->it_char); break;
		case SK_CHAR32: f->it_char = EIF_TEST(f->it_wchar < s->it_wchar); break;
		case SK_UINT8: f->it_char = EIF_TEST(f->it_uint8 < s->it_uint8); break;
		case SK_UINT16: f->it_char = EIF_TEST(f->it_uint16 < s->it_uint16); break;
		case SK_UINT32: f->it_char = EIF_TEST(f->it_uint32 < s->it_uint32); break;
		case SK_UINT64: f->it_char = EIF_TEST(f->it_uint64 < s->it_uint64); break;
		case SK_INT8: f->it_char = EIF_TEST(f->it_int8 < s->it_int8); break;
		case SK_INT16: f->it_char = EIF_TEST(f->it_int16 < s->it_int16); break;
		case SK_INT32: f->it_char = EIF_TEST(f->it_int32 < s->it_int32); break;
		case SK_INT64: f->it_char = EIF_TEST(f->it_int64 < s->it_int64); break;
		case SK_REAL32:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real32 < s->it_real32);
			} else {
				f->it_char = EIF_TEST(eif_is_less_real_32(f->it_real32, s->it_real32));
			}
			break;
		case SK_REAL64:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real64 < s->it_real64);
			} else {
				f->it_char = EIF_TEST(eif_is_less_real_64(f->it_real64, s->it_real64));
			}
			break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	f->type = SK_BOOL;		/* Result is a boolean */
}

rt_private void eif_interp_le(EIF_TYPED_VALUE *f, EIF_TYPED_VALUE *s) {
	switch(f->type & SK_HEAD) {
		case SK_CHAR8: f->it_char = EIF_TEST(f->it_char <= s->it_char); break;
		case SK_CHAR32: f->it_char = EIF_TEST(f->it_wchar <= s->it_wchar); break;
		case SK_UINT8: f->it_char = EIF_TEST(f->it_uint8 <= s->it_uint8); break;
		case SK_UINT16: f->it_char = EIF_TEST(f->it_uint16 <= s->it_uint16); break;
		case SK_UINT32: f->it_char = EIF_TEST(f->it_uint32 <= s->it_uint32); break;
		case SK_UINT64: f->it_char = EIF_TEST(f->it_uint64 <= s->it_uint64); break;
		case SK_INT8: f->it_char = EIF_TEST(f->it_int8 <= s->it_int8); break;
		case SK_INT16: f->it_char = EIF_TEST(f->it_int16 <= s->it_int16); break;
		case SK_INT32: f->it_char = EIF_TEST(f->it_int32 <= s->it_int32); break;
		case SK_INT64: f->it_char = EIF_TEST(f->it_int64 <= s->it_int64); break;
		case SK_REAL32:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real32 <= s->it_real32);
			} else {
				f->it_char = EIF_TEST(eif_is_less_equal_real_32(f->it_real32, s->it_real32));
			}
			break;
		case SK_REAL64:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real64 <= s->it_real64);
			} else {
				f->it_char = EIF_TEST(eif_is_less_equal_real_64(f->it_real64, s->it_real64));
			}
			break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	f->type = SK_BOOL;		/* Result is a boolean */
}

rt_private void eif_interp_eq (EIF_TYPED_VALUE *f, EIF_TYPED_VALUE *s) {
	switch(f->type & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR8: f->it_char = EIF_TEST(f->it_char == s->it_char); break;
		case SK_CHAR32: f->it_char = EIF_TEST(f->it_wchar == s->it_wchar); break;
		case SK_UINT8: f->it_char = EIF_TEST(f->it_uint8 == s->it_uint8); break;
		case SK_UINT16: f->it_char = EIF_TEST(f->it_uint16 == s->it_uint16); break;
		case SK_UINT32: f->it_char = EIF_TEST(f->it_uint32 == s->it_uint32); break;
		case SK_UINT64: f->it_char = EIF_TEST(f->it_uint64 == s->it_uint64); break;
		case SK_INT8: f->it_char = EIF_TEST(f->it_int8 == s->it_int8); break;
		case SK_INT16: f->it_char = EIF_TEST(f->it_int16 == s->it_int16); break;
		case SK_INT32: f->it_char = EIF_TEST(f->it_int32 == s->it_int32); break;
		case SK_INT64: f->it_char = EIF_TEST(f->it_int64 == s->it_int64); break;
		case SK_REAL32:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real32 == s->it_real32);
			} else {
				f->it_char = EIF_TEST(eif_is_equal_real_32(f->it_real32, s->it_real32));
			}
			break;
		case SK_REAL64:
			if (egc_has_ieee_semantic) {
				f->it_char = EIF_TEST(f->it_real64 == s->it_real64);
			} else {
				f->it_char = EIF_TEST(eif_is_equal_real_64(f->it_real64, s->it_real64));
			}
			break;
		case SK_POINTER: f->it_char = EIF_TEST(f->it_ptr == s->it_ptr); break;
		case SK_EXP:
		case SK_REF: f->it_char = EIF_TEST(f->it_ref == s->it_ref); break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	f->type = SK_BOOL;		/* Result is a boolean */
}

rt_private void eif_interp_generator__s1 (struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top)
{
	/* Execute the `generator' or `generating_type' function call for basic types
	 * in melted code
	 */
	EIF_GET_CONTEXT
	RT_GET_CONTEXT
	EIF_TYPED_VALUE *first;			/* First operand */
	unsigned char *OLD_IC = IC;
	unsigned long stagval = tagval;	/* Tag value backup */

	OLD_IC = IC;

	first = EIF_STACK_TOP_ADDRESS(op_stack);				/* First operand will be replace by result */
	CHECK("first not null", first);
	switch (first->type & SK_HEAD) {
		case SK_BOOL: first->it_ref = RTMS_EX("BOOLEAN", 7); break;
		case SK_CHAR8: first->it_ref = RTMS_EX("CHARACTER_8", 11); break;
		case SK_CHAR32: first->it_ref = RTMS_EX("CHARACTER_32", 12); break;
		case SK_UINT8: first->it_ref = RTMS_EX("NATURAL_8", 9); break;
		case SK_UINT16: first->it_ref = RTMS_EX("NATURAL_16", 10); break;
		case SK_UINT32: first->it_ref = RTMS_EX("NATURAL_32", 10); break;
		case SK_UINT64: first->it_ref = RTMS_EX("NATURAL_64", 10); break;
		case SK_INT8: first->it_ref = RTMS_EX("INTEGER_8", 9); break;
		case SK_INT16: first->it_ref = RTMS_EX("INTEGER_16", 10); break;
		case SK_INT32: first->it_ref = RTMS_EX("INTEGER_32", 10); break;
		case SK_INT64: first->it_ref = RTMS_EX("INTEGER_64", 10); break;
		case SK_REAL32: first->it_ref = RTMS_EX("REAL_32", 7); break;
		case SK_REAL64: first->it_ref = RTMS_EX("REAL_64", 7); break;
		case SK_POINTER: first->it_ref = RTMS_EX("POINTER", 7); break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	first->type = SK_REF;

	IC = OLD_IC;
	if (tagval != stagval) {		/* previous call can call malloc which may call the interpreter for
								   creation routines. */
		sync_registers(stack_cur, stack_top);
	}
}

rt_private void eif_interp_generator__s4 (struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top)
{
	/* Execute the `generator' or `generating_type' function call for basic types
	 * in melted code
	 */
	EIF_GET_CONTEXT
	RT_GET_CONTEXT
	EIF_TYPED_VALUE *first;			/* First operand */
	unsigned char *OLD_IC = IC;
	unsigned long stagval = tagval;	/* Tag value backup */

	OLD_IC = IC;

	first = EIF_STACK_TOP_ADDRESS(op_stack);				/* First operand will be replace by result */
	CHECK("first not null", first);
	switch (first->type & SK_HEAD) {
		case SK_BOOL:    first->it_ref = RTMS32_EX("B\0\0\0O\0\0\0O\0\0\0L\0\0\0E\0\0\0A\0\0\0N\0\0\0", 7); break;
		case SK_CHAR8:   first->it_ref = RTMS32_EX("C\0\0\0H\0\0\0A\0\0\0R\0\0\0A\0\0\0C\0\0\0T\0\0\0E\0\0\0R\0\0\0_\0\0\0" "8\0\0\0", 11); break;
		case SK_CHAR32:  first->it_ref = RTMS32_EX("C\0\0\0H\0\0\0A\0\0\0R\0\0\0A\0\0\0C\0\0\0T\0\0\0E\0\0\0R\0\0\0_\0\0\0" "3\0\0\0" "2\0\0\0", 12); break;
		case SK_UINT8:   first->it_ref = RTMS32_EX("N\0\0\0A\0\0\0T\0\0\0U\0\0\0R\0\0\0A\0\0\0L\0\0\0_\0\0\0" "8\0\0\0", 9); break;
		case SK_UINT16:  first->it_ref = RTMS32_EX("N\0\0\0A\0\0\0T\0\0\0U\0\0\0R\0\0\0A\0\0\0L\0\0\0_\0\0\0" "1\0\0\0" "6\0\0\0", 10); break;
		case SK_UINT32:  first->it_ref = RTMS32_EX("N\0\0\0A\0\0\0T\0\0\0U\0\0\0R\0\0\0A\0\0\0L\0\0\0_\0\0\0" "3\0\0\0" "2\0\0\0", 10); break;
		case SK_UINT64:  first->it_ref = RTMS32_EX("N\0\0\0A\0\0\0T\0\0\0U\0\0\0R\0\0\0A\0\0\0L\0\0\0_\0\0\0" "6\0\0\0" "4\0\0\0", 10); break;
		case SK_INT8:    first->it_ref = RTMS32_EX("I\0\0\0N\0\0\0T\0\0\0E\0\0\0G\0\0\0E\0\0\0R\0\0\0_\0\0\0" "8\0\0\0", 9); break;
		case SK_INT16:   first->it_ref = RTMS32_EX("I\0\0\0N\0\0\0T\0\0\0E\0\0\0G\0\0\0E\0\0\0R\0\0\0_\0\0\0" "1\0\0\0" "6\0\0\0", 10); break;
		case SK_INT32:   first->it_ref = RTMS32_EX("I\0\0\0N\0\0\0T\0\0\0E\0\0\0G\0\0\0E\0\0\0R\0\0\0_\0\0\0" "3\0\0\0" "2\0\0\0", 10); break;
		case SK_INT64:   first->it_ref = RTMS32_EX("I\0\0\0N\0\0\0T\0\0\0E\0\0\0G\0\0\0E\0\0\0R\0\0\0_\0\0\0" "6\0\0\0" "4\0\0\0", 10); break;
		case SK_REAL32:  first->it_ref = RTMS32_EX("R\0\0\0E\0\0\0A\0\0\0L\0\0\0_\0\0\0" "3\0\0\0" "2\0\0\0", 7); break;
		case SK_REAL64:  first->it_ref = RTMS32_EX("R\0\0\0E\0\0\0A\0\0\0L\0\0\0_\0\0\0" "6\0\0\0" "4\0\0\0", 7); break;
		case SK_POINTER: first->it_ref = RTMS32_EX("P\0\0\0O\0\0\0I\0\0\0N\0\0\0T\0\0\0E\0\0\0R\0\0\0", 7); break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	first->type = SK_REF;

	IC = OLD_IC;
	if (tagval != stagval) {		/* previous call can call malloc which may call the interpreter for
								   creation routines. */
		sync_registers(stack_cur, stack_top);
	}
}

rt_private void eif_interp_min_max (int code)
{
	/* Execute the `max' or `min' operation (shown by "code") on CHARACTER_8,
	 * INTEGER, REAL and DOUBLE and push the result back on the stack.
	 * Instead of poping the two operands and pushing the result back, we handle
	 * the references of both, poping only the second. I am relying on the fact
	 * that the last poped value remains uccorrupted in a non-freed chunk--RAM.
	 */
#define EIF_MAX(a,b) ((a)>(b)? (a) : (b))
#define EIF_MAX_REAL(a,b) (((a) != (a)) || ((a) > (b)) ? (a) : (b))
#define EIF_MIN(a,b) ((a)<(b)? (a) : (b))
#define EIF_MIN_REAL(a,b) (((a) != (a)) || ((a) < (b)) ? (a) : (b))

	EIF_GET_CONTEXT
	EIF_TYPED_VALUE *second;		/* Second operand */
	EIF_TYPED_VALUE *first;			/* First operand */

	second = eif_opstack_pop_address(&op_stack);			/* Fetch second operand */
	first = EIF_STACK_TOP_ADDRESS(op_stack);				/* First operand will be replace by result */
	CHECK("first not null", first);

	switch (code) {				/* Execute operation */
		case BC_MAX:
			switch(first->type & SK_HEAD) {
				case SK_CHAR8: first->it_char = (EIF_CHARACTER_8) EIF_MAX(first->it_char, second->it_char); break;
				case SK_CHAR32: first->it_wchar = (EIF_CHARACTER_8) EIF_MAX(first->it_wchar, second->it_wchar); break;
				case SK_UINT8: first->it_uint8 = (EIF_NATURAL_8) EIF_MAX(first->it_uint8, second->it_uint8); break;
				case SK_UINT16: first->it_uint16 = (EIF_NATURAL_16) EIF_MAX(first->it_uint16, second->it_uint16); break;
				case SK_UINT32: first->it_uint32 = (EIF_NATURAL_32) EIF_MAX(first->it_uint32, second->it_uint32); break;
				case SK_UINT64: first->it_uint64 = (EIF_NATURAL_64) EIF_MAX(first->it_uint64, second->it_uint64); break;
				case SK_INT8: first->it_int8 = (EIF_INTEGER_8) EIF_MAX(first->it_int8, second->it_int8); break;
				case SK_INT16: first->it_int16 = (EIF_INTEGER_16) EIF_MAX(first->it_int16, second->it_int16); break;
				case SK_INT32: first->it_int32 = (EIF_INTEGER_32) EIF_MAX(first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = (EIF_INTEGER_64) EIF_MAX(first->it_int64, second->it_int64); break;
				case SK_REAL32:
					if (egc_has_ieee_semantic) {
						first->it_real32 = EIF_MAX_REAL(first->it_real32, second->it_real32);
					} else {
						first->it_real32 = (eif_is_greater_equal_real_32(first->it_real32, second->it_real32) ? first->it_real32 : second->it_real32);
					}
					break;
				case SK_REAL64:
					if (egc_has_ieee_semantic) {
						first->it_real64 = EIF_MAX_REAL(first->it_real64, second->it_real64);
					} else {
						first->it_real64 = (eif_is_greater_equal_real_64(first->it_real64, second->it_real64) ? first->it_real64 : second->it_real64);
					}
					break;
				default: eif_panic(MTC RT_BOTCHED_MSG);
				}
			break;
		case BC_MIN:
			switch(first->type & SK_HEAD) {
				case SK_CHAR8: first->it_char = (EIF_CHARACTER_8) EIF_MIN(first->it_char, second->it_char); break;
				case SK_CHAR32: first->it_wchar = (EIF_CHARACTER_8) EIF_MIN(first->it_wchar, second->it_wchar); break;
				case SK_UINT8: first->it_uint8 = (EIF_NATURAL_8) EIF_MIN(first->it_uint8, second->it_uint8); break;
				case SK_UINT16: first->it_uint16 = (EIF_NATURAL_16) EIF_MIN(first->it_uint16, second->it_uint16); break;
				case SK_UINT32: first->it_uint32 = (EIF_NATURAL_32) EIF_MIN(first->it_uint32, second->it_uint32); break;
				case SK_UINT64: first->it_uint64 = (EIF_NATURAL_64) EIF_MIN(first->it_uint64, second->it_uint64); break;
				case SK_INT8: first->it_int8 = (EIF_INTEGER_8) EIF_MIN(first->it_int8, second->it_int8); break;
				case SK_INT16: first->it_int16 = (EIF_INTEGER_16) EIF_MIN(first->it_int16, second->it_int16); break;
				case SK_INT32: first->it_int32 = (EIF_INTEGER_32) EIF_MIN(first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = (EIF_INTEGER_64) EIF_MIN(first->it_int64, second->it_int64); break;
				case SK_REAL32:
					if (egc_has_ieee_semantic) {
						first->it_real32 = EIF_MIN_REAL(first->it_real32, second->it_real32);
					} else {
						first->it_real32 = (eif_is_less_equal_real_32(first->it_real32, second->it_real32) ? first->it_real32 : second->it_real32);
					}
					break;
				case SK_REAL64:
					if (egc_has_ieee_semantic) {
						first->it_real64 = EIF_MIN_REAL(first->it_real64, second->it_real64);
					} else {
						first->it_real64 = (eif_is_less_equal_real_64(first->it_real64, second->it_real64) ? first->it_real64 : second->it_real64);
					}
					break;
				default: eif_panic(MTC RT_BOTCHED_MSG);
				}
			break;
	}
#undef EIF_MAX
#undef EIF_MIN
}

/*
doc:	<routine name="eif_three_way_comparison" return_type="void" export="private">
doc:		<summary>Emulate call to `three_way_comparison' for basic types inheriting from COMPARABLE.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</routine>
*/

rt_private void eif_three_way_comparison (void)
{
#define EIF_THREE_WAY_COMPARISON(a,b) ((a)<(b)? -1 : ((b)<(a) ? 1 : 0))

	EIF_GET_CONTEXT
	EIF_TYPED_VALUE *second;		/* Second operand */
	EIF_TYPED_VALUE *first;			/* First operand */

	second = eif_opstack_pop_address(&op_stack);			/* Fetch second operand */
	first = EIF_STACK_TOP_ADDRESS(op_stack);				/* First operand will be replace by result */
	CHECK("first not null", first);

	REQUIRE("Same type", (first->type & SK_HEAD) == (second->type & SK_HEAD));

	switch(first->type & SK_HEAD) {
		case SK_CHAR8: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_char, second->it_char); break;
		case SK_CHAR32: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_wchar, second->it_wchar); break;
		case SK_UINT8: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_uint8, second->it_uint8); break;
		case SK_UINT16: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_uint16, second->it_uint16); break;
		case SK_UINT32: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_uint32, second->it_uint32); break;
		case SK_UINT64: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_uint64, second->it_uint64); break;
		case SK_INT8: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_int8, second->it_int8); break;
		case SK_INT16: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_int16, second->it_int16); break;
		case SK_INT32: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_int32, second->it_int32); break;
		case SK_INT64: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_int64, second->it_int64); break;
		case SK_REAL32:
			if (egc_has_ieee_semantic) {
				first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_real32, second->it_real32);
			} else {
				first->it_int32 = (eif_is_less_real_32(first->it_real32, second->it_real32) ? -1 :
					eif_is_less_real_32(second->it_real32, first->it_real32) ? 1 : 0);
			}
			break;
		case SK_REAL64:
			if (egc_has_ieee_semantic) {
				first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_real64, second->it_real64);
			} else {
				first->it_int32 = (eif_is_less_real_64(first->it_real64, second->it_real64) ? -1 :
					eif_is_less_real_64(second->it_real64, first->it_real64) ? 1 : 0);
			}
			break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}

	first->type = SK_INT32;

	ENSURE("New type", (first->type & SK_HEAD) == SK_INT32);
#undef EIF_THREE_WAY_COMPARISON
}

rt_private void eif_interp_offset(void)
{
	/* Execute the `+' operator on CHARACTER_8 or POINTER type and push
	 * the result back on the stack.
	 * Instead of poping the two operands and pushing the result back, we handle
	 * the references of both, poping only the second. I am relying on the fact
	 * that the last poped value remains uccorrupted in a non-freed chunk--RAM.
	 */

	EIF_GET_CONTEXT
	EIF_TYPED_VALUE *second;		/* Second operand */
	EIF_TYPED_VALUE *first;			/* First operand */

	second = eif_opstack_pop_address(&op_stack);			/* Fetch second operand */
	first = EIF_STACK_TOP_ADDRESS(op_stack);				/* First operand will be replace by result */
	CHECK("first not null", first);
	switch(first->type & SK_HEAD) {
		case SK_CHAR8:
			first->it_char = (EIF_CHARACTER_8) (((EIF_INTEGER_32) first->it_char) + second->it_int32);
			break;
		case SK_POINTER:
			first->it_ptr = RTPOF(first->it_ptr, second->it_int32);
			break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
}

rt_private void eif_interp_builtins (struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top)
	/* Execute builtin operations and set result if any. */
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT

	int code = *IC++;		/* Read current byte-code and advance IC */
	unsigned char *OLD_IC = IC;
	unsigned long stagval = tagval;	/* Tag value backup */

	OLD_IC = IC;

	switch (code) {
			/* `max' and `min' function calls */
		case BC_BUILTIN_UNKNOWN:
			eif_panic ("Unknown builtin");
			break;

		case BC_BUILTIN_TYPE__HAS_DEFAULT:
			iresult->type = SK_BOOL;
			iresult->it_char = eif_builtin_TYPE_has_default(icurrent->it_ref);
			break;

		case BC_BUILTIN_TYPE__DEFAULT:
				/* Nothing to be done except check the precondition as the initialization of Result
				 * is already done by interpreter. */
			RTCT("has_default", EX_PRE);
			if (eif_builtin_TYPE_has_default(icurrent->it_ref)) {
				RTCK;
			} else {
				RTCF;
			}
			break;

		case BC_BUILTIN_TYPE__TYPE_ID:
			iresult->type = SK_INT32;
			iresult->it_int32 = eif_builtin_TYPE_type_id(icurrent->it_ref);
			break;

		case BC_BUILTIN_TYPE__RUNTIME_NAME__S1:
			iresult->type = SK_REF;
			iresult->it_ref = eif_builtin_TYPE_runtime_name__s1(icurrent->it_ref);
			break;

		case BC_BUILTIN_TYPE__RUNTIME_NAME__S4:
			iresult->type = SK_REF;
			iresult->it_ref = eif_builtin_TYPE_runtime_name__s4(icurrent->it_ref);
			break;

		case BC_BUILTIN_TYPE__GENERIC_PARAMETER_TYPE:
			iresult->type = SK_REF;
			iresult->it_ref = eif_builtin_TYPE_generic_parameter_type(icurrent->it_ref,arg(1)->it_int32);
			break;

		case BC_BUILTIN_TYPE__GENERIC_PARAMETER_COUNT:
			iresult->type = SK_INT32;
			iresult->it_int32 = eif_builtin_TYPE_generic_parameter_count(icurrent->it_ref);
			break;

		case BC_BUILTIN_TYPE__IS_ATTACHED:
			iresult->type = SK_BOOL;
			iresult->it_char = eif_builtin_TYPE_is_attached(icurrent->it_ref);
			break;

		case BC_BUILTIN_TYPE__IS_DEFERRED:
			iresult->type = SK_BOOL;
			iresult->it_char = eif_builtin_TYPE_is_deferred(icurrent->it_ref);
			break;

		case BC_BUILTIN_TYPE__IS_EXPANDED:
			iresult->type = SK_BOOL;
			iresult->it_char = eif_builtin_TYPE_is_expanded(icurrent->it_ref);
			break;



		default: eif_panic (RT_BOTCHED_MSG);
	}

	IC = OLD_IC;
	if (tagval != stagval) {		/* previous call can call malloc which may call the interpreter for
								   creation routines. */
		sync_registers(stack_cur, stack_top);
	}

}


rt_private void eif_interp_basic_operations (struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top)
	/* execute basic operations on basic types and put the result back on the
	 * stack.
	 */
{
	EIF_GET_CONTEXT
	int code = *IC++;		/* Read current byte-code and advance IC */
	EIF_TYPED_VALUE *first;		/* First operand */

	switch (code) {
			/* `max' and `min' function calls */
		case BC_MIN:
		case BC_MAX:
			eif_interp_min_max (code);
			break;

			/* `three_way_comparison' on comparable basic types. */
		case BC_THREE_WAY_COMPARISON:
			eif_three_way_comparison ();
			break;

			/* `generator' and `generating_type' function calls */
		case BC_GENERATOR__S1:
			eif_interp_generator__s1 (stack_cur, stack_top);
			break;

			/* `generator' and `generating_type' function calls */
		case BC_GENERATOR__S4:
			eif_interp_generator__s4 (stack_cur, stack_top);
			break;

			/* Offset operation on CHARACTER_8 and POINTER */
		case BC_OFFSET:
			eif_interp_offset();
			break;

			/* Call to `zero' */
		case BC_ZERO:
			first = EIF_STACK_TOP_ADDRESS(op_stack);	/* First operand will be replace by result */
			CHECK("first not null", first);
			switch(first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = (EIF_NATURAL_8) 0; break;
				case SK_UINT16: first->it_uint16 = (EIF_NATURAL_16) 0; break;
				case SK_UINT32: first->it_uint32 = (EIF_NATURAL_32) 0; break;
				case SK_UINT64: first->it_uint64 = (EIF_NATURAL_64) 0; break;
				case SK_INT8: first->it_int8 = (EIF_INTEGER_8) 0; break;
				case SK_INT16: first->it_int16 = (EIF_INTEGER_16) 0; break;
				case SK_INT32: first->it_int32 = (EIF_INTEGER_32) 0; break;
				case SK_INT64: first->it_int64 = (EIF_INTEGER_64) 0; break;
				case SK_REAL32: first->it_real32 = (EIF_REAL_32) 0.0; break;
				case SK_REAL64: first->it_real64 = (EIF_REAL_64) 0.0; break;
				default: eif_panic(MTC RT_BOTCHED_MSG);
				}
			break;

			/* Call to `one' */
		case BC_ONE:
			first = EIF_STACK_TOP_ADDRESS(op_stack);	/* First operand will be replace by result */
			CHECK("first not null", first);
			switch(first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = (EIF_NATURAL_8) 1; break;
				case SK_UINT16: first->it_uint16 = (EIF_NATURAL_16) 1; break;
				case SK_UINT32: first->it_uint32 = (EIF_NATURAL_32) 1; break;
				case SK_UINT64: first->it_uint64 = (EIF_NATURAL_64) 1; break;
				case SK_INT8: first->it_int8 = (EIF_INTEGER_8) 1; break;
				case SK_INT16: first->it_int16 = (EIF_INTEGER_16) 1; break;
				case SK_INT32: first->it_int32 = (EIF_INTEGER_32) 1; break;
				case SK_INT64: first->it_int64 = (EIF_INTEGER_64) 1; break;
				case SK_REAL32: first->it_real32 = (EIF_REAL_32) 1.0; break;
				case SK_REAL64: first->it_real64 = (EIF_REAL_64) 1.0; break;
				default: eif_panic(MTC RT_BOTCHED_MSG);
				}
			break;

		case BC_NAN:
			first = EIF_STACK_TOP_ADDRESS(op_stack);	/* First operand will be replaced by result. */
			CHECK("first not null", first);
			switch(first->type & SK_HEAD) {
				case SK_REAL32: first->it_real32 = eif_real_32_nan; break;
				case SK_REAL64: first->it_real64 = eif_real_64_nan; break;
				default: eif_panic (RT_BOTCHED_MSG);
			}
			break;

		case BC_NEGATIVE_INFINITY:
			first = EIF_STACK_TOP_ADDRESS(op_stack);	/* First operand will be replaced by result. */
			CHECK("first not null", first);
			switch(first->type & SK_HEAD) {
				case SK_REAL32: first->it_real32 = eif_real_32_negative_infinity; break;
				case SK_REAL64: first->it_real64 = eif_real_64_negative_infinity; break;
				default: eif_panic (RT_BOTCHED_MSG);
			}
			break;

		case BC_POSITIVE_INFINITY:
			first = EIF_STACK_TOP_ADDRESS(op_stack);	/* First operand will be replaced by result. */
			CHECK("first not null", first);
			switch(first->type & SK_HEAD) {
				case SK_REAL32: first->it_real32 = eif_real_32_positive_infinity; break;
				case SK_REAL64: first->it_real64 = eif_real_64_positive_infinity; break;
				default: eif_panic (RT_BOTCHED_MSG);
			}
			break;

		case BC_IS_NAN:
			first = EIF_STACK_TOP_ADDRESS(op_stack);	/* First operand will be replaced by result. */
			CHECK("first not null", first);
			switch(first->type & SK_HEAD) {
				case SK_REAL32: first->it_char = EIF_TEST(first->it_real32 != first->it_real32); break;
				case SK_REAL64: first->it_char = EIF_TEST(first->it_real64 != first->it_real64); break;
				default: eif_panic (RT_BOTCHED_MSG);
			}
			first->type = SK_BOOL;
			break;

		case BC_IS_NEGATIVE_INFINITY:
			first = EIF_STACK_TOP_ADDRESS(op_stack);	/* First operand will be replaced by result. */
			CHECK("first not null", first);
			switch(first->type & SK_HEAD) {
				case SK_REAL32: first->it_char = EIF_TEST(first->it_real32 == eif_real_32_negative_infinity); break;
				case SK_REAL64: first->it_char = EIF_TEST(first->it_real64 == eif_real_64_negative_infinity); break;
				default: eif_panic (RT_BOTCHED_MSG);
			}
			first->type = SK_BOOL;
			break;

		case BC_IS_POSITIVE_INFINITY:
			first = EIF_STACK_TOP_ADDRESS(op_stack);	/* First operand will be replaced by result. */
			CHECK("first not null", first);
			switch(first->type & SK_HEAD) {
				case SK_REAL32: first->it_char = EIF_TEST(first->it_real32 == eif_real_32_positive_infinity); break;
				case SK_REAL64: first->it_char = EIF_TEST(first->it_real64 == eif_real_64_positive_infinity); break;
				default: eif_panic (RT_BOTCHED_MSG);
			}
			first->type = SK_BOOL;
			break;


		default: eif_panic (RT_BOTCHED_MSG);
	}
}

rt_private void eif_interp_bit_operations (void)
{
	/* execute bit operations on integers and the result back on the stack.
	 * Instead of poping the two operands and pushing the result back, we handle
	 * the references of both, poping only the second. I am relying on the fact
	 * that the last poped value remains uccorrupted in a non-freed chunk--RAM.
	 */

	EIF_GET_CONTEXT
	int code = *IC++;		/* Read current byte-code and advance IC */
	EIF_TYPED_VALUE *third = (EIF_TYPED_VALUE *) 0;
	EIF_TYPED_VALUE *second = (EIF_TYPED_VALUE *) 0;
	EIF_TYPED_VALUE *first = (EIF_TYPED_VALUE *) 0;

	if (code == BC_INT_SET_BIT || code == BC_INT_SET_BIT_WITH_MASK) {
		third = eif_opstack_pop_address(&op_stack);		/* Fetch third operand */
	}
	if (code != BC_INT_BIT_NOT) {
		second = eif_opstack_pop_address(&op_stack);	/* Fetch second operand if required */
	}
	first = EIF_STACK_TOP_ADDRESS(op_stack);		/* First operand, it will be replaced by result */
	CHECK("first not null", first);

	switch (code) {
		case BC_INT_BIT_AND:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = eif_bit_and (first->it_uint8, second->it_uint8); break;
				case SK_UINT16: first->it_uint16 = eif_bit_and (first->it_uint16, second->it_uint16); break;
				case SK_UINT32: first->it_uint32 = eif_bit_and (first->it_uint32, second->it_uint32); break;
				case SK_UINT64: first->it_uint64 = eif_bit_and (first->it_uint64, second->it_uint64); break;
				case SK_INT8: first->it_int8 = eif_bit_and (first->it_int8, second->it_int8); break;
				case SK_INT16: first->it_int16 = eif_bit_and (first->it_int16, second->it_int16); break;
				case SK_INT32: first->it_int32 = eif_bit_and (first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = eif_bit_and (first->it_int64, second->it_int64); break;
				}
			break;
		case BC_INT_BIT_OR:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = eif_bit_or (first->it_uint8, second->it_uint8); break;
				case SK_UINT16: first->it_uint16 = eif_bit_or (first->it_uint16, second->it_uint16); break;
				case SK_UINT32: first->it_uint32 = eif_bit_or (first->it_uint32, second->it_uint32); break;
				case SK_UINT64: first->it_uint64 = eif_bit_or (first->it_uint64, second->it_uint64); break;
				case SK_INT8: first->it_int8 = eif_bit_or (first->it_int8, second->it_int8); break;
				case SK_INT16: first->it_int16 = eif_bit_or (first->it_int16, second->it_int16); break;
				case SK_INT32: first->it_int32 = eif_bit_or (first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = eif_bit_or (first->it_int64, second->it_int64); break;
				}
			break;
		case BC_INT_BIT_XOR:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = eif_bit_xor (first->it_uint8, second->it_uint8); break;
				case SK_UINT16: first->it_uint16 = eif_bit_xor (first->it_uint16, second->it_uint16); break;
				case SK_UINT32: first->it_uint32 = eif_bit_xor (first->it_uint32, second->it_uint32); break;
				case SK_UINT64: first->it_uint64 = eif_bit_xor (first->it_uint64, second->it_uint64); break;
				case SK_INT8: first->it_int8 = eif_bit_xor (first->it_int8, second->it_int8); break;
				case SK_INT16: first->it_int16 = eif_bit_xor (first->it_int16, second->it_int16); break;
				case SK_INT32: first->it_int32 = eif_bit_xor (first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = eif_bit_xor (first->it_int64, second->it_int64); break;
				}
			break;
		case BC_INT_BIT_NOT:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = eif_bit_not (first->it_uint8); break;
				case SK_UINT16: first->it_uint16 = eif_bit_not (first->it_uint16); break;
				case SK_UINT32: first->it_uint32 = eif_bit_not (first->it_uint32); break;
				case SK_UINT64: first->it_uint64 = eif_bit_not (first->it_uint64); break;
				case SK_INT8: first->it_int8 = eif_bit_not (first->it_int8); break;
				case SK_INT16: first->it_int16 = eif_bit_not (first->it_int16); break;
				case SK_INT32: first->it_int32 = eif_bit_not (first->it_int32); break;
				case SK_INT64: first->it_int64 = eif_bit_not (first->it_int64); break;
				}
			break;
		case BC_INT_BIT_SHIFT_LEFT:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = (EIF_NATURAL_8) eif_bit_shift_left (first->it_uint8, second->it_int32); break;
				case SK_UINT16: first->it_uint16 = (EIF_NATURAL_16) eif_bit_shift_left (first->it_uint16, second->it_int32); break;
				case SK_UINT32: first->it_uint32 = (EIF_NATURAL_32) eif_bit_shift_left (first->it_uint32, second->it_int32); break;
				case SK_UINT64: first->it_uint64 = (EIF_NATURAL_64) eif_bit_shift_left (first->it_uint64, second->it_int32); break;
				case SK_INT8: first->it_int8 = (EIF_INTEGER_8) eif_bit_shift_left (first->it_int8, second->it_int32); break;
				case SK_INT16: first->it_int16 = (EIF_INTEGER_16) eif_bit_shift_left (first->it_int16, second->it_int32); break;
				case SK_INT32: first->it_int32 = (EIF_INTEGER_32) eif_bit_shift_left (first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = (EIF_INTEGER_64) eif_bit_shift_left (first->it_int64, second->it_int32); break;
				}
			break;
		case BC_INT_BIT_SHIFT_RIGHT:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = (EIF_NATURAL_8) eif_bit_shift_right (first->it_uint8, second->it_int32); break;
				case SK_UINT16: first->it_uint16 = (EIF_NATURAL_16) eif_bit_shift_right (first->it_uint16, second->it_int32); break;
				case SK_UINT32: first->it_uint32 = (EIF_NATURAL_32) eif_bit_shift_right (first->it_uint32, second->it_int32); break;
				case SK_UINT64: first->it_uint64 = (EIF_NATURAL_64) eif_bit_shift_right (first->it_uint64, second->it_int32); break;
				case SK_INT8: first->it_int8 = (EIF_INTEGER_8) eif_bit_shift_right (first->it_int8, second->it_int32); break;
				case SK_INT16: first->it_int16 = (EIF_INTEGER_16) eif_bit_shift_right (first->it_int16, second->it_int32); break;
				case SK_INT32: first->it_int32 = (EIF_INTEGER_32) eif_bit_shift_right (first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = (EIF_INTEGER_64) eif_bit_shift_right (first->it_int64, second->it_int32); break;
				}
			break;
		case BC_INT_BIT_TEST:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_char = eif_bit_test (EIF_NATURAL_8, first->it_uint8, second->it_int32); break;
				case SK_UINT16: first->it_char = eif_bit_test (EIF_NATURAL_16, first->it_uint16, second->it_int32); break;
				case SK_UINT32: first->it_char = eif_bit_test (EIF_NATURAL_32, first->it_uint32, second->it_int32); break;
				case SK_UINT64: first->it_char = eif_bit_test (EIF_NATURAL_64, first->it_uint64, second->it_int32); break;
				case SK_INT8: first->it_char = eif_bit_test (EIF_INTEGER_8, first->it_int8, second->it_int32); break;
				case SK_INT16: first->it_char = eif_bit_test (EIF_INTEGER_16, first->it_int16, second->it_int32); break;
				case SK_INT32: first->it_char = eif_bit_test (EIF_INTEGER_32, first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_char = eif_bit_test (EIF_INTEGER_64, first->it_int64, second->it_int32); break;
				}
			first->type = SK_BOOL;
			break;
		case BC_INT_SET_BIT:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = eif_set_bit (EIF_NATURAL_8, first->it_uint8, second->it_char, third->it_int32); break;
				case SK_UINT16: first->it_uint16 = eif_set_bit (EIF_NATURAL_16, first->it_uint16, second->it_char, third->it_int32); break;
				case SK_UINT32: first->it_uint32 = eif_set_bit (EIF_NATURAL_32, first->it_uint32, second->it_char, third->it_int32); break;
				case SK_UINT64: first->it_uint64 = eif_set_bit (EIF_NATURAL_64, first->it_uint64, second->it_char, third->it_int32); break;
				case SK_INT8: first->it_int8 = eif_set_bit (EIF_INTEGER_8, first->it_int8, second->it_char, third->it_int32); break;
				case SK_INT16: first->it_int16 = eif_set_bit (EIF_INTEGER_16, first->it_int16, second->it_char, third->it_int32); break;
				case SK_INT32: first->it_int32 = eif_set_bit (EIF_INTEGER_32, first->it_int32, second->it_char, third->it_int32); break;
				case SK_INT64: first->it_int64 = eif_set_bit (EIF_INTEGER_64, first->it_int64, second->it_char, third->it_int32); break;
			}
			break;
		case BC_INT_SET_BIT_WITH_MASK:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = eif_set_bit_with_mask (first->it_uint8, second->it_char, third->it_uint8); break;
				case SK_UINT16: first->it_uint16 = eif_set_bit_with_mask (first->it_uint16, second->it_char, third->it_uint16); break;
				case SK_UINT32: first->it_uint32 = eif_set_bit_with_mask (first->it_uint32, second->it_char, third->it_uint32); break;
				case SK_UINT64: first->it_uint64 = eif_set_bit_with_mask (first->it_uint64, second->it_char, third->it_uint64); break;
				case SK_INT8: first->it_int8 = eif_set_bit_with_mask (first->it_int8, second->it_char, third->it_int8); break;
				case SK_INT16: first->it_int16 = eif_set_bit_with_mask (first->it_int16, second->it_char, third->it_int16); break;
				case SK_INT32: first->it_int32 = eif_set_bit_with_mask (first->it_int32, second->it_char, third->it_int32); break;
				case SK_INT64: first->it_int64 = eif_set_bit_with_mask (first->it_int64, second->it_char, third->it_int64); break;
			}
			break;

		default: eif_panic (RT_BOTCHED_MSG);
	}
}

/*
 * Function calling routines for debugger
 */
rt_shared void dynamic_eval_dbg(int routine_id, int static_dtype, int is_basic_type, EIF_TYPED_VALUE* previous_otop, rt_uint_ptr nb_pushed, int* exception_occurred, EIF_TYPED_VALUE *result)
						/* Routine ID or offset if the feature is precompiled */
						/* Dynamic type if needed on which call is being done. Mostly used for static calls. */
						/* Is it an external or an Eiffel feature */
						/* Is the call performed on a basic type? (INTEGER...) */
						/* return the exception object if exception occurred (and set `exception_occurred' to 1) */
{
		/* This is the debugger dispatcher for routine calls. It is called when
		 * the user want to dynamically evaluate a feature. */
	EIF_GET_CONTEXT
	jmp_buf exenv;
	volatile int saved_debug_mode = debug_mode;
	uint32	type = 0;			/* Dynamic type of the result */
	EIF_TYPED_VALUE* last = NULL;

	REQUIRE("exception_occurred not null", exception_occurred);
	REQUIRE("result not null", result);

	*exception_occurred = 0;
	debug_mode = 0; /* We don't want exceptions to be caught */

	excatch(&exenv);
	if (setjmp(exenv)) {
		*exception_occurred = 1;
		result->it_ref = last_exception();
		result->type = SK_REF;
		if (result->it_ref != NULL) {
			result->type = result->type | Dtype(result->it_ref);
		}
		debug_mode = saved_debug_mode;
		exclear ();
	} else {
		dynamic_eval (routine_id, static_dtype, is_basic_type, nb_pushed);
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		if (last != NULL && last != previous_otop) { /* a result has been pushed on the stack */
			memcpy(result, eif_opstack_pop_address(&op_stack), sizeof(EIF_TYPED_VALUE));
			type = result->type & SK_HEAD;
			if ((type == SK_EXP || type == SK_REF) && (result->it_ref != NULL)) {
				result->type = type | Dtype(result->it_ref);
			}
		} else {
			result->type = SK_VOID;
		}
		debug_mode = saved_debug_mode;
		expop(&eif_stack);
	}
}

/*
 * Function calling routines
 */
rt_shared void dynamic_eval(int routine_id, int static_dtype, int is_basic_type, rt_uint_ptr nb_pushed)
						/* routine ID or offset if the feature is precompiled */
						/* Static type for the call (usually for static calls or inline agents. */
						/* Is it an external or an Eiffel feature */
						/* Is the call performed on a basic type? (INTEGER...) */
						/* Does dynamic_eval catch the exception or pass it to caller ?
						 * when called by debugger, pass it to the debugger                */
	{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	RTED;
	BODY_INDEX		body_id = 0;		/* Value of selected body ID */
	unsigned char*	OLD_IC = IC;		/* IC back up */
	uint32 			pid = 0;			/* Pattern id of the frozen feature */
	uint32 db_cstack;
	EIF_TYPED_VALUE *last;
	STACK_PRESERVE;
	RTXDR; /* declares the variables used to save the run-time stacks context */
	RTLXD;

	RTLXL;
	dstart();
	SAVE(db_stack, dcur, dtop);
	SAVE(op_stack, scur, stop);
	db_cstack = d_data.db_callstack_depth;

	excatch(&exenv);
	if (setjmp(exenv)) {
		RESTORE(op_stack,scur,stop);
		RESTORE(db_stack,dcur,dtop);
		eif_dbstack_pop_address(&db_stack);
		RTLXE;
		d_data.db_callstack_depth = db_cstack;
		RTXSC;
		IC = OLD_IC;					/* Restore IC back-up */
		in_assertion = saved_assertion; /* Corresponds to RTED */
		eif_opstack_npop(&op_stack, nb_pushed);				/* Removed the pushed arguments. */
		ereturn(MTC_NOARG);
	} else {
		if (is_basic_type) {
				/* We need to create a reference to the basic type on the fly */
			metamorphose_top(scur, stop);
		}

		if (static_dtype >= 0) {
				/* When For a static call, the call is always relative to
				 * the type declaring the inline agent or the type target of the static call. */
			CBodyId(body_id,routine_id,static_dtype);
		} else {
			last = EIF_STACK_TOP_ADDRESS(op_stack);
			CHECK("last not null", last);
			CBodyId(body_id,routine_id,Dtype(last->it_ref));
		}
		if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
			pid = (uint32) FPatId(body_id);
			(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
		} else {
			/* The proper way to start the interpretation of a melted feature is to call `xinterp'
			 * in order to initialize the calling context (which is not done by `interpret').
			 * `tagval' will therefore be set, but we have to resynchronize the registers anyway.
			 */
			xinterp(MTC melt[body_id], 0);
		}
		IC = OLD_IC;					/* Restore IC back-up */

		eif_dbstack_pop_address(&db_stack);
		d_data.db_callstack_depth = db_cstack;
		expop(&eif_stack);
	}
}

rt_private int icall(int routine_id, int ptype)
						/* routine ID */
						/* Is it an external or an Eiffel feature */
						/* Type of precursor class, if any */
{
	/* This is the interpreter dispatcher for routine calls. Depending on the
	 * routine's temperature, the snow version (i.e. C code) is called and the
	 * result, if any, is left on the operational stack. The I->C pattern is
	 * called to push the parameters on the "C stack" correctly. Otherwise,
	 * the interpreter is called. The function returns 1 to the caller if a
	 * resynchronization of registers is needed.
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	BODY_INDEX body_id;					/* Value of selected body ID */
	unsigned long stagval = tagval;	/* Save tag value */
	unsigned char *OLD_IC;					/* IC back-up */
	int result = 0;					/* A priori, no need for sync_registers */
	uint32 pid;						/* Pattern id of the frozen feature */
	EIF_TYPED_VALUE *last;

	if (ptype == -1) {
			/* Call is dynamic, we fetch the dynamic type of object at the top
			 * to find out which version we need to call. */
		last = EIF_STACK_TOP_ADDRESS(op_stack);
		CHECK("last not null", last);
		ptype = Dtype(last->it_ref);
	}
	CBodyId(body_id,routine_id,ptype);

	OLD_IC = IC;				/* IC back up */
	if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
		if (tagval != stagval)		/* Interpreted function called */
			result = 1;				/* Resynchronize registers */
	} else {
		/* The proper way to start the interpretation of a melted
		 * feature is to call `xinterp' in order to initialize the
		 * calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to
		 * resynchronize the registers anyway. --ericb
		 */
		xinterp(MTC melt[body_id], 0);

		result = 1;							/* Compulsory synchronisation */
	}
	IC = OLD_IC;					/* Restore IC back-up */
	return result;
}

rt_private void interp_check_options_start (struct eif_opt *opt, EIF_TYPE_INDEX dtype, struct stopchunk *scur, EIF_TYPED_VALUE *stop)
{
	EIF_GET_CONTEXT
	RT_GET_CONTEXT
	unsigned char * OLD_IC;
	unsigned long stagval;

	stagval = tagval;
	OLD_IC = IC;
	check_options_start(opt, dtype, 0);
	IC = OLD_IC;

	if (tagval != stagval) {
		sync_registers(scur, stop);
	}
}

rt_private void rt_attribute_access(int routine_id, uint32 type)
						/* Routine ID */
{
	/* Fetch the attribute value of feature identified by 'routine_id' of the
	 * current type, with Current being place on top of the
	 * operational stack. The value of Current is removed and the value of the
	 * attribute replace it on the stack.
	 */

	EIF_GET_CONTEXT
	EIF_REFERENCE current;							/* Current object */
	/* struct ac_info *attrinfo;*/ /* Call info for attribute */ /* %%ss removed */
	EIF_TYPED_VALUE *last;						/* Value on top of the stack */
	long offset;							/* Attribute offset */

	last = EIF_STACK_TOP_ADDRESS(op_stack);
	CHECK("last not null", last);
	current = last->it_ref;
	offset = RTWA(routine_id, Dtype(current));
	last->type = type;			/* Store type of accessed attribute */
	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR8: last->it_char = *(current + offset); break;
	case SK_CHAR32: last->it_wchar = *(EIF_CHARACTER_32 *) (current + offset); break;
	case SK_UINT8: last->it_uint8 = *(EIF_NATURAL_8 *) (current + offset); break;
	case SK_UINT16: last->it_uint16 = *(EIF_NATURAL_16 *) (current + offset); break;
	case SK_UINT32: last->it_uint32 = *(EIF_NATURAL_32 *) (current + offset); break;
	case SK_UINT64: last->it_uint64 = *(EIF_NATURAL_64 *) (current + offset); break;
	case SK_INT8: last->it_int8 = *(EIF_INTEGER_8 *) (current + offset); break;
	case SK_INT16: last->it_int16 = *(EIF_INTEGER_16 *) (current + offset); break;
	case SK_INT32: last->it_int32 = *(EIF_INTEGER_32 *) (current + offset); break;
	case SK_INT64: last->it_int64 = *(EIF_INTEGER_64 *) (current + offset); break;
	case SK_REAL32: last->it_real32 = *(EIF_REAL_32 *) (current + offset); break;
	case SK_REAL64: last->it_real64 = *(EIF_REAL_64 *) (current + offset); break;
	case SK_POINTER: last->it_ptr = *(EIF_POINTER *) (current + offset); break;
	case SK_REF: last->it_ref = *(EIF_REFERENCE *) (current + offset); break;
	case SK_EXP: last->it_ref = (current + offset); break;
	default:
		eif_panic(MTC "unknown attribute type");
		/* NOTREACHED */
	}
}

rt_private void assign(long offset, uint32 type)
						/* offset of field in current object
						 * type of object
						 */
{
	/* Assign the value on top of the stack to the attribute described by its
	 * offset. */

	EIF_GET_CONTEXT
	RT_GET_CONTEXT
	EIF_TYPED_VALUE *last;				/* Value on top of the stack */
	EIF_REFERENCE ref;

	last = eif_opstack_pop_address(&op_stack);					/* Value to be assigned */

	CHECK("Target same type as source",
			((last->type & SK_HEAD) == (type & SK_HEAD)));

#define l last
#define i icurrent

	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR8: *(i->it_ref + offset) = l->it_char; break;
	case SK_CHAR32: *(EIF_CHARACTER_32 *) (i->it_ref + offset) = l->it_wchar; break;
	case SK_UINT8: *(EIF_NATURAL_8 *)(i->it_ref + offset) = l->it_uint8; break;
	case SK_UINT16: *(EIF_NATURAL_16 *)(i->it_ref + offset) = l->it_uint16; break;
	case SK_UINT64: *(EIF_NATURAL_64 *)(i->it_ref + offset) = l->it_uint64; break;
	case SK_UINT32: *(EIF_NATURAL_32 *)(i->it_ref + offset) = l->it_uint32; break;
	case SK_INT8: *(EIF_INTEGER_8 *)(i->it_ref + offset) = l->it_int8; break;
	case SK_INT16: *(EIF_INTEGER_16 *)(i->it_ref + offset) = l->it_int16; break;
	case SK_INT64: *(EIF_INTEGER_64 *)(i->it_ref + offset) = l->it_int64; break;
	case SK_INT32: *(EIF_INTEGER_32 *)(i->it_ref + offset) = l->it_int32; break;
	case SK_REAL32: *(EIF_REAL_32 *) (i->it_ref + offset) = l->it_real32; break;
	case SK_REAL64: *(EIF_REAL_64 *) (i->it_ref + offset) = l->it_real64; break;
	case SK_POINTER: *(EIF_POINTER *) (i->it_ref + offset) = l->it_ptr; break;
	case SK_REF:
		/* Perform aging tests: if the reference is new and is assigned to an
		 * old object which is not yet remembered, then we need to put it in
		 * the remembered set. This has to be done before doing the actual
		 * assignment, as RTAR may call eremb() which in turn may call the GC.
		 */
		ref = icurrent->it_ref;
		*(EIF_REFERENCE *) (ref + offset) = last->it_ref;
		RTAR(ref, last->it_ref);
		break;
	default: eif_panic(MTC RT_UNKNOWN_TYPE_MSG);
	}


#undef i
#undef l
}

rt_private void reverse_attribute(long offset, uint32 type)
						/* offset of field in current object
						 * type of object
						 */
{
	/* Assign the value on top of the stack to the attribute described by its
	 * offset. */

	EIF_GET_CONTEXT
	RT_GET_CONTEXT
	EIF_TYPED_VALUE *last;				/* Value on top of the stack */
	EIF_REFERENCE ref;

	last = eif_opstack_pop_address(&op_stack);					/* Value to be assigned */

	if (last->it_ref == (EIF_REFERENCE) 0) {
			/* Source does not conform to target or is Void */
		if ((type & SK_HEAD) == SK_REF)
		{
			*(EIF_REFERENCE *) (icurrent->it_ref + offset) = (EIF_REFERENCE) 0;
		}
	}
	else {

#define l last
#define i icurrent

		switch (type & SK_HEAD) {
		case SK_BOOL:    *(EIF_BOOLEAN    *) (i->it_ref + offset) = * (EIF_BOOLEAN    *) last->it_ref; break;
		case SK_CHAR8:    *(EIF_CHARACTER_8  *) (i->it_ref + offset) = * (EIF_CHARACTER_8  *) last->it_ref; break;
		case SK_CHAR32:   *(EIF_CHARACTER_32  *) (i->it_ref + offset) = * (EIF_CHARACTER_32  *) last->it_ref; break;
		case SK_UINT8:   *(EIF_NATURAL_8  *) (i->it_ref + offset) = * (EIF_NATURAL_8  *) last->it_ref; break;
		case SK_UINT16:  *(EIF_NATURAL_16 *) (i->it_ref + offset) = * (EIF_NATURAL_16 *) last->it_ref; break;
		case SK_UINT32:  *(EIF_NATURAL_32 *) (i->it_ref + offset) = * (EIF_NATURAL_32 *) last->it_ref; break;
		case SK_UINT64:  *(EIF_NATURAL_64 *) (i->it_ref + offset) = * (EIF_NATURAL_64 *) last->it_ref; break;
		case SK_INT8:    *(EIF_INTEGER_8  *) (i->it_ref + offset) = * (EIF_INTEGER_8  *) last->it_ref; break;
		case SK_INT16:   *(EIF_INTEGER_16 *) (i->it_ref + offset) = * (EIF_INTEGER_16 *) last->it_ref; break;
		case SK_INT32:   *(EIF_INTEGER_32 *) (i->it_ref + offset) = * (EIF_INTEGER_32 *) last->it_ref; break;
		case SK_INT64:   *(EIF_INTEGER_64 *) (i->it_ref + offset) = * (EIF_INTEGER_64 *) last->it_ref; break;
		case SK_REAL32:  *(EIF_REAL_32    *) (i->it_ref + offset) = * (EIF_REAL_32    *) last->it_ref; break;
		case SK_REAL64:  *(EIF_REAL_64    *) (i->it_ref + offset) = * (EIF_REAL_64    *) last->it_ref; break;
		case SK_POINTER: *(EIF_POINTER    *) (i->it_ref + offset) = * (EIF_POINTER    *) last->it_ref; break;
		case SK_EXP:
			eif_std_ref_copy (last->it_ref, icurrent->it_ref + offset);
			break;
		case SK_REF:
			/* Perform aging tests: if the reference is new and is assigned to an
			 * old object which is not yet remembered, then we need to put it in
			 * the remembered set. This has to be done before doing the actual
			 * assignment, as RTAR may call eremb() which in turn may call the GC.
			 */
			ref = icurrent->it_ref;
			*(EIF_REFERENCE *) (ref + offset) = last->it_ref;
			RTAR(ref, last->it_ref);
			break;
		default: eif_panic(MTC RT_UNKNOWN_TYPE_MSG);
		}
#undef i
#undef l
	}
}

rt_private void reverse_local(EIF_TYPED_VALUE * it, EIF_TYPE_INDEX type) {
			/* pointer to local to assign to
			 * type of object
			 */
	EIF_GET_CONTEXT
	EIF_TYPED_VALUE *last;				/* Value on top of the stack */

	last = eif_opstack_pop_address(&op_stack);					/* Value to be assigned */
	if (EIF_IS_EXPANDED_TYPE(System(eif_cid_map[type]))) {
		if (last->it_ref != (EIF_REFERENCE) 0) {
			switch (it->type & SK_HEAD) {
			case SK_BOOL: 	 it->it_char   = * (EIF_BOOLEAN    *) last->it_ref; break;
			case SK_CHAR8:	 it->it_char   = * (EIF_CHARACTER_8  *) last->it_ref; break;
			case SK_CHAR32:	 it->it_wchar  = * (EIF_CHARACTER_32  *) last->it_ref; break;
			case SK_UINT8: 	 it->it_uint8  = * (EIF_NATURAL_8  *) last->it_ref; break;
			case SK_UINT16:  it->it_uint16 = * (EIF_NATURAL_16 *) last->it_ref; break;
			case SK_UINT32:  it->it_uint32 = * (EIF_NATURAL_32 *) last->it_ref; break;
			case SK_UINT64:  it->it_uint64 = * (EIF_NATURAL_64 *) last->it_ref; break;
			case SK_INT8: 	 it->it_int8   = * (EIF_INTEGER_8  *) last->it_ref; break;
			case SK_INT16: 	 it->it_int16  = * (EIF_INTEGER_16 *) last->it_ref; break;
			case SK_INT32: 	 it->it_int32  = * (EIF_INTEGER_32 *) last->it_ref; break;
			case SK_INT64: 	 it->it_int64  = * (EIF_INTEGER_64 *) last->it_ref; break;
			case SK_REAL32:  it->it_real32 = * (EIF_REAL_32    *) last->it_ref; break;
			case SK_REAL64:  it->it_real64 = * (EIF_REAL_64    *) last->it_ref; break;
			case SK_POINTER: it->it_ptr    = * (EIF_POINTER    *) last->it_ref; break;
			case SK_EXP:
			case SK_REF:
				eif_std_ref_copy(last->it_ref, it->it_ref);		/* Copy */
				break;
			default:
				eif_panic(MTC RT_UNKNOWN_TYPE_MSG);
			}
		} else {
			/* Do nothing, we keep the previous value. */
		}
	} else {
		it->it_ref = last->it_ref;
	}
}

rt_shared void call_disp(EIF_TYPE_INDEX dtype, EIF_REFERENCE object)
{
	/* Save the interpreter counter and restore it after the dispose
	 * routine for `object' with dynamic type `dtype'.
	 */
	EIF_GET_CONTEXT
	unsigned char *OLD_IC;
	OLD_IC = IC;
	(wdisp (dtype))(object);
	IC = OLD_IC;
}

rt_shared void call_copy (EIF_TYPE_INDEX dtype, EIF_REFERENCE Current, EIF_REFERENCE other)
{
	/* Save the interpreter counter and restore it after the copy
	 * routine for `Current' with dynamic type `dtype' and argument `other'.
	 */
	EIF_GET_CONTEXT
	unsigned char *OLD_IC;
	EIF_TYPED_VALUE o;
	OLD_IC = IC;
	o.type = SK_REF;
	o.it_r = other;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) wcopy (dtype))(Current, o);
	IC = OLD_IC;
}

rt_shared EIF_BOOLEAN call_is_equal (EIF_TYPE_INDEX dtype, EIF_REFERENCE Current, EIF_REFERENCE other)
{
	/* Save the interpreter counter and restore it after the copy
	 * routine for `Current' with dynamic type `dtype' and argument `other'.
	 */
	EIF_GET_CONTEXT
	EIF_BOOLEAN result;
	unsigned char *OLD_IC;
	EIF_TYPED_VALUE o;
	OLD_IC = IC;
	o.type = SK_REF;
	o.it_r = other;
	result = (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE)) wis_equal (dtype))(Current, o).it_b;
	IC = OLD_IC;
	return result;
}
rt_private void address(int32 aid)
						/* Id of the routine in the dispath table */
{
	/* Get the address of a routine identified by 'fid', in the static type
	 * context 'stype', with Current being place on top of the operational
	 * stack. The value of Current is removed and replaced with the address.
	 */

	EIF_GET_CONTEXT
	EIF_TYPED_VALUE *last;				/* Built melted routine address */

	last = eif_opstack_push_empty(&op_stack);
	last->type = SK_POINTER;

	last->it_ptr = (EIF_POINTER) (rt_uint_ptr) RTWPP(aid);
}

rt_shared EIF_REFERENCE rt_melted_arg (int a_pos) {
	RT_GET_CONTEXT
	return arg(a_pos)->it_ref;
}

rt_shared EIF_TYPE rt_get_compound_id (EIF_REFERENCE Current)
	/* Get array of short ints and convert it to a compound id. */
{
	EIF_GET_CONTEXT

	EIF_TYPE_INDEX l_type, gen_types [MAX_CID_SIZE+1];
	int cnt = 0;

	do {
		gen_types [cnt] = l_type = get_int16(&IC);
		cnt++;
		if (cnt > MAX_CID_SIZE) {
			eif_panic(MTC "Too many generic parameters in compound type");
		}
	} while (l_type != TERMINATOR);

		/* If not generic then return dtype */
	if (cnt <= 1) {
		EIF_TYPE result;
			/* Optimization type is in the first entry of `gen_types'. */
		result.id = gen_types[0];
		result.annotations = 0;
		return result;
	} else {
		return eif_compound_id (Dftype (Current), gen_types);
	}
}

rt_shared EIF_TYPE_INDEX get_compound_id(EIF_REFERENCE Current)
	/* Get array of short ints and convert it to a compound id. */
{
	return rt_get_compound_id(Current).id;
}

rt_private EIF_TYPE get_creation_type (void)
{
	RT_GET_CONTEXT
	EIF_TYPE type;
	type = rt_get_compound_id (icurrent->it_ref);
	return type;
}

/*
 * Calling protocol
 */

rt_private void init_var(EIF_TYPED_VALUE *ptr, uint32 type, EIF_REFERENCE current_ref)
{
	/* Initializes variable 'ptr' to be of type 'type' */
	short dtype;

	ptr->type = type;					/* Set to correct type */

	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR8:		ptr->it_char = (EIF_CHARACTER_8) 0; break;
	case SK_CHAR32:		ptr->it_wchar = (EIF_CHARACTER_32) 0; break;
	case SK_UINT8:		ptr->it_uint8 = (EIF_NATURAL_8) 0; break;
	case SK_UINT16:		ptr->it_uint16 = (EIF_NATURAL_16) 0; break;
	case SK_UINT32:		ptr->it_uint32 = (EIF_NATURAL_32) 0; break;
	case SK_UINT64:		ptr->it_uint64 = (EIF_NATURAL_64) 0; break;
	case SK_INT8:		ptr->it_int8 = (EIF_INTEGER_8) 0; break;
	case SK_INT16:		ptr->it_int16 = (EIF_INTEGER_16) 0; break;
	case SK_INT32:		ptr->it_int32 = (EIF_INTEGER_32) 0; break;
	case SK_INT64:		ptr->it_int64 = (EIF_INTEGER_64) 0; break;
	case SK_REAL32:		ptr->it_real32 = (EIF_REAL_32) 0; break;
	case SK_REAL64:		ptr->it_real64 = (EIF_REAL_64) 0; break;
	case SK_EXP:		dtype = get_compound_id(MTC current_ref);
						ptr->type = (type & SK_HEAD) | ((uint32) dtype);
						ptr->it_ref = (EIF_REFERENCE) 0;
						break;
	case SK_REF:		ptr->it_ref = (EIF_REFERENCE) 0; break;
	case SK_POINTER:	ptr->it_ptr = (EIF_POINTER) 0; break;
	case SK_VOID:		break;
	default:			eif_panic(MTC RT_UNKNOWN_TYPE_MSG);
	}
}

rt_private void put_once_result (EIF_TYPED_VALUE *ptr, uint32 rtype, MTOT OResult)
{
	REQUIRE("ptr not null", ptr);
	REQUIRE("OResult not null", OResult);

	switch (rtype & SK_HEAD)
	{
	case SK_BOOL:    MTOP(EIF_BOOLEAN,      OResult, ptr->it_char);   break;
	case SK_CHAR8:   MTOP(EIF_CHARACTER_8,  OResult, ptr->it_char);   break;
	case SK_CHAR32:  MTOP(EIF_CHARACTER_32, OResult, ptr->it_wchar);  break;
	case SK_UINT8:   MTOP(EIF_NATURAL_8,    OResult, ptr->it_uint8);  break;
	case SK_UINT16:  MTOP(EIF_NATURAL_16,   OResult, ptr->it_uint16); break;
	case SK_UINT32:  MTOP(EIF_NATURAL_32,   OResult, ptr->it_uint32); break;
	case SK_UINT64:  MTOP(EIF_NATURAL_64,   OResult, ptr->it_uint64); break;
	case SK_INT8:    MTOP(EIF_INTEGER_8,    OResult, ptr->it_int8);   break;
	case SK_INT16:   MTOP(EIF_INTEGER_16,   OResult, ptr->it_int16);  break;
	case SK_INT32:   MTOP(EIF_INTEGER_32,   OResult, ptr->it_int32);  break;
	case SK_INT64:   MTOP(EIF_INTEGER_64,   OResult, ptr->it_int64);  break;
	case SK_REAL32:  MTOP(EIF_REAL_32,      OResult, ptr->it_real32); break;
	case SK_REAL64:  MTOP(EIF_REAL_64,      OResult, ptr->it_real64); break;
	case SK_POINTER: MTOP(EIF_POINTER,      OResult, ptr->it_ptr);    break;
	case SK_EXP:
	case SK_REF:
		*(OResult->result.EIF_REFERENCE_result) = ptr->it_ref; break;
	}
}

rt_private void get_once_result (MTOT OResult, uint32 rtype, EIF_TYPED_VALUE *ptr)
{
	REQUIRE("OResult not null", OResult);
	REQUIRE("ptr not null", ptr);

	switch (rtype & SK_HEAD)
	{
	case SK_BOOL:
	case SK_CHAR8:   ptr->it_char   = MTOR(EIF_CHARACTER_8,  OResult); break;
	case SK_CHAR32:  ptr->it_wchar  = MTOR(EIF_CHARACTER_32, OResult); break;
	case SK_UINT8:   ptr->it_uint8  = MTOR(EIF_NATURAL_8,    OResult); break;
	case SK_UINT16:  ptr->it_uint16 = MTOR(EIF_NATURAL_16,   OResult); break;
	case SK_UINT32:  ptr->it_uint32 = MTOR(EIF_NATURAL_32,   OResult); break;
	case SK_UINT64:  ptr->it_uint64 = MTOR(EIF_NATURAL_64,   OResult); break;
	case SK_INT8:    ptr->it_int8   = MTOR(EIF_INTEGER_8,    OResult); break;
	case SK_INT16:   ptr->it_int16  = MTOR(EIF_INTEGER_16,   OResult); break;
	case SK_INT32:   ptr->it_int32  = MTOR(EIF_INTEGER_32,   OResult); break;
	case SK_INT64:   ptr->it_int64  = MTOR(EIF_INTEGER_64,   OResult); break;
	case SK_REAL32:  ptr->it_real32 = MTOR(EIF_REAL_32,      OResult); break;
	case SK_REAL64:  ptr->it_real64 = MTOR(EIF_REAL_64,      OResult); break;
	case SK_POINTER: ptr->it_ptr    = MTOR(EIF_POINTER,      OResult); break;
	case SK_EXP:
	case SK_REF:
		ptr->it_ref = *MTOR(EIF_REFERENCE, OResult);
		break;
	case SK_VOID:
		break;
	default:
		eif_panic(MTC "invalid result type");
	}
}

rt_private void init_registers(void)
{
	/* Upon entry in a new feature, given that locnum and argnum are set,
	 * initialize the register array, poping the registers from the stack,
	 * setting all the locals to zero, the value of current, etc...
	 * It's part of the calling protocol to find in the byte code the
	 * informations about the type of each variable. They are retrieved here.
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	uint32 n;				/* # of locals/arguments to be fetched */
	EIF_TYPED_VALUE **reg;	/* Pointer in register array */
	EIF_TYPED_VALUE *last;	/* Initialization of stack frame */
	struct opcursor op_context;		/* To save stack's context */
	EIF_REFERENCE current;					/* Saved value of current */

	allocate_registers(MTC);			/* Make sure array is big enough */

	current = eif_opstack_pop_address(&op_stack)->it_ref;		/* Save value of current */

	/* Upon entry in the routine, all the arguments were pushed in reverse
	 * order, followed by the value of Current. In order to initialize the
	 * interpreter's registers, we need to walk backwards through the stack,
	 * after having saved the stack context.
	 */

	op_context.sc_chunk = op_stack.st_cur;
	op_context.sc_item = op_stack.st_cur->sk_top;

	reg = iregs + SPECIAL_REG + locnum + argnum - 1; /* Start of arguments */
	for (n = 0; n < argnum; n++, reg--) {		/* Pushed in reverse order */
		eif_opstack_back(&op_context);		/* Get its address */
		*reg = op_context.sc_item;
	}

	/* Now loop and fetch the local variables type directly from the byte
	 * code. Put them on the stack and record the address of each of them in
	 * the register's array. All variables are initialized to zero.
	 */

	reg = iregs + SPECIAL_REG;				/* Start of locals */
	for (n = 0; n < locnum; n++, reg++) {	/* Pushed in order */
		last = eif_opstack_push_empty(&op_stack);
		init_var(last, get_uint32(&IC), current);			/* Initialize to zero */
		*reg = last;						/* Save pointer in stack */
	}

	/* Now what do we have on the stack? If we walk backwards, we first have
	 * the locals, in reverse order, then the arguments in order. Push back on
	 * the top the value of current, then initialize a Result (made of type
	 * long so that no traversal is made by the GC--we don't know the feature's
	 * type yet anyway), then the number of locals and arguments.
	 */

	icurrent = last = eif_opstack_push_empty(&op_stack); 		/* Get room for Current */
	last->type = SK_REF;			/* Current is a reference */
	last->it_ref = current;			/* Restore saved value */

	iresult = last = eif_opstack_push_empty(&op_stack);		/* Get room for Result */
	last->type = SK_INT32;			/* By default, avoid GC traversal */

	ilocnum = last= eif_opstack_push_empty(&op_stack);			/* Push # of locals */
	last->type = SK_UINT32;			/* Initializes record */
	last->it_uint32 = locnum;			/* Got this from byte code */

	iargnum = last = eif_opstack_push_empty(&op_stack);		/* Push # of arguments */
	last->type = SK_UINT32;			/* Initializes record */
	last->it_uint32 = argnum;			/* Got this from byte code */
}

rt_private void allocate_registers(void)
{
	/* Automagically increase/decrease the size of the register array. If its
	 * size is too small, then of course we try to extend it. However, it it's
	 * too big (bigger than REGISTER_SIZE) and the number of times it has been
	 * so big (without real need) is greater than BIGGER_LIMIT, then its size
	 * is reduced to REGISTER_SIZE.
	 * Assumes locnum and argnum are already set. Raises a critical out of
	 * memory exception is register array cannot be created.
	 */

	RT_GET_CONTEXT
	static int bigger = 0;			/* Records # of time array is bigger */
	size_t size;				/* Size of iregs array */
	EIF_TYPED_VALUE **new;	/* New location for array extension */

	size = nbregs * ITEM_SZ;				/* The size it should have */
	if (size > iregsz) {					/* The array is not big enough */
		new = (EIF_TYPED_VALUE **) crealloc((char *)iregs, size);
		if (new == (EIF_TYPED_VALUE **) 0)		/* No room for extension */
			enomem(MTC_NOARG);						/* This is a critical exception */
		bigger = 0;
		iregsz = size;
		iregs = new;
	} else if (
		iregsz > (REGISTER_SIZE * ITEM_SZ) &&
		size <= (REGISTER_SIZE * ITEM_SZ)
	) {
		if (++bigger > BIGGER_LIMIT) {	/* Time to reduce length */
			size = (REGISTER_SIZE * ITEM_SZ);
			new = (EIF_TYPED_VALUE **) crealloc((char *)iregs, size);
			if (new == (EIF_TYPED_VALUE **) 0)	/* Paranoid (can't happen?) */
				enomem(MTC_NOARG);				/* This is a critical exception */
			iregsz = size;				/* Array has shrinked */
			bigger = 0;					/* Reset overhead counter */
			iregs = new;
		}
	}
}

rt_shared void sync_registers(struct stopchunk *stack_cur, EIF_TYPED_VALUE *stack_top)
						   		/* Saved current chunk of op stack */
					   			/* Saved top of op stack */
{
	/* Whenever an interpreted function is called, the register array is
	 * reset to match registers for the new function. When we regain control
	 * in the original function, we have to re-synchronize the array.
	 * This is rather a slow routine, because it makes lots ot EIF_STACK_TOP_ADDRESS(op_stack) and
	 * eif_opstack_pop_address(&op_stack) calls--RAM.
	 */

	RT_GET_CONTEXT
	uint32 n;				/* Loop index */
	EIF_TYPED_VALUE **reg;	/* Address in register's array */
	struct opcursor op_context;		/* To save stack's context */

	op_context.sc_chunk = stack_cur;
	op_context.sc_item = stack_top;

	/* The stack is now in the state it had right after the initial settings.
	 * Start by filling in the special registers (appear in reverse order).
	 */
	for (n = 0, reg = iregs + SPECIAL_REG - 1; n < SPECIAL_REG; n++, reg--) {
		eif_opstack_back (&op_context);
		*reg = op_context.sc_item;
	}

	locnum = ilocnum->it_uint32;		/* # of local variables */
	argnum = iargnum->it_uint32;		/* # of arguments */
	allocate_registers(MTC);		/* `iregs' could have been reduced */

	/* Local variables also appear in reverse order */
	for (n = 0, reg = iregs+locnum+SPECIAL_REG-1; n < locnum; n++, reg--) {
		eif_opstack_back (&op_context);
		*reg = op_context.sc_item;
	}

	/* Finally, arguments appear in reverse order */
	for (n = 0, reg = iregs+locnum+SPECIAL_REG+argnum-1; n < argnum; n++, reg--) {
		eif_opstack_back (&op_context);
		*reg = op_context.sc_item;
	}

	/* Finally, we must not forget the debugging hooks. Running this routine
	 * certainly means we have called another interpreted feature and the
	 * debugging cached information have been disturbed.
	 */

	dsync();						/* Resynchronize cached status */
}

rt_private void pop_registers(void)
{
	/* This is the reverse operation of init_registers(). We remove all the
	 * registers from the stack because the Eiffel function is now returning.
	 * We need to analyze the top of the stack to know exactely how much we
	 * have to pop.
	 * Note that there is no need to bother with local variables for the
	 * garbage collector, as the GC automatically inspects the operational
	 * stack (hence there is no need to call RTLI and RTLE macros).
	 * It we were in a function, the Result value is pushed back on the stack.
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	rt_uint_ptr nb_locals, nb_args, n;			/* Number of registers to be popped off */

		/* Pop the special registers */
	nb_args = eif_opstack_pop_address(&op_stack)->it_uint32;		/* This is the nummber of arguments */
	nb_locals = eif_opstack_pop_address(&op_stack)->it_uint32;	/* Add the number of locals */
		/* We have pushed args, locals, result and Current. */
	n = nb_args + nb_locals + 2;

	eif_opstack_npop(&op_stack, n);	/* Remove items and eventually shrink stack */

	if (iresult->type != SK_VOID) {	/* If Result is needed */
		memcpy (eif_opstack_push_empty(&op_stack), iresult, ITEM_SZ);
	}
}


/* Initialize expanded locals */
rt_private void create_expanded_locals (
	struct stopchunk * scur,		/* Current chunk (stack context) */
	EIF_TYPED_VALUE * stop			/* To save stack context */
)
{
	RT_GET_CONTEXT
	uint32 i;
	EIF_TYPED_VALUE * last;	/* Last pushed value */
	uint32 type;
	unsigned long stagval;

		/* After expanded local entities creation, registers may have
		 * to be resynchronized because RTLN could call the interpreter
		 * through creation procedure of expanded attributes.
		 */
	for (i = 1; i <= locnum; i++) {
		last = loc(i);
		type = last->type;
		switch (type & SK_HEAD) {
		case SK_EXP:
			stagval = tagval;
			last->type = SK_POINTER;	/* GC: wait for malloc */
			last->it_ref = RTLX((EIF_TYPE_INDEX) (type & SK_DTYPE));
			last->type = SK_EXP;
			if (tagval != stagval)
				sync_registers(MTC scur, stop);
			break;
		}
	}
}

/* Initialize expanded result (if required) */
rt_private void create_expanded_result (
	struct stopchunk * scur,		/* Current chunk (stack context) */
	EIF_TYPED_VALUE * stop			/* To save stack context */
)
{
	RT_GET_CONTEXT
	EIF_TYPED_VALUE * last;	/* Last pushed value */
	uint32 type;
	unsigned long stagval;

		/* After expanded local entities creation, registers may have
		 * to be resynchronized because RTLN could call the interpreter
		 * through creation procedure of expanded attributes.
		 */
	last = iresult;
	type = last->type;
	switch (type & SK_HEAD) {
	case SK_EXP:
		stagval = tagval;
		last->type = SK_POINTER;		/* For GC */
		last->it_ref = RTLX((EIF_TYPE_INDEX) (type & SK_DTYPE));
		last->type = SK_EXP;
		if (tagval != stagval)
			sync_registers(MTC scur, stop);
		break;
	}
}


/*
 * For debugger: getting values of locals, arguments, Result and Current.
 */

/* VARARGS1 */
rt_public void ivalue(EIF_DEBUG_VALUE * value, int code, uint32 num, uint32 start)
		 		/* Request code */
				/* Additional info for local and arguments */
				/* start of operational stack (for frozen feature only - used by cresult, carg.. macros) */
	{
	/* Extract information from the interpreter's registers. For local and
	 * arguments, a range checking is performmed and a null pointer returned
	 * if the information requested is invalid (e.g. when asking for local #4
	 * when there are only 2 of them). Requests for locals and arguments follow
	 * the usual C convention, i.e. start at 0.
	 * To avoid endless tests, there is a convention: if the routine has n
	 * locals, then n+1 is the result of the routine, if it exists.
	 */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT

	struct ex_vect 	*exvect = eif_stack.st_top; /* get the execution vector */
	EIF_TYPED_ADDRESS * result_item = NULL;

	if (egc_frozen[exvect->ex_bodyid] == NULL) {
		/* if the feature is melted or super melted,
		 * we look in the registers of the interpreter
		 */
		switch (code) {
		case IV_LOCAL:								/* Nth local */
			if (num > ilocnum->it_uint32) {
				value -> value.type = SK_VOID;
				value -> value.it_ptr = NULL;
				value -> address = NULL;
				return;
			}
			else if (num == ilocnum->it_uint32){		/* Off by one */
				if (iresult->type != SK_VOID) {		/* If there is a result */
					value -> value = * iresult; /* Then return it */
					value -> address = & (iresult -> item);
					return;
				} else {
					value -> value.type = SK_VOID; /* Else signal out of range */
					value -> value.it_ptr = NULL;
					value -> address = NULL;
					return;
				}
			}
			value -> value = * loc(num + 1); /* Locals from 1 to ilocnum */
			value -> address = & (loc(num + 1)->item);
			return;

		case IV_ARG:								/* Nth argument */
			if (num >= iargnum->it_uint32) {
				value -> value.type = SK_VOID; /* Out of range */
				value -> value.it_ptr = NULL;
				value -> address = NULL;
				return;
			}
			value -> value = * arg(num + 1);		/* Arguments from 1 to iargnum */
			value -> address = & (arg(num + 1) -> item);
			return;

		case IV_CURRENT:							/* Current */
			value -> value = * icurrent;
			value -> address = & (icurrent -> item);
			return;

		case IV_RESULT:								/* Result */
			value -> value = * iresult;
			value -> address = & (iresult -> item);
			return;

		default:
			eif_panic(MTC "illegal value request");
		}
	} else {
		/* if the feature is frozen, we look in the c_opstack
		 * unlike with melted feature, here we retrieve the address
		 * of the value of the result/arg/local. So we have to transform
		 * the c_item into an item --Arnaud
		 */
		switch (code) {
		case IV_LOCAL:									/* Nth local */
			if (num > clocnum) {
				break; 									/* Out of range */
			}
			else if (num == clocnum) {					/* Off by one */
				result_item = cresult;
				CHECK("result_item not null", result_item);
				if (result_item->type == SK_VOID) {	/* If there is no result */
					result_item = NULL;				/* Then discard it */
				}
				break;								/* Else signal out of range */
			}
			result_item = cloc(num + 1);				/* Locals from 1 to ilocnum */
			break;

		case IV_ARG:									/* Nth argument */
			if (num >= cargnum) {
				break; 									/* Out of range */
			}
			result_item = carg(num + 1);				/* Arguments from 1 to iargnum */
			break;

		case IV_CURRENT:								/* Current */
			result_item = ccurrent;
			break;

		case IV_RESULT:									/* Result */
			result_item = cresult;
			break;

		default:
			eif_panic("illegal value request");
			/* NOT REACHED */
			break;
		}

		/* transform the 'c_item' into an regular item (like the one used with melted features) */
		if (result_item == (EIF_TYPED_ADDRESS *)0) {
			value -> value.type = SK_VOID;
			value -> value.it_ptr = NULL;
			value -> address = NULL;
		} else {
			value -> value.type = result_item -> type;
			value -> address = result_item -> it_addr;
			switch (value -> value.type & SK_HEAD) {
			case SK_BOOL:
			case SK_CHAR8: value->value.it_char = *((EIF_CHARACTER_8 *)(value -> address)); break;
			case SK_CHAR32: value->value.it_wchar = *((EIF_CHARACTER_32 *)(value -> address)); break;
			case SK_UINT8: value->value.it_uint8 = *((EIF_NATURAL_8 *)(value -> address)); break;
			case SK_UINT16: value->value.it_uint16 = *((EIF_NATURAL_16 *)(value -> address)); break;
			case SK_UINT32: value->value.it_uint32 = *((EIF_NATURAL_32 *)(value -> address)); break;
			case SK_UINT64: value->value.it_uint64 = *((EIF_NATURAL_64 *)(value -> address)); break;
			case SK_INT8: value->value.it_int8 = *((EIF_INTEGER_8 *)(value -> address)); break;
			case SK_INT16: value->value.it_int16 = *((EIF_INTEGER_16 *)(value -> address)); break;
			case SK_INT32: value->value.it_int32 = *((EIF_INTEGER_32 *)(value -> address)); break;
			case SK_INT64: value->value.it_int64 = *((EIF_INTEGER_64 *)(value -> address)); break;
			case SK_REAL32: value->value.it_real32 = *((EIF_REAL_32 *)(value -> address)); break;
			case SK_REAL64: value->value.it_real64 = *((EIF_REAL_64 *)(value -> address)); break;
			case SK_POINTER: value->value.it_ptr = *((EIF_POINTER *)(value -> address)); break;
			case SK_EXP:
			case SK_REF:
				value->value.it_ref = *((EIF_REFERENCE *)(value -> address)); break;
			case SK_VOID:
				/* nothing to do*/
				break;
			}
		}
	}

	/*
	fprintf(stderr,"ivalue (value, code=0x%X, num=%d, start=0x%X) locnum=%d -> ip: type:0x%X address:0x%X\n",code, num, start, clocnum, value->value.type, value->address);
	*/
	return;

	/* NOT REACHED */
}

/*
doc:	<routine name="eif_override_byte_code_of_body" export="public">
doc:		<summary>Melt the code of routine `body_id' using the byte code `bc' of size `count'.</summary>
doc:		<param name="body_id" type="int">Body ID identifying the routine we want to melt.</param>
doc:		<param name="pattern_id" type="int">Pattern ID associated to `body_id'.</param>
doc:		<param name="bc" type="unsigned char *">Byte code for routine `body_id'.</param>
doc:		<param name="count" type="int">Size of the `bc' content.</param>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>Caller should ensure that only one thread executes this code as it might perform resizing of `melt' and `mpatidtab' arrays.</synchronization>
doc:	</routine>
*/

rt_public void eif_override_byte_code_of_body (int body_id, int pattern_id, unsigned char *bc, int count)
{
	unsigned char *bcode;
	rt_uint_ptr old_count, l_body_id;

	REQUIRE("valid body_id", body_id >= 0);
	REQUIRE("valid pattern_id", pattern_id >= 0);
	REQUIRE ("valid byte_code", bc);
	REQUIRE ("valid byte_code count", count >= 0);

		/* Changed type to conform to the type of `melt_count'. It is safe per precondition. */
	l_body_id = (rt_uint_ptr) body_id;

		/* First allocate the `melt' and `mpatidtab' arrays if not yet created. And if created
		 * but too small for `l_body_id' we resize them. */
	if (!melt) {
		melt_count = l_body_id + 1;
		melt = (unsigned char **) cmalloc (melt_count* sizeof(unsigned char *));
		if (!melt) {
			enomem();
		} else {
			mpatidtab = (int *) cmalloc (melt_count * sizeof(int));
			if (!mpatidtab) {
				enomem();
			} else {
				memset (melt, 0, melt_count * sizeof(unsigned char *));
				memset (mpatidtab, 0, melt_count * sizeof(int));
			}
		}
	} else if (melt_count <= l_body_id) {
		old_count = melt_count;
		melt_count = l_body_id + 1;
		melt = (unsigned char **) crealloc (melt, melt_count * sizeof(unsigned char *));
		if (!melt) {
			enomem();
		} else {
			mpatidtab = (int *) crealloc (mpatidtab, melt_count * sizeof(int));
			if (!mpatidtab) {
				enomem();
			} else {
				memset (melt + old_count, 0, (melt_count - old_count) * sizeof(unsigned char *));
				memset (mpatidtab + old_count, 0, (melt_count - old_count) * sizeof(int));
			}
		}
	}
	CHECK("melt allocated", melt);
	CHECK("mpatidtab allocated", mpatidtab);
	CHECK("valid melt array count", melt_count > l_body_id);

	bcode = melt [l_body_id];
	if (bcode != NULL) {
			/* Let's free the previously allocated byte code. */
		eif_rt_xfree (bcode);
	}
		/* Allocate a new area for the new byte code to store. */
	bcode = (unsigned char *) cmalloc (count * sizeof(unsigned char));
	if (!bcode) {
		enomem();
	} else {
		memcpy (bcode, bc, count * sizeof(unsigned char));
		melt [l_body_id] = bcode;
		mpatidtab [l_body_id] = pattern_id;
		egc_frozen [l_body_id] = 0;
	}
}

#endif

/*
doc:</file>
*/
