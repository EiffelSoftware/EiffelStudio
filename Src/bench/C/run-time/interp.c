/*
	description: "The byte code interpreter."
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

/*
doc:<file name="interp.c" header="eif_interp.h" version="$Id$" summary="Byte code interpreter for Eiffel byte code.">
*/

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
#include "rt_bits.h"
#include "eif_equal.h"	/* for xequal() */
#include <math.h>
#include "eif_main.h"
#include "rt_gen_conf.h"
#include "rt_gen_types.h"
#include "x2c.h"		/* For LNGPAD */
#include "eif_misc.h"
#include "rt_assert.h"
#include "rt_wbench.h"
#include "rt_garcol.h"
#include "rt_struct.h"
#include "rt_main.h" /* For debug_mode: we need to move dynamic_eval */
#include "eif_helpers.h"

#ifdef CONCURRENT_EIFFEL
#include "eif_curextern.h"
#endif

/*#define SEP_DEBUG */  /**/
/*#define DEBUG 6 */ 	/**/
/*#define TEST */ /**/
#ifdef TEST
#include <stdio.h>
#endif

#define dprintf(n) if (DEBUG & n) printf

#define ASSERT_MAX		10			/* Automatically generated assert tags */
#define ASSERT_LENGTH	12			/* Length of "Number 9999" */
#define REGISTER_SIZE	40			/* Reasonable size of register array */
#define BIGGER_LIMIT	150			/* Number of calls before reducing size */
#define SPECIAL_REG		4			/* Number or special registers */
#define ITEM_SZ			sizeof(struct item)

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
	(struct stochunk *) 0,		/* st_hd */
	(struct stochunk *) 0,		/* st_tl */
	(struct stochunk *) 0,		/* st_cur */
	(struct item *) 0,			/* st_top */
	(struct item *) 0,			/* st_end */
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
doc:	<attribute name="iregs" return_type="struct item **" export="private">
doc:		<summary>Interpreter registers. To speed-up access of the local parameters and variables, they are all gathered in a separate array (automagically resized). The value of Current comes first, then Result (whether it is needed or not), then all the arguments (number held in global argnum) and then the locals (number held in global locnum). They can be viewed as the interpreter's registers and are saved/backed upon each call. The 'argnum' and 'locnum' are also part of the interpreter's registers, but for faster access, they are copied to C global vars--RAM. Size of this structure is store in `iregsz'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
doc:	<attribute name="iregsz" return_type="int" export="private">
doc:		<summary>Size of `iregs' array (bytes)</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
doc:	<attribute name="argnum" return_type="int" export="private">
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
rt_private struct item **iregs = NULL;
rt_private int iregsz = 0;	/* Size of 'iregs' array (bytes) */
rt_private uint32 argnum = 0;		/* Number of arguments */
rt_private uint32 locnum = 0;		/* Number of locals */

/*
doc:	<attribute name="tagval" return_type="unsigned long" export="private">
doc:		<summary>Records number of interpreter's call. To optimize registers resync, we keep track of a tag value which is updated each time we enter in an interpreted routine. This gives us the ability to know if other interpreted routines where called since we left a given routine due to a function call. If none have been called, then the registers have no reason to have changed.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
doc:	<attribute name="saved_scur" return_type="struct stochunk *" export="private">
doc:		<summary>Current feature context. Used in conjonction for registers synchronization.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
doc:	<attribute name="saved_stop" return_type="struct item *" export="private">
doc:		<summary>Current feature context. Used in conjonction for registers synchronization.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private unsigned long tagval = 0L;
rt_private struct stochunk *saved_scur = NULL;
rt_private struct item *saved_stop = NULL;

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
rt_private void eif_interp_gt(struct item *first, struct item *second);	/* > operation */
rt_private void eif_interp_lt(struct item *first, struct item *second);	/* < operation */
rt_private void eif_interp_eq (struct item *f, struct item *s);			/* == operation */

/* Min and max operation */
rt_private void eif_three_way_comparison (void);	/* Execute `three_way_comparison'. */
rt_private void eif_interp_min_max (int code);	/* Execute `min' or `max' depending
														   on value of `type' */
rt_private void eif_interp_generator (void);	/* generate the name of the basic type */
rt_private void eif_interp_offset (void);	/* execute `offset' on character and pointer type */
rt_private void eif_interp_bit_operations (void);	/* execute bit operations on integers */
rt_private void eif_interp_basic_operations (void);	/* execute basic operations on basic types */

/* Assertion checking */
rt_private void icheck_inv(EIF_REFERENCE obj, struct stochunk *scur, struct item *stop, int where);				/* Invariant check */
rt_private void irecursive_chkinv(int dtype, EIF_REFERENCE obj, struct stochunk *scur, struct item *stop, int where);		/* Recursive invariant check */

/* Getting constants */
rt_private short get_compound_id(EIF_REFERENCE obj, short dtype);			/* Get a compound type id */
rt_private int get_creation_type(void);		/* Get a creation type id */

/* Interpreter interface */
rt_public void exp_call(void);				/* Sets IC before calling interpret */ /* %%ss undefine */
rt_public void xinterp(unsigned char *icval);	/* Sets IC before calling interpret */
rt_public void xinitint(void);			/* Initialization of the interpreter */
rt_private void interpret(int flag, int where);	/* Run the interpreter */

/* Feature call and/or access  */
rt_public struct item *dynamic_eval(int fid, int stype, int is_precompiled, int is_basic_type, struct item* previous_otop);
rt_private int icall(int fid, int stype, int ptype);					/* Interpreter dispatcher (in water) */
rt_private int ipcall(int32 origin, int32 offset, int ptype);					/* Interpreter precomp dispatcher */
rt_private void interp_access(int fid, int stype, uint32 type);			/* Access to an attribute */
rt_private void interp_paccess(int32 origin, int32 f_offset, uint32 type);			/* Access to a precompiled attribute */
rt_private void address(int32 fid, int stype, int for_rout_obj);					/* Address of a routine */
rt_private void assign(long offset, uint32 type);									/* Assignment in an attribute */

/* Calling protocol */
rt_private void put_once_result (struct item * ptr, long int rtype, MTOT OResult); /* Save local result to permanent once storage */
rt_private void get_once_result (MTOT OResult, long int rtype, struct item *ptr);   /* Retrieve local result from permanent once storage */
rt_private void init_var(struct item *ptr, long int type, EIF_REFERENCE current_ref); /* Initialize to 0 a variable entity */
rt_private void init_registers(void);			/* Intialize registers in callee */
rt_private void allocate_registers(void);		/* Allocate the register array */
rt_shared void sync_registers(struct stochunk *stack_cur, struct item *stack_top); /* Resynchronize the register array */
rt_private void pop_registers(void);						/* Remove local vars and arguments */
rt_private void create_expanded_locals (struct stochunk * scur, struct item * stop); /* Initialize expanded locals and result (if required) */

/* Operational stack handling routines */
rt_public struct item *opush(register struct item *val);	/* Push one value on op stack */
rt_public struct item *opop(void);							/* Pop last item */
rt_private struct item *stack_allocate(register int size);	/* Allocates first chunk */
rt_private int stack_extend(register int size);				/* Extend stack's size */
rt_private void npop(register int nb_items);				/* Pop 'n' items */
rt_public struct item *otop(void);							/* Pointer to value at the top */
rt_private struct item *oitem(uint32 n);					/* Pointer to value at position `n' down the stack */
rt_private void stack_truncate(void);						/* Truncate stack if necessary */
rt_private void wipe_out(register struct stochunk *chunk);	/* Remove unneeded chunk from stack */
#ifdef DEBUG
rt_private void dump_stack(void);							/* Dumps the operational stack */
rt_public void idump(FILE *, char *);						/* Byte code dumping */
rt_private void iinternal_dump(FILE *, char *);				/* Internal (compound) dumping */
#endif

/* debug functions */
extern void discard_breakpoints(void);	/* discard all breakpoints. used when we don't want to stop */ 
extern void undiscard_breakpoints(void);	/* un-discard all breakpoints. */

/* Those macros are used to save and restore the ``x'' stack context to/from 
 * ``y'' and ``z'', which are respectively the current chunk and the current
 * top pointer on the stack. The STACK_PRESERVE declares the variables ``dcur''
 * and ``dtop'' for the debbuger stack and ``scur'' / ``stop'' for the
 * interpreter operational stack.
 * There is always a wrapper to the function interpret() (which is private), and
 * that wrapper is responsible for getting calling context, setting an exception
 * trap (to clean up the stacks when an exception occurs) and removing all that
 * extra information when interpret() returns successfully.
 */
#define STACK_PRESERVE \
	struct dcall * volatile dtop;				\
	struct stdchunk * volatile dcur;			\
	struct item * volatile stop;				\
	struct stochunk * volatile scur

#define SAVE(x,y,z) \
	{								\
		(y) = (x).st_cur;			\
		(z) = (x).st_top;			\
	}
#define RESTORE(x,y,z) \
	{								\
		(x).st_cur = (y);			\
		(x).st_end = (y)->sk_end;	\
		(x).st_top = (z);			\
	}

/* Macros to handle exceptions in routine body:
 * SET_RESCUE - set rescue handler (if any)
 */

#define SET_RESCUE                                                            \
	if (rescue) {                                                         \
			/* Set exception handler address. */                  \
		if (!setjmp(exenv)) {                                         \
				/* Register address to rescue on exception.*/ \
			exvect->ex_jbuf = &exenv;                             \
		}                                                             \
		else {                                                        \
				/* There is an exception. */                  \
				/* Jump to rescue clause. */                  \
			IC = rescue;                                          \
		}                                                             \
	}

rt_public void metamorphose_top()
{
	RT_GET_CONTEXT

	EIF_REFERENCE new_obj = NULL;
	uint32 head_type;
	struct item * last;	/* Last pushed value */
	unsigned long stagval;
	struct item * stop;				
	struct stochunk * scur;
	
	SAVE(op_stack, scur, stop);	/* Save operation stack */
	last = opop();
	stagval = tagval;
	head_type = last->type & SK_HEAD;
	if (head_type != SK_BIT) {
		switch (head_type) {
		case SK_BOOL: new_obj = RTLN(egc_bool_ref_dtype); *new_obj = last->it_char; break;
		case SK_CHAR:	new_obj = RTLN(egc_char_ref_dtype); *new_obj = last->it_char; break;
		case SK_WCHAR:	new_obj = RTLN(egc_wchar_ref_dtype); *(EIF_WIDE_CHAR *) new_obj = last->it_wchar; break;
		case SK_UINT8: new_obj = RTLN(egc_uint8_ref_dtype); *(EIF_NATURAL_8 *) new_obj = last->it_uint8; break;
		case SK_UINT16: new_obj = RTLN(egc_uint16_ref_dtype); *(EIF_NATURAL_16 *) new_obj = last->it_uint16; break;
		case SK_UINT32: new_obj = RTLN(egc_uint32_ref_dtype); *(EIF_NATURAL_32 *) new_obj = last->it_uint32; break;
		case SK_UINT64: new_obj = RTLN(egc_uint64_ref_dtype); *(EIF_NATURAL_64 *) new_obj = last->it_uint64; break;
		case SK_INT8: new_obj = RTLN(egc_int8_ref_dtype); *(EIF_INTEGER_8 *) new_obj = last->it_int8; break;
		case SK_INT16: new_obj = RTLN(egc_int16_ref_dtype); *(EIF_INTEGER_16 *) new_obj = last->it_int16; break;
		case SK_INT32: new_obj = RTLN(egc_int32_ref_dtype); *(EIF_INTEGER_32 *) new_obj = last->it_int32; break;
		case SK_INT64: new_obj = RTLN(egc_int64_ref_dtype); *(EIF_INTEGER_64 *) new_obj = last->it_int64; break;
		case SK_REAL32: new_obj = RTLN(egc_real32_ref_dtype); *(EIF_REAL_32 *) new_obj = last->it_real32; break;
		case SK_REAL64: new_obj = RTLN(egc_real64_ref_dtype); *(EIF_REAL_64 *) new_obj = last->it_real64; break;
		case SK_POINTER: new_obj = RTLN(egc_point_ref_dtype); *(EIF_REFERENCE *) new_obj = last->it_ptr; break;
		case SK_REF:			/* Had to do this for bit operations */
			new_obj = last->it_ref;
			break;
		default: 
			eif_panic(MTC "illegal metamorphose type");
		}
		last = iget();
		last->type = SK_REF;
		last->it_ref = new_obj;
	} else {
		/* Bit metamorphose is a clone */
		new_obj = b_clone(last->it_bit);
		last = iget();
		last->type = SK_REF;
		last->it_ref = new_obj;
	}
	if (tagval != stagval)				/* If G.C calls melted dispose */
		sync_registers(MTC scur, stop);
}

rt_public void xinterp(unsigned char *icval)
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
	RTXD;					/* Store stack contexts */

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
		dpop();							/* Pop off our own record */
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
	expop(&eif_stack);					/* Pop pseudo vector */
	dpop();								/* Remove calling context */
}

rt_public void xiinv(unsigned char *icval, int where)
			
				/* Invariant checked after or before ? */
{
	/* Starts interpretation of invariant at IC = icval. */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	jmp_buf exenv;			/* C code call to interpreter exec. vector */
	RTXD;					/* Save stack contexts */
	STACK_PRESERVE;			/* Stack contextual informations */

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
		dpop();							/* Remove calling context */
		ereturn(MTC_NOARG);						/* Propagate exception */
	}

	(void) interpret(MTC INTERP_INVA, where);
	expop(&eif_stack);					/* Pop pseudo vector */
	dpop();								/* Remove calling context */
}

rt_public void xinitint(void)
{
	/* Creation of the register array. */
	RT_GET_CONTEXT

	iregsz = REGISTER_SIZE * sizeof(struct item *);
	iregs = (struct item **) cmalloc(iregsz);
	if (iregs == (struct item **) 0)	/* Not enough room */
		enomem(MTC_NOARG);
}

#undef EIF_VOLATILE
#define EIF_VOLATILE volatile
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
	struct item * volatile last;	/* Last pushed value */
	long volatile offset;			/* Offset for jumps and al */
	unsigned char * volatile string;		/* Strings for assertions tag */
	int volatile type;						/* Often used to hold type values */
	int volatile saved_assertion;
	unsigned char * volatile rescue;		/* Location of rescue clause */
	jmp_buf exenv;							/* In case we have to setjmp() */
	RTEX;									/* Routine's execution vector and debugger
											   level depth */
	struct item * volatile stop;			/* To save stack context */
	struct stochunk * volatile scur;		/* Current chunk (stack context) */
#ifdef ISE_GC
	char ** volatile l_top;					/* Local top */
	struct stchunk * volatile l_cur;		/* Current local chunk */
	char ** volatile ls_top;				/* loc_stack top */
	struct stchunk * volatile ls_cur;		/* Current loc_stack chunk */
	char ** volatile h_top;					/* Hector stack top */
	struct stchunk * volatile h_cur;		/* Current hector stack chunk */
#endif
	int volatile assert_type;				/* Assertion type */
	char volatile pre_success;				/* Flag for precondition success */ 
	long volatile rtype;					/* Result type */
	MTOT OResult = (MTOT) 0;				/* Item for once data */
#ifdef EIF_THREADS
	EIF_process_once_value_t * POResult = NULL;	/* Process-relative once data */
#endif
	int32 volatile rout_id;					/* Routine id */
	BODY_INDEX volatile body_id = 0;		/* Body id of routine */
	int volatile current_trace_level;		/* Saved call level for trace, only needed when routine is retried */
	char ** volatile saved_prof_top;		/* Saved top of `prof_stack' */
	long volatile once_key;			/* Index in once table */
	int  volatile is_once;			/* Is it a once routine? */
	int  volatile is_process_once;		/* Is once routine process-relative? */
	RTSN;							/* Save nested flag */
 
#ifdef CONCURRENT_EIFFEL
	/* the following variable is used by Concurrent Eiffel */
	char has_called_sep_feature =0;	/* Has the current feature called separate
									* feature in its pre-condition?
									*/
	char has_reserved_new_born_sep = 0;	/* Is the new created separate object
										 * created with a creation procedure?
										*/
#ifdef SEP_DEBUG
	EIF_TYPE_ID sep_obj_id;			/* The data type id of the special class
									* for separate object proxy.
									*/
	sep_obj_id = _concur_sep_obj_dtype;
#endif
#endif

	saved_assertion = in_assertion;
	is_once = 0;

	switch (*IC++)
	{
	case ONCE_MARK_THREAD_RELATIVE:
		is_once  = 1;
		is_process_once = 0;
		once_key = get_int32(&IC);
		break;
#ifdef EIF_THREADS
	case ONCE_MARK_PROCESS_RELATIVE:
		is_once  = 1;
		is_process_once = 1;
		once_key = get_int32(&IC);
		break;
#endif
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
		rout_id = (int32) get_int32(&IC);	/* Get the routine id */
		body_id = (BODY_INDEX) get_int32(&IC);	/* Get the body id */
		rtype = get_int32(&IC);				/* Get the result type */
		argnum = get_int16(&IC);			/* Get the argument number */
		locnum = get_int16(&IC);		/* Get the local number */
		init_registers(MTC);		/* Initialize the registers */

		/* Expanded clone of arguments (if any) */
		while (*IC++ != BC_NO_CLONE_ARG) {
			EIF_REFERENCE ref;

			code = get_int16(&IC);		/* Get the argument number to clone */
			last = arg(code);
			ref = last->it_ref;
			if (ref == NULL)
				xraise(EN_VEXP);	/* Void assigned to expanded */
			switch (last->type & SK_HEAD) {
			case SK_REF:			/* Lovely comment */
			case SK_EXP:
				RT_GC_PROTECT(ref);
				type = get_int16(&IC);
				type = get_compound_id(MTC icurrent->it_ref, (short) type);
				last->it_ref = RTLN(type);
				RT_GC_WEAN(ref);
				last->type = SK_EXP;
				eif_std_ref_copy(ref, last->it_ref);
				break;
			case SK_BIT:
				RT_GC_PROTECT(ref);
				last->it_bit = RTLB(get_int32(&IC));
				RT_GC_WEAN(ref);
				b_copy(ref, last->it_bit);
				break;
			}
		}

		init_var(iresult, rtype, icurrent->it_ref);
		if (is_once) {				/* If it is a once */

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
			code = get_int16(&IC);		/* Dynamic type where feature is written */

			/* Get an execution vector for the current feature, and link it
			 * with the current debugging calling context. It is important to
			 * have those pointers from the calling context into the Eiffel
			 * stack when dumping the execution stack (because we are able to
			 * compute the relative position of the features recorded in that
			 * calling context wrt the global execution flow in the Eiffel
			 * stack).
			 */
			RTEAA((char *) string, code, (icurrent->it_ref), (unsigned char)locnum, (unsigned char)argnum, body_id);
			check_options(MTC eoption + icur_dtype, icur_dtype);
			dexset(exvect);
			scur = op_stack.st_cur;		/* Save stack context */
			stop = op_stack.st_top;		/* needed for setjmp() and calls */
			dostk();					/* Record position in calling context */
			if (is_nested)
				icheck_inv(MTC icurrent->it_ref, scur, stop, 0);	/* Invariant */

#ifdef DEBUG
			dprintf(1)("\tFeature %s written in %s on 0x%lx [%s]\n",
				string, System(code).cn_generator,
				icurrent->it_ref, System(Dtype(icurrent->it_ref)).cn_generator);
#endif
			break;

		case INTERP_INVA:			/* An invariant */
#ifdef DEBUG
		dprintf(1)("\tInvariant on 0x%lx [%s]\n",
			icurrent->it_ref, System(Dtype(icurrent->it_ref)).cn_generator);
#endif
			scur = op_stack.st_cur;		/* Save stack context */
			stop = op_stack.st_top;		/* needed for setjmp() and calls */
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
				l_top = loc_set.st_top;		/* Save C local stack */
				l_cur = loc_set.st_cur;
				ls_top = loc_stack.st_top;	/* Save loc_stack */
				ls_cur = loc_stack.st_cur;
				h_top = hec_stack.st_top;	/* Save hector stack */
				h_cur = hec_stack.st_cur;
#endif
				current_trace_level = trace_call_level;	/* Save trace call level */
				if (prof_stack) saved_prof_top = prof_stack->st_top;
			}

		}
		if (*IC != BC_PRECOND) {
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

	/*
	 * Rescue clause beginning
	 */
	case BC_RESCUE:
#ifdef DEBUG
		dprintf(2)("BC_RESCUE\n");
#endif
		op_stack.st_cur = scur;					/* Restore stack context */
		op_stack.st_top = stop;
		if (scur) op_stack.st_end = scur->sk_end;
#ifdef ISE_GC
		loc_set.st_cur = l_cur;
		if (l_cur) loc_set.st_end = l_cur->sk_end;
		loc_set.st_top = l_top;
		loc_stack.st_cur = ls_cur;
		if (ls_cur) loc_stack.st_end = ls_cur->sk_end;
		loc_stack.st_top = ls_top;
		hec_stack.st_cur = h_cur;
		if (h_cur) hec_stack.st_end = h_cur->sk_end;
		hec_stack.st_top = h_top;
#endif
		sync_registers(MTC scur, stop);
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
		if (prof_stack) prof_stack_rewind(saved_prof_top);
		in_assertion = saved_assertion;		/* restore saved assertion checking because
											 * we might have reached this code from
											 * an assertion checking code. */
		offset = get_int32(&IC);				/* Get the retry offset */
		IC += offset;
		exvect = exret(MTC exvect);			/* Retries a routine */
		break;

	/*
	 * Start of precondition(s).
	 */
	case BC_PRECOND:
#ifdef DEBUG
		dprintf(2)("BC_PRECOND\n");
#endif
		offset = get_int32(&IC);
		pre_success = '\01';
		if (!(~in_assertion & WASC(icur_dtype) & CK_REQUIRE)) {
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

	/*
	 * Cast of a numeric type
	 */

	case BC_CAST_NATURAL:
		offset = get_int32(&IC);	/* Get natural size */
		last = otop ();
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
			case SK_CHAR:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_char; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_char; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_char; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_char; break;
					default:
						eif_panic ("Illegal type");
				}
			case SK_WCHAR:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_wchar; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_wchar; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_wchar; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_wchar; break;
					default:
						eif_panic ("Illegal type");
				}
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
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_real32; break;
					default:
						eif_panic ("Illegal type");
				}	
				break;
			case SK_REAL64:
				switch (offset) {
					case 8: last->it_uint8 = (EIF_NATURAL_8) last->it_real64; break;
					case 16: last->it_uint16 = (EIF_NATURAL_16) last->it_real64; break;
					case 32: last->it_uint32 = (EIF_NATURAL_32) last->it_real64; break;
					case 64: last->it_uint64 = (EIF_NATURAL_64) last->it_real64; break;
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
		last = otop ();
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
			case SK_CHAR:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_char; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_char; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_char; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_char; break;
					default:
						eif_panic ("Illegal type");
				}
			case SK_WCHAR:
				switch (offset) {
					case 8: last->it_int8 = (EIF_INTEGER_8) last->it_wchar; break;
					case 16: last->it_int16 = (EIF_INTEGER_16) last->it_wchar; break;
					case 32: last->it_int32 = (EIF_INTEGER_32) last->it_wchar; break;
					case 64: last->it_int64 = (EIF_INTEGER_64) last->it_wchar; break;
					default:
						eif_panic ("Illegal type");
				}
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
		last = otop ();
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
		last = otop ();
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
	 * Cast of an INTEGER_XX type to CHARACTER
	 */
	
	case BC_CAST_CHAR:
#ifdef DEBUG
		dprintf(2)("BC_CAST_CHAR\n");
#endif
		last = otop();
		switch (last->type & SK_HEAD) {
			case SK_UINT8: last->it_char = (EIF_CHARACTER) last->it_uint8; break;
			case SK_UINT16: last->it_char = (EIF_CHARACTER) last->it_uint16; break;
			case SK_UINT32: last->it_char = (EIF_CHARACTER) last->it_uint32; break;
			case SK_UINT64: last->it_char = (EIF_CHARACTER) last->it_uint64; break;
			case SK_INT8: last->it_char = (EIF_CHARACTER) last->it_int8; break;
			case SK_INT16: last->it_char = (EIF_CHARACTER) last->it_int16; break;
			case SK_INT32: last->it_char = (EIF_CHARACTER) last->it_int32; break;
			case SK_INT64: last->it_char = (EIF_CHARACTER) last->it_int64; break;
			}
		last->type = SK_CHAR;
		break;

	/*
	 * Assignment to result.
	 */
	case BC_RASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_RASSIGN\n");
#endif
		memcpy (iresult, opop(), ITEM_SZ);
		/* Register once function if needed. This has to be done constantly
		 * whenever the Result is changed, in case the once calls another
		 * feature which is going to call this once feature again.
		 */
		if (is_once) {
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
		{	EIF_REFERENCE ref = opop()->it_ref;

			if (ref == NULL)
				xraise(EN_VEXP);	/* Void assigned to expanded */
			eif_std_ref_copy(ref, iresult->it_ref);

			if (is_once) {
				last = iresult;
				switch (rtype & SK_HEAD) {	/* Result type held in rtype */
				case SK_BIT:
				case SK_EXP:
				case SK_REF:	/* See below */ 
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
		memcpy (loc (code) , opop(), ITEM_SZ);
		break;

	/*
	 * Assignment to a bit local variable.
	 */
	case BC_LBIT_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_LBIT_ASSIGN\n");
#endif
		code = get_int16(&IC);		/* Get the local number (from 1 to locnum) */
		last = opop();
		if ((last->type & SK_HEAD) != SK_BIT)
			/*
			 * This was necessary because the resulting type of operations
			 * on bits was SK_REF. 
			 */
			last->type = SK_BIT;
		b_copy(last->it_bit, loc(code)->it_bit);
		break;

	/*
	 * Assignment to an expanded local
	 */
	case BC_LEXP_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_LEXP_ASSIGN\n");
#endif
		{	EIF_REFERENCE ref = opop()->it_ref;

			if (ref == NULL)
				xraise(EN_VEXP);	/* Void assigned to expanded */
			code = get_int16(&IC);		/* Get the local # (from 1 to locnum) */
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
			uint32 type;

			offset = get_int32(&IC);		/* Get the feature id */
			code = get_int16(&IC);			/* Get the static type */
			type = get_uint32(&IC);		/* Get attribute meta-type */
			assign(RTWA(code, offset, icur_dtype), type);
		}
		break;

	/*
	 * Assignment to a precompiled attribute.
	 */
	case BC_PASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_PASSIGN\n");
#endif
		{
			int32 origin, ooffset;
			uint32 type;

			origin = get_int32(&IC);		/* Get the origin class id */
			ooffset = get_int32(&IC);		/* Get the offset in origin */
			type = get_uint32(&IC);		/* Get attribute meta-type */
			assign(RTWPA(origin, ooffset, icur_dtype), type);
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
			/* struct ac_info *info; */ /* %%ss removed */
			EIF_REFERENCE ref;

			ref = opop()->it_ref;		/* Expression type */
			if (ref == (EIF_REFERENCE) 0)
				xraise(EN_VEXP);		/* Void assigned to expanded */
			offset = get_int32(&IC);		/* Get the feature id */
			code = get_int16(&IC);			/* Get the static type */
			type = get_uint32(&IC);		/* Get attribute meta-type */
			offset = RTWA(code, offset, icur_dtype);
			eif_std_ref_copy (ref, icurrent->it_ref + offset);
		}
		break;

	/* 
	 * Attachment to a precompiled expanded attribute
	 */
	case BC_PEXP_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_PEXP_ASSIGN\n");
#endif
		{
			/* struct ac_info *info; */ /* %%ss removed */
			EIF_REFERENCE ref;
			int32 origin, ooffset;

			ref = opop()->it_ref;		/* Expression type */
			if (ref == (EIF_REFERENCE) 0)
				xraise(EN_VEXP);		/* Void assigned to expanded */
			origin = get_int32(&IC);		/* Get the origin class id */
			ooffset = get_int32(&IC);		/* Get the offset in origin */
			type = get_uint32(&IC);		/* Get attribute meta-type */
			offset = RTWPA(origin, ooffset, icur_dtype);
			eif_std_ref_copy (ref, icurrent->it_ref + offset);
		}
		break;

	/*
	 * Attchement to NONE entity
	 */
	case BC_NONE_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_NONE_ASSIGN\n");
#endif
		opop();
		break;

	/*
	 * Reverese assignment to Result.
	 */
	case BC_RREVERSE:
#ifdef DEBUG
		dprintf(2)("BC_RREVERSE\n");
#endif
		type = get_creation_type();			/* Get the reverse type */
		last = opop();

		if (!RTRA(type, last->it_ref))
			iresult->it_ref = (EIF_REFERENCE) 0;
		else
			iresult->it_ref = last->it_ref;

		/* Register once function if needed. This has to be done constantly
		 * whenever the Result is changed, in case the once calls another
		 * feature which is going to call this once feature again.
		 */
		if (is_once) {
			last = iresult;
			*(OResult->result.EIF_REFERENCE_result) = last->it_ref;
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
		type = get_creation_type ();
		last = opop();

		if (!RTRA(type, last->it_ref))
			loc(code)->it_ref = (EIF_REFERENCE) 0;
		else
			loc(code)->it_ref = last->it_ref;
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

			offset = get_int32(&IC);		/* Get the feature id */
			code = get_int16(&IC);			/* Get the static type */
			meta = get_uint32(&IC);		/* Get the attribute meta-type */
			type = get_creation_type ();
			last = otop();

			if (!RTRA(type, last->it_ref))
				last->it_ref = (EIF_REFERENCE) 0;
			assign(RTWA(code, offset, icur_dtype), meta);
		}
		break;

	/*
	 * Reverse assignment to a precompiled attribute.
	 */
	case BC_PREVERSE:
#ifdef DEBUG
		dprintf(2)("BC_PREVERSE\n");
#endif
		{
			int32 origin, ooffset;
			uint32 meta;

			origin = get_int32(&IC);		/* Get the origin class id */
			ooffset = get_int32(&IC);		/* Get the offset in origin */
			meta = get_uint32(&IC);		/* Get the attribute meta-type */
			type = get_creation_type ();
			last = otop();

			if (!RTRA(type, last->it_ref))
				last->it_ref = (EIF_REFERENCE) 0;
			assign(RTWPA(origin, ooffset, icur_dtype), meta);
		}
		break;

	/*
	 * Clone of a reference
	 */
	case BC_CLONE:
#ifdef DEBUG
		dprintf(2)("BC_CLONE\n");
#endif
		{	EIF_REFERENCE ref;
			unsigned long stagval;
	
			stagval = tagval;
			last = otop();
			ref = last->it_ref;
			last->it_ref = eclone(ref);	/* Empty clone */
			if (tagval != stagval)		/* eclone calls malloc which may
										 * call the interpreter for creation
										 * routines of expanded objects.
										 */
				sync_registers(MTC scur, stop);
			eif_std_ref_copy(ref, last->it_ref);	/* Copy to complete the clone */
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
#ifdef DEBUG
			dprintf(2)("BC_VOID\n");
#endif
			struct item * last;
			last = iget ();
			last->it_ref = NULL;
			last->type = SK_REF;
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
	 * Assertion checking.
	 */
	case BC_ASSERT:
#ifdef DEBUG
		dprintf(2)("BC_ASSERT\n");
#endif
		switch (*IC++) {
		case BC_PRE: 	assert_type = EX_PRE; break;
		case BC_PST:	assert_type = EX_POST; break;
		case BC_CHK:	assert_type = EX_CHECK; break;
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
			if ((assert_type == EX_CINV) || (assert_type == EX_INVC))
				RTIT((char *) string, icurrent->it_ref);
			else
				RTCT((char *) string, assert_type);
			break;
		case BC_NOTAG:				/* No assertion tag */
			if ((assert_type == EX_CINV) || (assert_type == EX_INVC))
				RTIS(icurrent->it_ref);
			else
				RTCS (assert_type);
			break;
		case BC_NOT_REC: break;		/* Do not record assertion */
		default:
			eif_panic(MTC "invalid tag opcode");
			/* NOTREADCHED */
		}
		break;

	/*
	 * End of assertion.
	 */
	case BC_END_ASSERT:
#ifdef DEBUG
		dprintf(2)("BC_END_ASSERT\n");
#endif
		code = (int) opop()->it_char;	/* Get the assertion 
										 * boolean result 
										 */
		if (code) {
			RTCK;				/* Assertion success */
		}
		else {
			RTCF;				/* Assertion failure */
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
		code = (int) opop()->it_char;
									/* Get the assertion boolean result */
		if (!code) {
			pre_success = '\0'; 
			IC += offset;
		} else {
			RTCK;
		}
		break;

	/*
	 * Raise exception. 
	 */
	case BC_RAISE_PREC:
#ifdef DEBUG
		dprintf(2)("BC_RAISE_PREC\n");
#endif
		if (!pre_success) {
			RTCF;
		}
		goto enter_body; /* Start execution of a routine body. */
		/* break; */

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
				pre_success = '\01';
									/* Reset success for next block */
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
			offset = opop()->it_int32;	/* Get the new variant value */
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
	 * Invariant checking after creation
	 */
	case BC_CREAT_INV:
#ifdef DEBUG
		dprintf(2)("BC_CREAT_INV\n");
#endif
		icheck_inv(MTC opop()->it_ref, scur, stop, 1);    /* Invariant */
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
			short has_args, has_open;
			struct item *addr, *true_addr, *aargs, *aopen;
			EIF_REFERENCE args, open, closed;

			args = open = closed = (EIF_REFERENCE) 0;
			has_args = get_int16(&IC); /* Do we have an argument tuple? */
			has_open = get_int16(&IC); /* Do we have an open map array? */
			type = get_int16(&IC);
			type = get_compound_id(MTC icurrent->it_ref,(short)type);
			true_addr = opop();  /* True address of routine */
			addr = opop();  /* Address of routine */
			if (has_open)
			{
				aopen = opop();
				open = (EIF_REFERENCE) (aopen->it_ref);
			}
			if (has_args)
			{
				aargs = opop();
				args = (EIF_REFERENCE) (aargs->it_ref);
			}
			stagval = tagval;
				/* Create new object */
			new_obj = RTLNR2((int16)type, addr->it_ptr, true_addr->it_ptr, args, open);

			last = iget();				/* Push a new value onto the stack */
			last->type = SK_REF;
			last->it_ref = new_obj;		/* Now it's safe for GC to see it */
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
		break;

	/*
	 * Creation instruction.
	 */
	case BC_CREATE:
		{
			char need_push = (char) 0;
#ifdef DEBUG
		dprintf(2)("BC_CREATE\n");
#endif
		/* Special treatment of BIT types */

		if (*IC == BC_BIT)
		{
			EIF_REFERENCE new_obj;		/* New bit object created */
			uint32 realcount;	/* Real bit count */

			++IC;
			last = iget();
			realcount = get_uint32(&IC);
			new_obj = RTLB(realcount);			/* Creation */
			last->type = SK_BIT + realcount;
			last->it_bit = new_obj;
			break;
		}
		need_push = *IC++;		/* If there is a creation routine to call
								   we need to push twice the created object */

		type = get_creation_type ();

		/* Creation of a new object. We know there will be no call to a
		 * creation routine, so it's useless to resynchronize registers--RAM.
		 */
		{
			EIF_REFERENCE new_obj;						/* New object */
			unsigned long stagval;

			stagval = tagval;
			new_obj = RTLNSMART(type);	/* Create new object */
			last = iget();				/* Push a new value onto the stack */
			last->type = SK_REF;	
			last->it_ref = new_obj;		/* Now it's safe for GC to see it */
			opush (last);				/* We need to push object on stack to check invariants */
			if (need_push == (char) 1)
				opush (last);			/* If there is a creation procedure, we need to push
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
			EIF_BOOLEAN is_ref, is_basic, is_expanded, is_bit;
			uint32 elem_size = 0, bit_size = 0, i = 0;
			uint32 flags = 0;
			struct item *nb_item;
			int16 exp_type;
			uint32 nb = 0;

			type = get_creation_type ();

			is_ref = EIF_TEST(*IC++);
			is_basic = EIF_TEST(*IC++);
			is_bit = EIF_TEST(*IC++);
			is_expanded = EIF_TEST(*IC++);

			if (is_expanded) {
					/* Need local since RTUD evaluates twice its argument. */
				exp_type = get_int16(&IC);
				elem_size = OVERHEAD + EIF_Size(RTUD(exp_type));
			} else {
				switch (get_uint32(&IC) & SK_HEAD) {
					case SK_CHAR: elem_size = sizeof(EIF_CHARACTER); break;
					case SK_WCHAR: elem_size = sizeof(EIF_WIDE_CHAR); break;
					case SK_BOOL: elem_size = sizeof(EIF_BOOLEAN); break;
					case SK_UINT8: elem_size = sizeof(EIF_NATURAL_8); break;
					case SK_UINT16: elem_size = sizeof(EIF_NATURAL_16); break;
					case SK_UINT32: elem_size = sizeof(EIF_NATURAL_32); break;
					case SK_UINT64: elem_size = sizeof(EIF_NATURAL_64); break;
					case SK_INT8: elem_size = sizeof(EIF_INTEGER_8); break;
					case SK_INT16: elem_size = sizeof(EIF_INTEGER_16); break;
					case SK_INT32: elem_size = sizeof(EIF_INTEGER_32); break;
					case SK_INT64: elem_size = sizeof(EIF_INTEGER_64); break;
					case SK_REAL32: elem_size = sizeof(EIF_REAL_32); break;
					case SK_REAL64: elem_size = sizeof(EIF_REAL_64); break;
					case SK_POINTER: elem_size = sizeof(EIF_POINTER); break;
					case SK_REF: elem_size = sizeof(EIF_REFERENCE); break;
					default:
						eif_panic ("Illegal type");
				}
			}

			nb_item = opop();
			CHECK("valid_type", (nb_item->type & SK_HEAD) == SK_INT32);
			nb = (uint32) nb_item->it_int32;

			if (is_expanded) {
				flags = EO_COMP;
			} else if (is_ref || is_bit) {
				flags = EO_REF;
			}
			new_obj = RTLNSP(type | flags, nb, elem_size, is_basic);	/* Create new object */
			last = iget();				/* Push a new value onto the stack */
			last->type = SK_REF;	
			last->it_ref = new_obj;		/* Now it's safe for GC to see it */
			opush (last);				/* We need to push object on stack to check invariants */

			if (is_bit) {
				bit_size = get_uint32(&IC);
				for (i = 0; i < nb; i++) {
					*((EIF_REFERENCE *) new_obj + i) = RTLB(bit_size);
					RTAR(new_obj, *((EIF_REFERENCE *) new_obj + i));
				}
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
			struct item *lower, *upper;

			upper = opop();				/* Get the upper bound */
			lower = opop();				/* Get the lower bound */
			last = otop();				/* Get the inspect expression value */
			offset = get_int32(&IC);		/* Get the jump value */
			switch (last->type) {
			case SK_UINT8: if (lower->it_uint8 <= last->it_uint8 && last->it_uint8 <= upper->it_uint8) { IC += offset; } break;
			case SK_UINT16: if (lower->it_uint16 <= last->it_uint16 && last->it_uint16 <= upper->it_uint16) { IC += offset; } break;
			case SK_UINT32: if (lower->it_uint32 <= last->it_uint32 && last->it_uint32 <= upper->it_uint32) { IC += offset; } break;
			case SK_UINT64: if (lower->it_uint64 <= last->it_uint64 && last->it_uint64 <= upper->it_uint64) { IC += offset; } break;
			case SK_INT8: if (lower->it_int8 <= last->it_int8 && last->it_int8 <= upper->it_int8) { IC += offset; } break;
			case SK_INT16: if (lower->it_int16 <= last->it_int16 && last->it_int16 <= upper->it_int16) { IC += offset; } break;
			case SK_INT32: if (lower->it_int32 <= last->it_int32 && last->it_int32 <= upper->it_int32) { IC += offset; } break;
			case SK_INT64: if (lower->it_int64 <= last->it_int64 && last->it_int64 <= upper->it_int64) { IC += offset; } break;
			case SK_CHAR: if (lower->it_char <= last->it_char && last->it_char <= upper->it_char) { IC += offset; } break;
			default:
				eif_panic(MTC "invalid inspect type");
				/* NOTREACHED */
			}
		}
		break;
	
	/*
	 * End of multi-branch instruction.
	 */
	case BC_INSPECT:
#ifdef DEBUG
		dprintf(2)("BC_INSPECT\n");
#endif
		(void) opop();				/* Pop the inspect expression */
		break;

	/*
	 * Unmatched inspect value.
	 */
	case BC_INSPECT_EXCEP:
#ifdef DEBUG
		dprintf(2)("BC_INSPECT_EXCEP\n");
#endif
		xraise(EN_WHEN);
		break;

	/*
	 * Call on a simple type.
	 */
	case BC_METAMORPHOSE:
#ifdef DEBUG
		dprintf(2)("BC_METAMORPHOSE\n");
#endif 	
		metamorphose_top();
		break;

	/*
	 * Calling an external function.
	 * Calling an Eiffel feature.
	 */
	case BC_EXTERN:
	case BC_FEATURE:
		offset = get_int32(&IC);				/* Get the feature id */
		code = get_int16(&IC);					/* Get the static type */
		nstcall = 0;						/* Invariant check turned off */
		if (icall(MTC (int)offset, code, GET_PTYPE))
			sync_registers(MTC scur, stop);
		break;

	/*
	 * Calling a precompiled external function.
	 * Calling a precompiled Eiffel feature.
	 */
	case BC_PEXTERN:
	case BC_PFEATURE:
		{
			int32 origin, offset;

			origin = get_int32(&IC);			/* Get the origin class id */
			offset = get_int32(&IC);			/* Get the offset in origin */
			nstcall = 0;					/* Invariant check turned off */
			if (ipcall(MTC origin, offset, GET_PTYPE))
				sync_registers(MTC scur, stop);
			break;
		}

	/*
	 * Calling an external in a nested expression (invariant check needed).
	 * Calling an Eiffel feature in a nested expression (invariant check).
	 */
	case BC_EXTERN_INV:
	case BC_FEATURE_INV:
		string = get_string8(&IC, -1);	/* Get the feature name. */
		if (otop()->it_ref == (char *) 0)	/* Called on a void reference? */
			eraise((char *) string, EN_VOID);		/* Yes, raise exception */
		offset = get_int32(&IC);				/* Get the feature id */
		code = get_int16(&IC);					/* Get the static type */

		nstcall = 1;					/* Invariant check turned on */
		if (icall(MTC (int)offset, code, GET_PTYPE))
			sync_registers(MTC scur, stop);
		break;

	/*
	 * Calling a precompiled external in a nested expression (invariant check needed).
	 * Calling a precompiled Eiffel feature in a nested expression (invariant check).
	 */
	case BC_PEXTERN_INV:
	case BC_PFEATURE_INV:
		{
			int32 offset, origin;

			string = get_string8(&IC, -1);	/* Get the feature name. */
			if (otop()->it_ref == (EIF_REFERENCE) 0)/* Called on a void reference? */
				eraise((char *) string, EN_VOID);	/* Yes, raise exception */
			origin = get_int32(&IC);			/* Get the origin class id */
			offset = get_int32(&IC);			/* Get the offset in origin */
			nstcall = 1;					/* Invariant check turned on */
			if (ipcall(MTC origin, offset, GET_PTYPE))
				sync_registers(MTC scur, stop);
			break;
		}

	/*
	 * Access to an attribute.
	 */
	case BC_ATTRIBUTE:
#ifdef DEBUG
		dprintf(2)("BC_ATTRIBUTE\n");
#endif
		{
			uint32 type;

			offset = get_int32(&IC);				/* Get feature id */
			code = get_int16(&IC);					/* Get static type */
			type = get_uint32(&IC);				/* Get attribute meta-type */
			interp_access((int)offset, code, type);
		}
		break;

	/*
	 * Access to a precompiled attribute.
	 */
	case BC_PATTRIBUTE:
#ifdef DEBUG
		dprintf(2)("BC_PATTRIBUTE\n");
#endif
		{
			int32 origin, ooffset;
			uint32 type;

			origin = get_int32(&IC);		/* Get the origin class id */
			ooffset = get_int32(&IC);		/* Get the offset in origin */
			type = get_uint32(&IC);		/* Get attribute meta-type */
			interp_paccess(origin, ooffset, type);
		}
		break;

	/*
	 * Accessing an attribute in a nested expression (need void ref. check).
	 */
	case BC_ATTRIBUTE_INV:
#ifdef DEBUG
		dprintf(2)("BC_ATTRIBUTE_INV\n");
#endif
		{
			uint32 type;
			string = get_string8(&IC, -1);	/* Get the attribute name */
			if (otop()->it_ref == (char *) 0)
				eraise((char *) string, EN_VOID);
			offset = get_int32(&IC);			/* Get feature id */
			code = get_int16(&IC);				/* Get static type */
			type = get_uint32(&IC);			/* Get attribute meta-type */
			interp_access((int)offset, code, type);
		}
		break;
			
	/*
	 * Accessing a precompiled attribute in a nested expression
	 * (need void ref. check).
	 */
	case BC_PATTRIBUTE_INV:
#ifdef DEBUG
		dprintf(2)("BC_PATTRIBUTE_INV\n");
#endif
		{
			int32 origin, ooffset;
			uint32 type;

			string = get_string8(&IC, -1);	/* Get the attribute name */
			if (otop()->it_ref == (char *) 0)
				eraise((char *) string, EN_VOID);
			origin = get_int32(&IC);			/* Get the origin class id */
			ooffset = get_int32(&IC);			/* Get the offset in origin */
			type = get_uint32(&IC);			/* Get attribute meta-type */
			interp_paccess(origin, ooffset, type);
		}
		break;
			
	/*
	 * Rotate the operational stack.
	 */
	case BC_ROTATE:
#ifdef DEBUG
		dprintf(2)("BC_ROTATE\n");
#endif
		{
			struct item old;			/* Save old value before copying */
			struct item prev;			/* Previous value to be copied */
			struct item *new;			/* Where value is to be copied */
			struct opstack op_context;  /* To save stack's context */

			code = get_int16(&IC) - 1;
			new = opop();
			memcpy (&prev, new, ITEM_SZ);

			memcpy (&op_context, &op_stack, sizeof(struct opstack));
			while (code-- > 0) {
				new = opop();
				memcpy (&old, new, ITEM_SZ);
				memcpy (new, &prev, ITEM_SZ);
				memcpy (&prev, &old,ITEM_SZ);
			}

			memcpy (&op_stack, &op_context, sizeof(struct opstack));

			opush(&prev);
		}
		break;

	/*
	 * Access to Current.
	 */
	case BC_CURRENT:
#ifdef DEBUG
		dprintf(2)("BC_CURRENT\n");
#endif
		last = iget();
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
		last = iget();
		last->type = SK_CHAR;
		last->it_char = *IC++;
		break;

	case BC_WCHAR:
#ifdef DEBUG
		dprintf(2)("BC_WCHAR\n");
#endif
		last = iget();
		last->type = SK_WCHAR;
		last->it_wchar = (EIF_WIDE_CHAR) get_int32(&IC);
		break;

	/*
	 * Boolean constant.
	 */
	case BC_BOOL:
#ifdef DEBUG
		dprintf(2)("BC_BOOL\n");
#endif
		last = iget();
		last->type = SK_BOOL;
		last->it_char = *IC++;
		break;

	/*
	 * Natural constant.
	 */
	case BC_UINT8:
		last = iget();
		last->type = SK_UINT8;
		last->it_uint8 = get_uint8 (&IC);
		break;

	case BC_UINT16:
		last = iget();
		last->type = SK_UINT16;
		last->it_uint16 = get_uint16 (&IC);
		break;

	case BC_UINT32:
		last = iget();
		last->type = SK_UINT32;
		last->it_uint32 = get_uint32(&IC);
		break;

	case BC_UINT64:
		last = iget();
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
		last = iget();
		last->type = SK_INT8;
		last->it_int8 = (EIF_INTEGER_8) (*IC++);
		break;

	case BC_INT16:
#ifdef DEBUG
		dprintf(2)("BC_INT16\n");
#endif
		last = iget();
		last->type = SK_INT16;
		last->it_int16 = (EIF_INTEGER_16) get_int16(&IC);
		break;

	case BC_INT32:
#ifdef DEBUG
		dprintf(2)("BC_INT32\n");
#endif
		last = iget();
		last->type = SK_INT32;
		last->it_int32 = (EIF_INTEGER_32) get_int32(&IC);
		break;

	case BC_INT64:
#ifdef DEBUG
		dprintf(2)("BC_INT64\n");
#endif
		last = iget();
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
		last = iget();
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
		last = iget();
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
		last = iget();
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
		(void) opush(iresult);
		break;
		
	/*
	 * Access to a local variable.
	 */
	case BC_LOCAL:
#ifdef DEBUG
		dprintf(2)("BC_LOCAL\n");
#endif
		code = get_int16(&IC);				/* Get number (from 1 to locnum) */
		last = iget();
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
		last = iget();
		memcpy (last, arg(code), ITEM_SZ);
		break;

	/*
	 * And then operator (left value).
	 */
	case BC_AND_THEN:
#ifdef DEBUG
		dprintf(2)("BC_AND_THEN\n");
#endif
		offset = get_int32(&IC);
		last = otop();
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
		last = otop();
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

	/*
	 * Basic operations to improve speed and correctness of operations
	 * on basic types.
	 */
	case BC_BASIC_OPERATIONS:
		eif_interp_basic_operations ();
		break;

	/*
	 * Bit operations on INTEGER
	 */
	
	case BC_INT_BIT_OP:
		eif_interp_bit_operations();
		break;

	/*
	 * Expanded comparison
 	 */
	case BC_STANDARD_EQUAL:
#ifdef DEBUG
	dprintf(2)("BC_STANDARD_EQUAL\n");
#endif
		{	EIF_REFERENCE ref;

			ref = opop()->it_ref;
			last = otop();
			last->it_char = (char) RTEQ(ref, last->it_ref);
			last->type = SK_BOOL;
		}
		break;

	/*
	 * Bit comparison
 	 */

	case BC_BIT_STD_EQUAL:
#ifdef DEBUG
	dprintf(2)("BC_STD_EQUAL\n");
#endif
		{	EIF_REFERENCE bit;

			bit = opop()->it_bit;
			last = otop();
			last->it_char = (char) RTEB(bit, last->it_bit);
			last->type = SK_BOOL;
		}
		break;

	/*
	 * Obvious true comparisons
	 */
	case BC_TRUE_COMPAR:
#ifdef DEBUG
	dprintf(2)("BC_TRUE_COMPAR\n");
#endif
		(void) opop();
		last = otop();
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
		(void) opop();
		last = otop();
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
		offset = get_int32(&IC);			/* Get the feature id */
		code = get_int16(&IC);				/* Get the static type */
		address((int32)offset, code, (int) get_int16(&IC));
		break;

	/*
	 * Reserved space (for object address)
	 */
	case BC_RESERVE:
#ifdef DEBUG
		dprintf(2)("BC_RESERVE\n");
#endif
		last = iget();
		last->type = SK_POINTER;
		last->it_ptr = NULL;
		break;
	/*
	 * Object address operator.
	 */
	case BC_OBJECT_ADDR:
		{
		struct item * volatile pointed_object = NULL;
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
					offset = get_int32(&IC);		/* Get feature id */
					code = get_int16(&IC);			/* Get static type */
					type = get_uint32(&IC);		/* Get attribute meta-type */
					offset = RTWA(code, (int)offset, Dtype(icurrent->it_ref));
					break;
				case BC_PATTRIBUTE:
					{
					int32 origin, ooffset;

					is_attribute = EIF_TRUE;
					origin = get_int32(&IC);		/* Get the origin class id */
					ooffset = get_int32(&IC);		/* Get the offset in origin */
					type = get_uint32(&IC);		/* Get attribute meta-type */
					offset = RTWPA(origin, ooffset, Dtype(icurrent->it_ref));
					break;
					}
				default:
					eif_panic(MTC "illegal access to Current");
				}

				last = oitem(value_offset);
				last->type = SK_POINTER;
				last->it_ref = (EIF_REFERENCE) (icurrent->it_ref+offset);
				break;
			default:
				eif_panic(MTC "illegal address access");
			}
			if (is_attribute == EIF_FALSE){
				last = oitem(value_offset);
				last->type = SK_POINTER;

				switch (pointed_object->type & SK_HEAD) {
					case SK_BOOL:
					case SK_CHAR: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_char)); break;
					case SK_WCHAR: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_wchar)); break;
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
					case SK_BIT: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_bit)); break;
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
		struct item *pointed_object;

		ptr_pos = get_uint32(&IC);
		value_pos = get_uint32(&IC);

		pointed_object = oitem(value_pos);
		last = oitem(ptr_pos);
		last->type = SK_POINTER;

		switch (pointed_object->type & SK_HEAD) {
			case SK_BOOL:
			case SK_CHAR: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_char)); break;
			case SK_WCHAR: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_wchar)); break;
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
			case SK_BIT: last->it_ref = (EIF_REFERENCE) (&(pointed_object->it_bit)); break;
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
			opop();
		}
		break;

	/*
	 * Manifest array
	 */
 
	case BC_ARRAY:
	case BC_PARRAY:
#ifdef DEBUG
		if (code == BC_ARRAY) {
			dprintf(2)("BC_ARRAY\n");
		} else {
			dprintf(2)("BC_PARRAY\n");
		}
#endif
		{
			int32 origin, ooffset;
			long nbr_of_items;
			EIF_REFERENCE new_obj;
			EIF_REFERENCE sp_area;
			short stype, dtype, feat_id;
			unsigned long stagval;
			int curr_pos = 0;
			struct item *it;
			long elem_size;
			unsigned char *OLD_IC;
 
			if (code == BC_PARRAY) {
				origin = get_int32(&IC);		/* Get the origin class id */
				ooffset = get_int32(&IC);		/* Get the offset in origin */
				dtype = get_int16(&IC);			/* Get the static type */

					/*GENERIC CONFORMANCE */
				dtype = get_compound_id(MTC icurrent->it_ref,dtype);

				nbr_of_items = get_int32(&IC);	  	/* Number of items in array */
				stagval = tagval;
				OLD_IC = IC;					/* Save IC counter */
	 
				new_obj = RTLN(dtype);			/* Create new object */
				RT_GC_PROTECT(new_obj);   /* Protect new_obj */
				((void (*)()) RTWPF(origin, ooffset, Dtype(new_obj))) (new_obj, 1L, nbr_of_items);
			} else {
				stype = get_int16(&IC);			/* Get the static type */
				dtype = get_int16(&IC);			/* Get the static type */

					/*GENERIC CONFORMANCE */
				dtype = get_compound_id(MTC icurrent->it_ref,dtype);

				feat_id = get_int16(&IC);		  	/* Get the feature id */
				nbr_of_items = get_int32(&IC);	  	/* Number of items in array */
				stagval = tagval;
				OLD_IC = IC;					/* Save IC counter */
	 
				new_obj = RTLN(dtype);			/* Create new object */
				RT_GC_PROTECT(new_obj);   /* Protect new_obj */
				((void (*)()) RTWF(stype, feat_id, Dtype(new_obj))) (new_obj, 1L, nbr_of_items);
			}

			IC = OLD_IC;
			if (tagval != stagval)
				sync_registers(MTC scur, stop); /* If calls melted make of array */ 
		
			sp_area = *(EIF_REFERENCE *) new_obj;
			RT_GC_PROTECT(sp_area);

			while (curr_pos < nbr_of_items) {
				/* Fill the special area with the expressions
				* for the manifest array.
				*/

				it = opop();		/* Pop expression off stack */
				switch (it->type & SK_HEAD) {
					case SK_BOOL:
					case SK_CHAR: *((EIF_CHARACTER *) sp_area + curr_pos) = it->it_char; break;
					case SK_WCHAR: *((EIF_WIDE_CHAR *) sp_area + curr_pos) = it->it_wchar; break;
					case SK_BIT: *((EIF_REFERENCE *) sp_area + curr_pos) = it->it_bit; break;
					case SK_UINT8: *((EIF_NATURAL_8 *) sp_area + curr_pos) = it->it_uint8; break;
					case SK_UINT16: *((EIF_NATURAL_16 *) sp_area + curr_pos) = it->it_uint16; break;
					case SK_UINT32: *((EIF_NATURAL_32 *) sp_area + curr_pos) = it->it_uint32; break;
					case SK_UINT64: *((EIF_NATURAL_64 *) sp_area + curr_pos) = it->it_uint64; break;
					case SK_INT8: *((EIF_INTEGER_8 *) sp_area + curr_pos) = it->it_int8; break;
					case SK_INT16: *((EIF_INTEGER_16 *) sp_area + curr_pos) = it->it_int16; break;
					case SK_INT32: *((EIF_INTEGER_32 *) sp_area + curr_pos) = it->it_int32; break;
					case SK_INT64: *((EIF_INTEGER_64 *) sp_area + curr_pos) = it->it_int64; break;
					case SK_REAL32: *((EIF_REAL_32 *) sp_area + curr_pos) = it->it_real32; break;
					case SK_REAL64: *((EIF_REAL_64 *) sp_area + curr_pos) = it->it_real64; break;
					case SK_POINTER: *((EIF_POINTER *) sp_area + curr_pos) = it->it_ptr; break;
					case SK_EXP:
						elem_size = *(EIF_INTEGER_32 *) (sp_area + (HEADER(sp_area)->ov_size & B_SIZE) - LNGPAD_2 + sizeof(EIF_INTEGER_32));
						ecopy(it->it_ref, sp_area + OVERHEAD + elem_size * curr_pos);
						break;
					case SK_REF:
						*((EIF_REFERENCE *) sp_area + curr_pos) = it->it_ref;
						RTAR(sp_area, it->it_ref);
						break;
					default:
						eif_panic(MTC RT_BOTCHED_MSG);
				}
				curr_pos++;
			}
			RT_GC_WEAN(sp_area);			/* Release protection of `sp_area' */
			RT_GC_WEAN(new_obj);			/* and of `new_obj'. */
			last = iget();
			last->type = SK_REF;
			last->it_ref = new_obj;
			break;
		}

	case BC_TUPLE:
	case BC_PTUPLE:
#ifdef DEBUG
		if (code == BC_TUPLE) {
			dprintf(2)("BC_TUPLE\n");
		} else {
			dprintf(2)("BC_PTUPLE\n");
		}
#endif
		{
			long nbr_of_items;
			EIF_REFERENCE new_obj;
			short dtype;
			unsigned long stagval;
			int curr_pos = 1;	/* 1 because tuple starts at 1 */
			struct item *it;
			unsigned char *OLD_IC;
			EIF_BOOLEAN is_atomic;
 
			dtype = get_int16(&IC);			/* Get the static type */

				/*GENERIC CONFORMANCE */
			dtype = get_compound_id(MTC icurrent->it_ref,dtype);

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

				it = opop();		/* Pop expression off stack */
				switch (it->type & SK_HEAD) {
					case SK_BOOL: eif_put_boolean_item(new_obj, curr_pos, it->it_char); break;
					case SK_CHAR: eif_put_character_item(new_obj, curr_pos, it->it_char); break;
					case SK_WCHAR: eif_put_wide_character_item(new_obj, curr_pos, it->it_wchar); break;
					case SK_BIT: eif_put_reference_item(new_obj, curr_pos, it->it_bit); break;
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
			last = iget();
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
		last = iget();
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
		
		in_assertion = 0;
		break;

	/*
	 * Place Old expression value into local register.
	 */
	case BC_OLD:
#ifdef DEBUG
		dprintf(2)("BC_OLD\n");
#endif
		last = opop();
		code = get_int16(&IC);     /* Get the local number (from 1 to locnum) */
		if ((last->type & SK_HEAD) == SK_EXP) {
				/* Case of an expanded, then we need to copy its original value. */
			eif_std_ref_copy(last->it_ref, loc(code)->it_ref);
		} else {
			memcpy (loc(code), last, ITEM_SZ);
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
		last = iget();
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
				last = opop();
				stripped[nbr_of_items] = last->it_ref; 
			}
			array = striparr(icurrent->it_ref, d_type, stripped, temp);
			if (tagval != stagval)
				sync_registers(MTC scur, stop); /* If G.C calls melted dispose */
			eif_rt_xfree ((EIF_REFERENCE) stripped);
			last = iget();
			last->type = SK_REF;
			last->it_ref = array;
			break;
		}

	/*
	 * Once manifest string.
	 */
	case BC_ONCE_STRING:
#ifdef DEBUG
		dprintf(2)("BC_ONCE_STRING\n");
#endif
		{
			unsigned long stagval;
			int32 body_index;	/* routine body index */
			int32 number;	/* number of the once manifest string in routine body */
			int32 length;	/* length of once manifest string */
 
			stagval = tagval;
			body_index = get_int32(&IC);	/* Get routine body index */
			number = get_int32(&IC);	/* Get number of the once manifest string in the routine body */
			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */

			last = iget();
			last->type = SK_REF;
			RTCOMS (last->it_ref, body_index, number, (char *) string, length, 0);

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
	 * Manifest string.
	 */
	case BC_STRING:
#ifdef DEBUG
		dprintf(2)("BC_STRING\n");
#endif
		{
			EIF_REFERENCE str_obj;			  /* String object created */
			unsigned long stagval;
			int32 length;
 
			stagval = tagval;
			length = get_int32(&IC);
			string = get_string8(&IC, length);	/* Get string of specified length. */
			last = iget();
			last->type = SK_INT32;		/* Protect empty cell from GC */
 
			/* We have to use the str_obj temporary variable instead of doing
			 * the assignment directly into last->it_ref because the GC might
			 * run a cycle when makestr() is called...
			 */

			str_obj = makestr((char *) string, length);
 
			last->type = SK_REF;
			last->it_ref = str_obj;
			if (tagval != stagval)
				sync_registers(MTC scur,stop);
			break;
		}
 

	/*
	 * Manifest bit
	 */
	case BC_BIT:
#ifdef DEBUG
		dprintf(2)("BC_BIT\n");
#endif
		{
			EIF_REFERENCE new_obj;		/* New bit object created */
			uint32 bcount;		/* Bit count */
			uint32 realcount;	/* Real bit count */
			int nb_uint32;
			uint32 *addr;

			last = iget();
			realcount = get_uint32(&IC);
			bcount = get_uint32(&IC);			/* Read bit count */
			new_obj = RTLB(realcount);			/* Creation */
			addr = ARENA(new_obj);
			nb_uint32 = BIT_NBPACK(bcount);
			while (nb_uint32--)	/* Write bit count and value in `new_obj' */ 
				*addr++ = get_uint32(&IC);
			last->type = SK_BIT + bcount; /* bcount or realcount ??*/
			last->it_bit = new_obj;
		}
		break;
			
	/*
	 * Jump if top of stack is false (value is poped).
	 */
	case BC_JMP_F:				/* Jump if false */
#ifdef DEBUG
		dprintf(2)("BC_JMP_F\n");
#endif
		offset = get_int32(&IC);	/* Get jump offset */
		code = (int) opop()->it_char;
		if (!code)
			IC += offset;		/* Jump */
		break;

	/*
	 * Jump if top of stack is true (value is poped).
	 */
	case BC_JMP_T:				/* Jump if false */
#ifdef DEBUG
		dprintf(2)("BC_JMP_T\n");
#endif
		offset = get_int32(&IC);	/* Get jump offset */
		code = (int) opop()->it_char;
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
		saved_scur = scur;			/* save feature context */
		saved_stop = stop;			/* save feature context */
		dstop(dtop()->dc_exec,offset);	/* Debugger hook , dtop->dc_exec returns the current execution vector */
		saved_scur = NULL;			/* reset feature context */
		saved_stop = NULL;			/* reset feature context */
		break;

	/*
	 * Debugger hook for nested calls.
	 */
	case BC_NHOOK:
#ifdef DEBUG
		dprintf(2)("BC_NHOOK\n");
#endif
		offset = get_int32(&IC);		/* retrieve the parameter of BC_NHOOK: line number */
		saved_scur = scur;			/* save feature context */
		saved_stop = stop;			/* save feature context */
		dstop_nested(dtop()->dc_exec,offset);	/* Debugger hook - stop point reached */
		saved_scur = NULL;			/* reset feature context */
		saved_stop = NULL;			/* reset feature context */
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
			struct item *my_last;
			my_last = otop();
			my_last->type = SK_POINTER;
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
		return;

	/*
	 * End of current Eiffel routine.
	 */
	case BC_NULL:
#ifdef DEBUG
		dprintf(2)("BC_NULL\n");
#endif
		if (is_nested)		/* Nested feature call (dot notation) */
			icheck_inv(MTC icurrent->it_ref, scur, stop, 1);	/* Invariant */
		pop_registers();	/* Pop registers */
		/* leave_body: */
			/* Exit rutine body. */
		if (is_once) {
				/* Remove execution vector to restore    */
				/* previous exception catch point.       */
			exvect = extrl();
			dexset(exvect);
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
		pop_registers();	/* Pop registers */
		return;

	default:
		eif_panic(MTC "illegal opcode");
		/* NOTREACHED */
	}
	continue;
		/* Setup data on entering routine body */
	enter_body:
	if (is_once) {
		EIF_BOOLEAN was_executed = EIF_FALSE;
#ifdef EIF_THREADS
		if (is_process_once) {
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
		}
		else
#endif /* EIF_THREADS */
		was_executed = MTOD(OResult);

			/* Check if once routine was executed earlier. */
		if (was_executed) {
				/* Yes, it was executed.      */
				/* Ckeck if it failed or not. */
			if (MTOF(OResult)) {
					/* Raise its exception. */
				xraise (MTOF(OResult));
			}
				/* Retrieve once result. */
			get_once_result (OResult, rtype, iresult);
				/* Pop registers */
			pop_registers();
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
			jmp_buf exenvo;
				/* Mark once routine as executed. */
			MTOM(OResult);
				/* Record execution vector to catch exception. */
			exvecto = extre ();
			if (!setjmp(exenvo)) {
					/* Set catch address. */
				exvect->ex_jbuf = &exenvo;
					/* Update routine exception vector. */
				exvect = exvecto;
				dexset(exvect);
				switch (rtype & SK_HEAD)
				{
				case SK_BIT:
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
				create_expanded_locals (scur, stop);
					/* Initialize permanent storage */
				put_once_result (iresult, rtype, OResult);
					/* FIXME: register process-relative onces. */
					/* Mark this once routine as executed. */
				onceadd(body_id);
					/* Register rescue handler (if any). */
				SET_RESCUE;
			} else {
					/* Exception occurred. */
					/* Record it for future use. */
				MTOE(OResult, echval);
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
					/* Raise the exception. */
				xraise (echval);
			}
		}
	} else {
		if (flag == INTERP_CMPD) {
				/* Initialize expanded locals */
			create_expanded_locals (scur, stop);
		}
			/* Register rescue handler (if any). */
		SET_RESCUE;
	}
	}							/* Remember: indentation was wrong--RAM */
	/* NOTREACHED */
}
#undef EIF_VOLATILE
#define EIF_VOLATILE

rt_private void icheck_inv(EIF_REFERENCE obj, struct stochunk *scur, struct item *stop, int where)          
					  		/* Current chunk (stack context) */
							/* To save stack context */
		  					/* Invariant after or before */
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	/* Check invariant on non-void object `obj' */
	unsigned char *OLD_IC;		/* IC backup */
	int dtype = Dtype(obj);

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

rt_private void irecursive_chkinv(int dtype, EIF_REFERENCE obj, struct stochunk *scur, struct item *stop, int where)
		  
		  
					  		/* Current chunk (stack context) */
				  			/* To save stack context */
		  					/* Invariant after or before */
{
	/* Recursive invariant check. */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	struct cnode *node = esystem + dtype;
	int *cn_parents;
	int p_type;

	if (dtype <= 0) return;		/* ANY does not have invariants */

	if ((char) 0 != inv_mark_table[dtype])	/* Already checked */
		return;
	else
		inv_mark_table[dtype] = (char) 1;	/* Mark as checked */

	/* Automatic protection of `obj' */
	RT_GC_PROTECT(obj);

	/* Recursion on parents first. */
	cn_parents = node->cn_parents;

	/* The list of parent dynamic types is always terminated by a
	 * -1 value. -- FREDD
	 */
	while ((p_type = *cn_parents++) != -1)
		/* Call to potential parent invariant */
		irecursive_chkinv(MTC p_type, obj, scur, stop, where);

	/* Invariant check */
	{
		BODY_INDEX body_id;
		struct item *last;

		CBodyId(body_id,INVARIANT_ID,dtype);	
		if (body_id != INVALID_ID) {
			if (egc_frozen [body_id]) {		/* Frozen invariant */
				unsigned long stagval = tagval;	/* Tag value backup */
	
				((void (*)()) egc_frozen[body_id])(obj, where);
	
				if (tagval != stagval)			/* Resynchronize registers */
					sync_registers(MTC scur, stop);
	
			} else 
			{				/* Melted invariant */
				last = iget();					/* Push `obj' */
				last->type = SK_REF;
				last->it_ref = obj;

				/*IC = melt[body_id];*/
				/*interpret(INTERP_INVA, where);*//* Interpret invariant code */

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

	struct item *first;			/* First operand */

	first = otop();				/* Item will get modified */

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

	struct item *second;		/* Second operand */
	struct item *first;			/* First operand */
	
#define f first
#define s second

	s = opop();			/* Fetch second operand */
	f = otop();			/* First operand will be replace by result */

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
		eif_interp_gt(f, s);
		f->it_char = EIF_TEST (!f->it_char);
		break;

	/* Lesser than operation. */
	case BC_LT:
		eif_interp_lt (f, s);
		break;

	/* Greater or equal operation. */
	case BC_GE:
		eif_interp_lt (f, s);
		f->it_char = EIF_TEST(!f->it_char);
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
		uint32 sk_type = s->type & SK_HEAD;
			/* Special case for `-' from CHARACTER and WIDE_CHARACTER class. */
		if ((f->type & SK_HEAD) == SK_CHAR) {
			CHECK ("right operand is INTEGER_32", sk_type == SK_INT32);
			f->it_char = f->it_char - s->it_int32;
		} else if ((f->type & SK_HEAD) == SK_WCHAR) {
			CHECK ("right operand is INTEGER_32", sk_type == SK_INT32);
			f->it_wchar = f->it_wchar - s->it_int32;
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
		uint32 sk_type = s->type & SK_HEAD;
			/* Special case for `+' from CHARACTER and WIDE_CHARACTER class. */
		if ((f->type & SK_HEAD) == SK_CHAR) {
			CHECK ("right operand is INTEGER_32", sk_type == SK_INT32);
			f->it_char = f->it_char + s->it_int32;
		} else if ((f->type & SK_HEAD) == SK_WCHAR) {
			CHECK ("right operand is INTEGER_32", sk_type == SK_INT32);
			f->it_wchar = f->it_wchar + s->it_int32;
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

rt_private void eif_interp_gt(struct item *f, struct item *s) {
	switch(f->type & SK_HEAD) {
		case SK_CHAR: f->it_char = f->it_char > s->it_char; break;
		case SK_WCHAR: f->it_char = f->it_wchar > s->it_wchar; break;
		case SK_UINT8: f->it_char = f->it_uint8 > s->it_uint8; break;
		case SK_UINT16: f->it_char = f->it_uint16 > s->it_uint16; break;
		case SK_UINT32: f->it_char = f->it_uint32 > s->it_uint32; break;
		case SK_UINT64: f->it_char = f->it_uint64 > s->it_uint64; break;
		case SK_INT8: f->it_char = f->it_int8 > s->it_int8; break;
		case SK_INT16: f->it_char = f->it_int16 > s->it_int16; break;
		case SK_INT32: f->it_char = f->it_int32 > s->it_int32; break;
		case SK_INT64: f->it_char = f->it_int64 > s->it_int64; break;
		case SK_REAL32: f->it_char = f->it_real32 > s->it_real32; break;
		case SK_REAL64: f->it_char = f->it_real64 > s->it_real64; break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	f->type = SK_BOOL;		/* Result is a boolean */
}

rt_private void eif_interp_lt(struct item *f, struct item *s) {
	switch(f->type & SK_HEAD) {
		case SK_CHAR: f->it_char = f->it_char < s->it_char; break;
		case SK_WCHAR: f->it_char = f->it_wchar < s->it_wchar; break;
		case SK_UINT8: f->it_char = f->it_uint8 < s->it_uint8; break;
		case SK_UINT16: f->it_char = f->it_uint16 < s->it_uint16; break;
		case SK_UINT32: f->it_char = f->it_uint32 < s->it_uint32; break;
		case SK_UINT64: f->it_char = f->it_uint64 < s->it_uint64; break;
		case SK_INT8: f->it_char = f->it_int8 < s->it_int8; break;
		case SK_INT16: f->it_char = f->it_int16 < s->it_int16; break;
		case SK_INT32: f->it_char = f->it_int32 < s->it_int32; break;
		case SK_INT64: f->it_char = f->it_int64 < s->it_int64; break;
		case SK_REAL32: f->it_char = f->it_real32 < s->it_real32; break;
		case SK_REAL64: f->it_char = f->it_real64 < s->it_real64; break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	f->type = SK_BOOL;		/* Result is a boolean */
}

rt_private void eif_interp_eq (struct item *f, struct item *s) {
	switch(f->type & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR: f->it_char = f->it_char == s->it_char; break;
		case SK_WCHAR: f->it_char = f->it_wchar == s->it_wchar; break;
		case SK_UINT8: f->it_char = f->it_uint8 == s->it_uint8; break;
		case SK_UINT16: f->it_char = f->it_uint16 == s->it_uint16; break;
		case SK_UINT32: f->it_char = f->it_uint32 == s->it_uint32; break;
		case SK_UINT64: f->it_char = f->it_uint64 == s->it_uint64; break;
		case SK_INT8: f->it_char = f->it_int8 == s->it_int8; break;
		case SK_INT16: f->it_char = f->it_int16 == s->it_int16; break;
		case SK_INT32: f->it_char = f->it_int32 == s->it_int32; break;
		case SK_INT64: f->it_char = f->it_int64 == s->it_int64; break;
		case SK_REAL32: f->it_char = f->it_real32 == s->it_real32; break;
		case SK_REAL64: f->it_char = f->it_real64 == s->it_real64; break;
		case SK_POINTER: f->it_char = f->it_ptr == s->it_ptr; break;
		case SK_BIT:
		case SK_EXP:
		case SK_REF: f->it_char = f->it_ref == s->it_ref; break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	f->type = SK_BOOL;		/* Result is a boolean */
}

rt_private void eif_interp_generator (void)
{
	/* Execute the `generator' or `generating_type' function call for basic types
	 * in melted code
	 */
	struct item *first;			/* First operand */
	
	first = otop();				/* First operand will be replace by result */
	switch (first->type & SK_HEAD) {
		case SK_BOOL: first->it_ref = RTMS_EX("BOOLEAN", 7); break;
		case SK_CHAR: first->it_ref = RTMS_EX("CHARACTER", 9); break;
		case SK_WCHAR: first->it_ref = RTMS_EX("WIDE_CHARACTER", 14); break;
		case SK_UINT8: first->it_ref = RTMS_EX("NATURAL_8", 9); break;
		case SK_UINT16: first->it_ref = RTMS_EX("NATURAL_16", 10); break;
		case SK_UINT32: first->it_ref = RTMS_EX("NATURAL_32", 10); break;
		case SK_UINT64: first->it_ref = RTMS_EX("NATURAL_64", 10); break;
		case SK_INT8: first->it_ref = RTMS_EX("INTEGER_8", 9); break;
		case SK_INT16: first->it_ref = RTMS_EX("INTEGER_16", 10); break;
		case SK_INT32: first->it_ref = RTMS_EX("INTEGER", 7); break;
		case SK_INT64: first->it_ref = RTMS_EX("INTEGER_64", 10); break;
		case SK_REAL32: first->it_ref = RTMS_EX("REAL_32", 7); break;
		case SK_REAL64: first->it_ref = RTMS_EX("REAL_64", 7); break;
		case SK_POINTER: first->it_ref = RTMS_EX("POINTER", 7); break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
	first->type = SK_REF;
}

rt_private void eif_interp_min_max (int code)
{
	/* Execute the `max' or `min' operation (shown by "code") on CHARACTER,
	 * INTEGER, REAL and DOUBLE and push the result back on the stack.
	 * Instead of poping the two operands and pushing the result back, we handle
	 * the references of both, poping only the second. I am relying on the fact
	 * that the last poped value remains uccorrupted in a non-freed chunk--RAM.
	 */
#define EIF_MAX(a,b) ((a)>(b)? (a) : (b))
#define EIF_MIN(a,b) ((a)<(b)? (a) : (b))

	struct item *second;		/* Second operand */
	struct item *first;			/* First operand */
	
	second = opop();			/* Fetch second operand */
	first = otop();				/* First operand will be replace by result */

	switch (code) {				/* Execute operation */
		case BC_MAX:
			switch(first->type & SK_HEAD) {
				case SK_CHAR: first->it_char = (EIF_CHARACTER) EIF_MAX(first->it_char, second->it_char); break;
				case SK_WCHAR: first->it_wchar = (EIF_CHARACTER) EIF_MAX(first->it_wchar, second->it_wchar); break;
				case SK_UINT8: first->it_uint8 = (EIF_NATURAL_8) EIF_MAX(first->it_uint8, second->it_uint8); break;
				case SK_UINT16: first->it_uint16 = (EIF_NATURAL_16) EIF_MAX(first->it_uint16, second->it_uint16); break;
				case SK_UINT32: first->it_uint32 = (EIF_NATURAL_32) EIF_MAX(first->it_uint32, second->it_uint32); break;
				case SK_UINT64: first->it_uint64 = (EIF_NATURAL_64) EIF_MAX(first->it_uint64, second->it_uint64); break;
				case SK_INT8: first->it_int8 = (EIF_INTEGER_8) EIF_MAX(first->it_int8, second->it_int8); break;
				case SK_INT16: first->it_int16 = (EIF_INTEGER_16) EIF_MAX(first->it_int16, second->it_int16); break;
				case SK_INT32: first->it_int32 = (EIF_INTEGER_32) EIF_MAX(first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = (EIF_INTEGER_64) EIF_MAX(first->it_int64, second->it_int64); break;
				case SK_REAL32: first->it_real32 = (EIF_REAL_32) EIF_MAX(first->it_real32, second->it_real32); break;
				case SK_REAL64: first->it_real64 = (EIF_REAL_64) EIF_MAX(first->it_real64, second->it_real64); break;
				default: eif_panic(MTC RT_BOTCHED_MSG);
				}
			break;
		case BC_MIN:
			switch(first->type & SK_HEAD) {
				case SK_CHAR: first->it_char = (EIF_CHARACTER) EIF_MIN(first->it_char, second->it_char); break;
				case SK_WCHAR: first->it_wchar = (EIF_CHARACTER) EIF_MIN(first->it_wchar, second->it_wchar); break;
				case SK_UINT8: first->it_uint8 = (EIF_NATURAL_8) EIF_MIN(first->it_uint8, second->it_uint8); break;
				case SK_UINT16: first->it_uint16 = (EIF_NATURAL_16) EIF_MIN(first->it_uint16, second->it_uint16); break;
				case SK_UINT32: first->it_uint32 = (EIF_NATURAL_32) EIF_MIN(first->it_uint32, second->it_uint32); break;
				case SK_UINT64: first->it_uint64 = (EIF_NATURAL_64) EIF_MIN(first->it_uint64, second->it_uint64); break;
				case SK_INT8: first->it_int8 = (EIF_INTEGER_8) EIF_MIN(first->it_int8, second->it_int8); break;
				case SK_INT16: first->it_int16 = (EIF_INTEGER_16) EIF_MIN(first->it_int16, second->it_int16); break;
				case SK_INT32: first->it_int32 = (EIF_INTEGER_32) EIF_MIN(first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = (EIF_INTEGER_64) EIF_MIN(first->it_int64, second->it_int64); break;
				case SK_REAL32: first->it_real32 = (EIF_REAL_32) EIF_MIN(first->it_real32, second->it_real32); break;
				case SK_REAL64: first->it_real64 = (EIF_REAL_64) EIF_MIN(first->it_real64, second->it_real64); break;
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

	struct item *second;		/* Second operand */
	struct item *first;			/* First operand */
	
	second = opop();			/* Fetch second operand */
	first = otop();				/* First operand will be replace by result */

	REQUIRE("Same type", (first->type & SK_HEAD) == (second->type & SK_HEAD));

	switch(first->type & SK_HEAD) {
		case SK_CHAR: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_char, second->it_char); break;
		case SK_WCHAR: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_wchar, second->it_wchar); break;
		case SK_UINT8: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_uint8, second->it_uint8); break;
		case SK_UINT16: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_uint16, second->it_uint16); break;
		case SK_UINT32: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_uint32, second->it_uint32); break;
		case SK_UINT64: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_uint64, second->it_uint64); break;
		case SK_INT8: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_int8, second->it_int8); break;
		case SK_INT16: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_int16, second->it_int16); break;
		case SK_INT32: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_int32, second->it_int32); break;
		case SK_INT64: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_int64, second->it_int64); break;
		case SK_REAL32: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_real32, second->it_real32); break;
		case SK_REAL64: first->it_int32 = (EIF_INTEGER_32) EIF_THREE_WAY_COMPARISON(first->it_real64, second->it_real64); break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}

	first->type = SK_INT32;

	ENSURE("New type", (first->type & SK_HEAD) == SK_INT32);
#undef EIF_THREE_WAY_COMPARISON
}

rt_private void eif_interp_offset(void)
{
	/* Execute the `+' operator on CHARACTER or POINTER type and push
	 * the result back on the stack.
	 * Instead of poping the two operands and pushing the result back, we handle
	 * the references of both, poping only the second. I am relying on the fact
	 * that the last poped value remains uccorrupted in a non-freed chunk--RAM.
	 */

	struct item *second;		/* Second operand */
	struct item *first;			/* First operand */
	
	second = opop();			/* Fetch second operand */
	first = otop();				/* First operand will be replace by result */
	switch(first->type & SK_HEAD) {
		case SK_CHAR:
			first->it_char = (EIF_CHARACTER) (((EIF_INTEGER_32) first->it_char) + second->it_int32);
			break;
		case SK_POINTER:
			first->it_ptr = RTPOF(first->it_ptr, second->it_int32);
			break;
		default: eif_panic(MTC RT_BOTCHED_MSG);
	}
}

rt_private void eif_interp_basic_operations (void)
	/* execute basic operations on basic types and put the result back on the
	 * stack.
	 */
{
	EIF_GET_CONTEXT
	int code = *IC++;		/* Read current byte-code and advance IC */
	struct item *first;		/* First operand */

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
		case BC_GENERATOR:
			eif_interp_generator ();
			break;

			/* Offset operation on CHARACTER and POINTER */
		case BC_OFFSET:
			eif_interp_offset();
			break;
	
			/* Call to `zero' */
		case BC_ZERO:
			first = otop();	/* First operand will be replace by result */
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
			first = otop();	/* First operand will be replace by result */
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
	struct item *third = (struct item *) 0;
	struct item *second = (struct item *) 0;
	struct item *first = (struct item *) 0;

	if (code == BC_INT_SET_BIT || code == BC_INT_SET_BIT_WITH_MASK) {
		third = opop();		/* Fetch third operand */
	}
	if (code != BC_INT_BIT_NOT) {
		second = opop();	/* Fetch second operand if required */
	}
	first = otop ();		/* First operand, it will be replaced by result */

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
				case SK_UINT8: first->it_uint8 = eif_bit_shift_left (first->it_uint8, second->it_int32); break;
				case SK_UINT16: first->it_uint16 = eif_bit_shift_left (first->it_uint16, second->it_int32); break;
				case SK_UINT32: first->it_uint32 = eif_bit_shift_left (first->it_uint32, second->it_int32); break;
				case SK_UINT64: first->it_uint64 = eif_bit_shift_left (first->it_uint64, second->it_int32); break;
				case SK_INT8: first->it_int8 = eif_bit_shift_left (first->it_int8, second->it_int32); break;
				case SK_INT16: first->it_int16 = eif_bit_shift_left (first->it_int16, second->it_int32); break;
				case SK_INT32: first->it_int32 = eif_bit_shift_left (first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = eif_bit_shift_left (first->it_int64, second->it_int32); break;
				}
			break;
		case BC_INT_BIT_SHIFT_RIGHT:
			switch (first->type & SK_HEAD) {
				case SK_UINT8: first->it_uint8 = eif_bit_shift_right (first->it_uint8, second->it_int32); break;
				case SK_UINT16: first->it_uint16 = eif_bit_shift_right (first->it_uint16, second->it_int32); break;
				case SK_UINT32: first->it_uint32 = eif_bit_shift_right (first->it_uint32, second->it_int32); break;
				case SK_UINT64: first->it_uint64 = eif_bit_shift_right (first->it_uint64, second->it_int32); break;
				case SK_INT8: first->it_int8 = eif_bit_shift_right (first->it_int8, second->it_int32); break;
				case SK_INT16: first->it_int16 = eif_bit_shift_right (first->it_int16, second->it_int32); break;
				case SK_INT32: first->it_int32 = eif_bit_shift_right (first->it_int32, second->it_int32); break;
				case SK_INT64: first->it_int64 = eif_bit_shift_right (first->it_int64, second->it_int32); break;
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
 * Function calling routines
 */

rt_public struct item *dynamic_eval(int fid, int stype, int is_precompiled, int is_basic_type, struct item* previous_otop)
						/* Feature ID or offset if the feature is precompiled */
						/* Static type (entity where feature is applied) */
						/* Is it an external or an Eiffel feature */
						/* Precompiled ? (0=no, other=yes) */
						/* Is the call performed on a basic type? (INTEGER...) */
	{
	/* This is the debugger dispatcher for routine calls. It is called when
	 * the user want to dynamically evaluate a feature. Depending on the
	 * routine's temperature, the snow version (i.e. C code) is called and the
	 * result, if any, is left on the operational stack. The I->C pattern is
	 * called to push the parameters on the "C stack" correctly. Otherwise,
	 * the interpreter is called. The function returns 1 to the caller if a
	 * resynchronization of registers is needed.
	 * FIXME XR: I believe we save and restore things which are not needed
	 * (in particular we save the stack context but xinterp does it too)
	 * so if someone understands what I have written and feels like clearing it up,
	 * they're welcome to do so (I give up: I think it works and that's enough).
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	RTED;
	int				saved_debug_mode = debug_mode;
	BODY_INDEX		body_id = 0;		/* Value of selected body ID */
	unsigned long 	stagval = tagval;	/* Save tag value */
	unsigned char *	OLD_IC = NULL;		/* IC back-up */
	unsigned char	sync_needed = 0;	/* A priori, no need for sync_registers */
	uint32 			pid = 0;			/* Pattern id of the frozen feature */
	int32 			rout_id = 0;		/* routine id of the requested feature */
	struct item 	*result = NULL;		/* Result of the function (NULL if none) */
	struct stochunk *previous_scur = saved_scur;
	struct item		*previous_stop = saved_stop;
	uint32			type = 0;			/* Dynamic type of the result */
	uint32 EIF_VOLATILE db_cstack;
	STACK_PRESERVE;
	RTXD; /* declares the variables used to save the run-time stacks context */
	RTLXD;

	RTLXL;
	dstart();
	SAVE(db_stack, dcur, dtop);
	SAVE(op_stack, scur, stop);
	db_cstack = d_data.db_callstack_depth;

	if (is_basic_type)
			/* We need to create a reference to the basic type on the fly */
		metamorphose_top();
	if (! is_precompiled) {
		rout_id = Routids(stype)[fid];
		CBodyId(body_id,rout_id,Dtype(otop()->it_ref));
	}
	else {
		body_id = desc_tab[stype][Dtype(otop()->it_ref)][fid].info;
	}
	OLD_IC = IC;					/* IC back up */
	discard_breakpoints();			/* discard all breakpoints. We don't want to stop */ 
	debug_mode = 0; /* We don't want exceptions to be caught */

	excatch(&exenv);
	if (setjmp(exenv)) {
		RESTORE(op_stack,scur,stop);
		RESTORE(db_stack,dcur,dtop);
		dpop();
		RTLXE;
		debug_mode = saved_debug_mode;
		undiscard_breakpoints();
		IC = OLD_IC;
		d_data.db_callstack_depth = db_cstack;
		RTXSC;
		tagval = stagval;
		in_assertion = saved_assertion; /* Corresponds to RTED */
		exclear ();
		return NULL;
	}

	if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
		if (tagval != stagval)		/* Interpreted function called */
			sync_needed = 1;				/* Resynchronize registers */
	} else {
		/* The proper way to start the interpretation of a melted feature is to call `xinterp' 
		 * in order to initialize the calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to resynchronize the registers anyway.
		 */
		xinterp(MTC melt[body_id]);
		sync_needed = 1;					/* Compulsory synchronisation */
		}
	if (otop()!=previous_otop) {/* a result has been pushed on the stack */
		result = opop(); 
		type = result->type & SK_HEAD;
		if ((type == SK_EXP || type == SK_REF) && (result->it_ref != NULL))
			result->type = type | Dtype(result->it_ref);

	}

	expop(&eif_stack);
	dpop();
	debug_mode = saved_debug_mode;
	
	/* restore operational stack if needed */
	if (sync_needed==1 && previous_scur!=NULL && previous_stop!=NULL)
		sync_registers(previous_scur, previous_stop); 

	undiscard_breakpoints();		/* restore previous state. */
	d_data.db_callstack_depth = db_cstack;
	IC = OLD_IC;					/* Restore IC back-up */
	return result;
}

rt_private int icall(int fid, int stype, int ptype)
						/* Feature ID */
						/* Static type (entity where feature is applied) */
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
	int32 rout_id;
	

	rout_id = Routids(stype)[fid];

	if (ptype == -1) {
		CBodyId(body_id,rout_id,Dtype(otop()->it_ref));
	} else {
		CBodyId(body_id,rout_id,RTUD(ptype));
	}

	OLD_IC = IC;				/* IC back up */
	if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
		if (tagval != stagval)		/* Interpreted function called */
			result = 1;				/* Resynchronize registers */
	} else {
		/*IC = melt[body_id];*/					/* Melted byte code */
		/*interpret(INTERP_CMPD, 0);*/		/* Interpret (tagval not set) */

		/* The proper way to start the interpretation of a melted
		 * feature is to call `xinterp' in order to initialize the
		 * calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to 
		 * resynchronize the registers anyway. --ericb
		 */
		xinterp(MTC melt[body_id]);
	
		result = 1;							/* Compulsory synchronisation */
	}
	IC = OLD_IC;					/* Restore IC back-up */
	return result;
}

rt_private int ipcall(int32 origin, int32 offset, int ptype)
						/* Origin class ID of the feature.*/
						/* offset of the feature in the origin class */
						/* Is it an external or an Eiffel feature */
						/* Type of precursor, if any */
{
	/* This is the interpreter dispatcher for precompiled routine calls.
	 * Depending on the routine's temperature, the snow version (i.e. C code)
	 * is called and the result, if any, is left on the operational stack.
	 * The I->C pattern is called to push the parameters on the "C stack"
	 * correctly. Otherwise, the interpreter is called. The function returns
	 * 1 to the caller if a resynchronization of registers is needed.
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	BODY_INDEX body_id;					/* Value of selected body ID */
	unsigned long stagval = tagval;	/* Save tag value */
	unsigned char *OLD_IC;					/* IC back-up */
	int result = 0;					/* A priori, no need for sync_registers */
	uint32 pid;						/* Pattern id of the frozen feature */

	if (ptype == -1)
		body_id = desc_tab[origin][Dtype(otop()->it_ref)][offset].info;
	else
		body_id = desc_tab[origin][RTUD(ptype)][offset].info;

	OLD_IC = IC;				/* IC back up */
	if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
		if (tagval != stagval)		/* Interpreted function called */
			result = 1;				/* Resynchronize registers */
	} else {
		/*IC = melt[body_id];	*/				/* Melted byte code */
		/*interpret(INTERP_CMPD, 0);	*/	/* Interpret (tagval not set) */

		/* The proper way to start the interpretation of a melted
		 * feature is to call `xinterp' in order to initialize the
		 * calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to 
		 * resynchronize the registers anyway. --ericb
		 */
		xinterp(MTC melt[body_id]);
	
		result = 1;							/* Compulsory synchronisation */
	}
	IC = OLD_IC;					/* Restore IC back-up */
	return result;
}

rt_private void interp_access(int fid, int stype, uint32 type)
						/* Feature ID */
		  				/* Static type (entity where feature is applied) */
						/* Get attribute meta-type */
{
	/* Fetch the attribute value of feature identified by 'fid', in the
	 * static type context 'stype', with Current being place on top of the
	 * operational stack. The value of Current is removed and the value of the
	 * attribute replace it on the stack.
	 */

	EIF_REFERENCE current;							/* Current object */
	/* struct ac_info *attrinfo;*/ /* Call info for attribute */ /* %%ss removed */
	struct item *last;						/* Value on top of the stack */
	long offset;							/* Attribute offset */

	last = otop();
	current = last->it_ref;
	offset = RTWA(stype, fid, Dtype(current));
	last->type = type;			/* Store type of accessed attribute */
	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR: last->it_char = *(current + offset); break;
	case SK_WCHAR: last->it_wchar = *(EIF_WIDE_CHAR *) (current + offset); break;
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
	case SK_BIT: last->it_bit = (current + offset); break;
	case SK_POINTER: last->it_ptr = *(EIF_POINTER *) (current + offset); break;
	case SK_REF: last->it_ref = *(EIF_REFERENCE *) (current + offset); break;
	case SK_EXP: last->it_ref = (current + offset); break;
	default:
		eif_panic(MTC "unknown attribute type");
		/* NOTREACHED */
	}
}

rt_private void interp_paccess(int32 origin, int32 f_offset, uint32 type)
			 			/* Origin class ID of the attribute.*/
			   			/* offset of the feature in the origin class */
						/* Get attribute meta-type */
{
	/* Fetch the attribute value of offset 'offset' in the origin class
	 * 'origin', with Current being place on top of the operational stack.
	 * The value of Current is removed and the value of the attribute
	 * replace it on the stack.
	 */

	EIF_REFERENCE current;							/* Current object */
	/* struct ac_info *attrinfo; */	/* Call info for attribute */ /* %%ss removed */
	struct item *last;						/* Value on top of the stack */
	long offset;							/* Attribute offset */

	last = otop();
	current = last->it_ref;
	offset = RTWPA(origin, f_offset, Dtype(current));
	last->type = type;			/* Store type of accessed attribute */
	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR: last->it_char = *(current + offset); break;
	case SK_WCHAR: last->it_wchar = *(EIF_WIDE_CHAR *) (current + offset); break;
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
	case SK_BIT: last->it_bit = (current + offset); break;
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
	
	RT_GET_CONTEXT
	struct item *last;				/* Value on top of the stack */
	EIF_REFERENCE ref;

	last = opop();					/* Value to be assigned */

		/* FIXME: Manu 02/17/2004: For Bit types, the generated code is incorrect
		 * because we can assign BIT type into BIT_REF therefore there is a mismatch
		 * in the type, one is a reference, the other is a BIT, thus the extra 2 lines
		 * in the check. */
	CHECK("Target same type as source",
			((last->type & SK_HEAD) == (type & SK_HEAD)) ||
			(((last->type & SK_HEAD) == SK_BIT) && ((type & SK_HEAD) == SK_REF)) ||
			(((last->type & SK_HEAD) == SK_REF) && ((type & SK_HEAD) == SK_BIT)));

#define l last
#define i icurrent

	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR: *(i->it_ref + offset) = l->it_char; break;
	case SK_WCHAR: *(EIF_WIDE_CHAR *) (i->it_ref + offset) = l->it_wchar; break;
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
	case SK_BIT: b_copy(l->it_bit, i->it_ref + offset); break;
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

rt_shared void call_disp(uint32 dtype, EIF_REFERENCE object)
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

rt_private void address(int32 fid, int stype, int for_rout_obj)
						/* Feature ID */
						/* Static type (entity where feature is applied) */
						/* Do we need it for a routine object? */
{
	/* Get the address of a routine identified by 'fid', in the static type
	 * context 'stype', with Current being place on top of the operational
	 * stack. The value of Current is removed and replaced with the address.
	 */

	struct item *last;				/* Built melted routine address */

	last = iget();
	last->type = SK_POINTER;

	if (for_rout_obj)
		last->it_ptr = (EIF_POINTER) RTWPPR(stype, fid);
	else
		last->it_ptr = (EIF_POINTER) RTWPP(stype, fid);
}

rt_private short get_compound_id(EIF_REFERENCE Current, short dtype)
{
	/* Get array of short ints and convert it to a compound id. */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	int16   gen_types [MAX_CID_SIZE+1], *gp, last;
	int     cnt, pos;

	gp  = gen_types;
	cnt = 0;

	do
	{
		*(gp++) = last = (int16) get_int16(&IC);
		++cnt;

		/* Check for anchors */

		switch (last)
		{
			case LIKE_ARG_TYPE: /* like argument */
						pos = (int) get_int16(&IC);
						*(gp - 1) = RTID(RTCA(arg(pos)->it_ref, -10));
						break;
			case LIKE_CURRENT_TYPE: /* like Current */
						*(gp - 1) = RTID((icur_dftype));
						break;
			case LIKE_PFEATURE_TYPE: /* like feature - see BC_PCLIKE */
						{
							short stype;
							int32 origin, ooffset;

							stype = get_int16(&IC);			/* Get static type of caller */
							origin = get_int32(&IC);			/* Get the origin class id */
							ooffset = get_int32(&IC);			/* Get the offset in origin */
							*(gp - 1) = RTID(RTWPCT(stype, origin, ooffset, icurrent->it_ref));
						}
						break;
			case LIKE_FEATURE_TYPE: /* like feature - see BC_CLIKE */
						{
							short code;
							long  offset;

							code = get_int16(&IC);		/* Get the static type first */
							offset = get_int32(&IC);	/* Get the feature id of the anchor */
							*(gp - 1) = RTID(RTWCT(code, offset, icurrent->it_ref));
						}
						break;
			default:
						break;
		}

		if (cnt >= MAX_CID_SIZE)
			eif_panic(MTC "Too many generic parameters in compound type");

	} while (last != -1);

	/* If not generic then return dtype */

	if (cnt <= 2)
		return dtype;
	
	return (short) eif_compound_id((int16 *)0, (int16) Dftype (Current), (int16) dtype, gen_types);
}

rt_private int get_creation_type (void)
{
	EIF_GET_CONTEXT
	RT_GET_CONTEXT
	int type;			/* Often used to hold type values */
	int code;			/* Current intepreted byte code */
	long offset;		/* Offset for jumps and al */
	
	switch (*IC++) {
	case BC_CTYPE:				/* Hardcoded creation type */
		type = get_int16(&IC);
/* GENERIC CONFORMANCE */
		type = get_compound_id(MTC icurrent->it_ref,(short)type);
		break;
	case BC_CARG:				/* Like argument creation type */
		if (*IC++ == BC_GEN_PARAM_CREATE) {
				/* Anchor is based on a formal generic parameter. */
			short current_type;
			int32 formal_position;

			current_type = get_int16(&IC);		/* Get static type of caller */
			formal_position = get_int32(&IC);	/* Get position of formal generic
											   we want to create */
			type = (int) RTGPTID(current_type, icurrent->it_ref, formal_position);
		} else {
				/* Anchor is based on a class type. */
			type = get_int16(&IC);		/* Default creation type if void arg.  */
			type = get_compound_id(MTC icurrent->it_ref,(short)type);
		}	
		code = get_int16(&IC);		/* Argument position */
		type = RTCA(arg(code)->it_ref, type);
		break;
	case BC_CLIKE:				/* Like feature creation type */
		code = get_int16(&IC);		/* Get the static type first */
		offset = get_int32(&IC);	/* Get the feature id of the anchor */
/* GENERIC CONFORMANCE */
		type = RTWCT(code, offset, icurrent->it_ref);
		break;
	case BC_PCLIKE:				/* Like feature creation type */
		{
		short stype;
		int32 origin, ooffset;

		stype = get_int16(&IC);			/* Get static type of caller */
		origin = get_int32(&IC);			/* Get the origin class id */
		ooffset = get_int32(&IC);			/* Get the offset in origin */
/* GENERIC CONFORMANCE */
		type = RTWPCT(stype, origin, ooffset, icurrent->it_ref);
		break;
		}
	case BC_CCUR:				/* Like Current creation type */
		type = icur_dftype;
		break;
	case BC_GEN_PARAM_CREATE:
		{
		short current_type;
		int32 formal_position;

		current_type = get_int16(&IC);		/* Get static type of caller */
		formal_position = get_int32(&IC);	/* Get position of formal generic
										   we want to create */
		type = (int) RTGPTID(current_type, icurrent->it_ref, formal_position);
		}
		break;
	default:
		type = 0;	/* To avoid C compiler warning */
		eif_panic(MTC "creation type lost");
		/* NOTREACHED */
	}

	return type;
}

/*
 * Calling protocol
 */

rt_private void init_var(struct item *ptr, long int type, EIF_REFERENCE current_ref)
{
	EIF_GET_CONTEXT

	/* Initializes variable 'ptr' to be of type 'type' */
	short dtype;

	ptr->type = type;					/* Set to correct type */

	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR:		ptr->it_char = (EIF_CHARACTER) 0; break;
	case SK_WCHAR:		ptr->it_wchar = (EIF_WIDE_CHAR) 0; break;
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
	case SK_BIT:		ptr->it_ref = (EIF_REFERENCE)0; break;
	case SK_EXP:		dtype = get_int16(&IC);
						dtype = get_compound_id(MTC current_ref, (short) dtype);
						ptr->type = (type & EO_UPPER) | ((uint32) dtype);
						ptr->it_ref = (EIF_REFERENCE) 0;
						break;
	case SK_REF:		ptr->it_ref = (EIF_REFERENCE) 0; break;
	case SK_POINTER:	ptr->it_ptr = (EIF_POINTER) 0; break;
	case SK_VOID:		break;
	default:			eif_panic(MTC RT_UNKNOWN_TYPE_MSG);
	}
}

rt_private void put_once_result (struct item *ptr, long int rtype, MTOT OResult)
{
	switch (rtype & SK_HEAD) 
	{
	case SK_BOOL:    MTOP(EIF_BOOLEAN,    OResult, ptr->it_char);   break;
	case SK_CHAR:    MTOP(EIF_CHARACTER,  OResult, ptr->it_char);   break;
	case SK_WCHAR:   MTOP(EIF_WIDE_CHAR,  OResult, ptr->it_wchar);  break;
	case SK_UINT8:   MTOP(EIF_NATURAL_8,  OResult, ptr->it_uint8);  break;
	case SK_UINT16:  MTOP(EIF_NATURAL_16, OResult, ptr->it_uint16); break;
	case SK_UINT32:  MTOP(EIF_NATURAL_32, OResult, ptr->it_uint32); break;
	case SK_UINT64:  MTOP(EIF_NATURAL_64, OResult, ptr->it_uint64); break;
	case SK_INT8:    MTOP(EIF_INTEGER_8,  OResult, ptr->it_int8);   break;
	case SK_INT16:   MTOP(EIF_INTEGER_16, OResult, ptr->it_int16);  break;
	case SK_INT32:   MTOP(EIF_INTEGER_32, OResult, ptr->it_int32);  break;
	case SK_INT64:   MTOP(EIF_INTEGER_64, OResult, ptr->it_int64);  break;
	case SK_REAL32:  MTOP(EIF_REAL_32,    OResult, ptr->it_real32); break;
	case SK_REAL64:  MTOP(EIF_REAL_64,    OResult, ptr->it_real64); break;
	case SK_POINTER: MTOP(EIF_POINTER,    OResult, ptr->it_ptr);    break;
	case SK_BIT:
	case SK_EXP:
	case SK_REF:
		*(OResult->result.EIF_REFERENCE_result) = ptr->it_ref; break;
	}
}

rt_private void get_once_result (MTOT OResult, long int rtype, struct item *ptr)
{
	switch (rtype & SK_HEAD) 
	{
	case SK_BOOL:
	case SK_CHAR:    ptr->it_char   = MTOR(EIF_CHARACTER,  OResult); break;
	case SK_WCHAR:   ptr->it_wchar  = MTOR(EIF_WIDE_CHAR,  OResult); break;
	case SK_UINT8:   ptr->it_uint8  = MTOR(EIF_NATURAL_8,  OResult); break;
	case SK_UINT16:  ptr->it_uint16 = MTOR(EIF_NATURAL_16, OResult); break;
	case SK_UINT32:  ptr->it_uint32 = MTOR(EIF_NATURAL_32, OResult); break;
	case SK_UINT64:  ptr->it_uint64 = MTOR(EIF_NATURAL_64, OResult); break;
	case SK_INT8:    ptr->it_int8   = MTOR(EIF_INTEGER_8,  OResult); break;
	case SK_INT16:   ptr->it_int16  = MTOR(EIF_INTEGER_16, OResult); break;
	case SK_INT32:   ptr->it_int32  = MTOR(EIF_INTEGER_32, OResult); break;
	case SK_INT64:   ptr->it_int64  = MTOR(EIF_INTEGER_64, OResult); break;
	case SK_REAL32:  ptr->it_real32 = MTOR(EIF_REAL_32,    OResult); break;
	case SK_REAL64:  ptr->it_real64 = MTOR(EIF_REAL_64,    OResult); break;
	case SK_POINTER: ptr->it_ptr    = MTOR(EIF_POINTER,    OResult); break;
	case SK_BIT:
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
	struct item **reg;	/* Pointer in register array */
	struct item *last;	/* Initialization of stack frame */
	struct opstack op_context;		/* To save stack's context */
	EIF_REFERENCE current;					/* Saved value of current */

	allocate_registers(MTC);			/* Make sure array is big enough */

	current = opop()->it_ref;		/* Save value of current */

	/* Upon entry in the routine, all the arguments were pushed in reverse
	 * order, followed by the value of Current. In order to initialize the
	 * interpreter's registers, we need to walk backwards through the stack,
	 * after having saved the stack context.
	 */

	memcpy (&op_context, &op_stack, sizeof(struct opstack));

	reg = iregs + SPECIAL_REG + locnum + argnum - 1; /* Start of arguments */
	for (n = 0; n < argnum; n++, reg--)		/* Pushed in reverse order */
		*reg = opop();						/* Get its address */

	memcpy (&op_stack, &op_context, sizeof(struct opstack));

	/* Now loop and fetch the local variables type directly from the byte
	 * code. Put them on the stack and record the address of each of them in
	 * the register's array. All variables are initialized to zero.
	 */

	reg = iregs + SPECIAL_REG;				/* Start of locals */
	for (n = 0; n < locnum; n++, reg++) {	/* Pushed in order */
		last = iget();
		init_var(last, get_int32(&IC), current);			/* Initialize to zero */
		*reg = last;						/* Save pointer in stack */
	}

	/* Now what do we have on the stack? If we walk backwards, we first have
	 * the locals, in reverse order, then the arguments in order. Push back on
	 * the top the value of current, then initialize a Result (made of type
	 * long so that no traversal is made by the GC--we don't know the feature's
	 * type yet anyway), then the number of locals and arguments.
	 */

	icurrent = last = iget(); 		/* Get room for Current */
	last->type = SK_REF;			/* Current is a reference */
	last->it_ref = current;			/* Restore saved value */

	iresult = last = iget();		/* Get room for Result */
	last->type = SK_INT32;			/* By default, avoid GC traversal */

	ilocnum = last= iget();			/* Push # of locals */
	last->type = SK_UINT32;			/* Initializes record */
	last->it_uint32 = locnum;			/* Got this from byte code */

	iargnum = last = iget();		/* Push # of arguments */
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
	int size;				/* Size of iregs array */
	struct item **new;	/* New location for array extension */

	size = nbregs * ITEM_SZ;				/* The size it should have */
	if (size > iregsz) {					/* The array is not big enough */
		new = (struct item **) crealloc((char *)iregs, size);
		if (new == (struct item **) 0)		/* No room for extension */
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
			new = (struct item **) crealloc((char *)iregs, size);
			if (new == (struct item **) 0)	/* Paranoid (can't happen?) */
				enomem(MTC_NOARG);				/* This is a critical exception */
			iregsz = size;				/* Array has shrinked */
			bigger = 0;					/* Reset overhead counter */
			iregs = new;
		}
	}
}

rt_shared void sync_registers(struct stochunk *stack_cur, struct item *stack_top)
						   		/* Saved current chunk of op stack */
					   			/* Saved top of op stack */
{
	/* Whenever an interpreted function is called, the register array is
	 * reset to match registers for the new function. When we regain control
	 * in the original function, we have to re-synchronize the array.
	 * This is rather a slow routine, because it makes lots ot otop() and
	 * opop() calls--RAM.
	 */

	RT_GET_CONTEXT
	uint32 n;				/* Loop index */
	struct item **reg;	/* Address in register's array */
	struct opstack op_context;		/* To save stack's context */
	
	memcpy (&op_context, &op_stack, sizeof(struct opstack));

	/* Restore the context the stack was in just after we had initialized the
	 * registers upon routine entrance (calling protocol).
	 */
	op_stack.st_cur = stack_cur;			/* Restore stack context */
	op_stack.st_top = stack_top;			/* Saved top */
	op_stack.st_end = stack_cur->sk_end;	/* End of current chunk */

	/* The stack is now in the state it had right after the initial settings.
	 * Start by filling in the special registers (appear in reverse order).
	 */
	for (n = 0, reg = iregs + SPECIAL_REG - 1; n < SPECIAL_REG; n++, reg--) {
		*reg = opop();
		(*reg)->it_addr = &((*reg)->itu); /* synchronize the address of the value with its location */
	}

	locnum = ilocnum->it_uint32;		/* # of local variables */
	argnum = iargnum->it_uint32;		/* # of arguments */
	allocate_registers(MTC);		/* `iregs' could have been reduced */

	/* Local variables also appear in reverse order */
	for (n = 0, reg = iregs+locnum+SPECIAL_REG-1; n < locnum; n++, reg--) {
		*reg = opop();
		(*reg)->it_addr = &((*reg)->itu); /* synchronize the address of the value with its location */
	}

	/* Finally, arguments appear in reverse order */
	for (n = 0, reg = iregs+locnum+SPECIAL_REG+argnum-1; n < argnum; n++, reg--) {
		*reg = opop();
		(*reg)->it_addr = &((*reg)->itu); /* synchronize the address of the value with its location */
	}

	memcpy (&op_stack, &op_context, sizeof(struct opstack));

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
	int nb_items;			/* Number of registers to be popped off */
	struct item *result;			/* To save the result */
	struct item saved_result;		/* Save value pointed to by iresult */
	
	nb_items = opop()->it_int32;		/* This is the nummber of arguments */
	nb_items += otop()->it_int32;	/* Add the number of locals */
	nb_items += SPECIAL_REG - 1;	/* Add Current, Result and ilocnum */

	/* Using npop() may truncate the unused chunks at the tail of the stack,
	 * which may free the chunk where results is stored if there where a lot
	 * of local variables, for instance. This means we must save the possible
	 * register value before popping items.
	 */
	memcpy (&saved_result, iresult, ITEM_SZ);

	npop(nb_items);			/* Remove items and eventually shrink stack */

	if (saved_result.type != SK_VOID) {	/* If Result is needed */
		result = iget();				/* Get a new result record */
		memcpy (result, &saved_result, ITEM_SZ);
	}
}


/* Initialize expanded locals and result (if required) */
rt_private void create_expanded_locals (
	struct stochunk * scur,		/* Current chunk (stack context) */
	struct item * stop			/* To save stack context */
)
{
	RT_GET_CONTEXT
	uint32 i;
	struct item * last;	/* Last pushed value */
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
			last->it_ref = RTLX(type & SK_DTYPE);
			last->type = SK_EXP;
			if (tagval != stagval)
				sync_registers(MTC scur, stop);
			break;
		case SK_BIT:
			stagval = tagval;
			last->type = SK_POINTER;	/* GC: wait for malloc */
			last->it_bit = RTLB(type & SK_BMASK);
			last->type = SK_BIT;
			if (tagval != stagval)
				sync_registers(MTC scur, stop);
			break;
		}							
	}
	last = iresult;
	type = last->type;
	switch (type & SK_HEAD) {
	case SK_EXP:
		stagval = tagval;
		last->type = SK_POINTER;		/* For GC */
		last->it_ref = RTLX(type & SK_DTYPE);	
		last->type = SK_EXP;
		if (tagval != stagval)
			sync_registers(MTC scur, stop);
		break;
	case SK_BIT:
		stagval = tagval;
		last->type = SK_POINTER;    /* GC: wait for malloc */
		last->it_bit = RTLB(type & SK_BMASK);
		last->type = SK_BIT;
		if (tagval != stagval)
			sync_registers(MTC scur, stop);
		break;
	}
}


/*
 * Operational stack handling.
 */

rt_private struct item *stack_allocate(register int size)
				   					/* Initial size */
{
	/* The operational stack is created, with size 'size'.
	 * Return the arena value (bottom of stack).
	 */

	RT_GET_CONTEXT
	struct item *arena;		/* Address for the arena */
	struct stochunk *chunk;	/* Address of the chunk */

	size *= ITEM_SZ;
	size += sizeof(*chunk);
	chunk = (struct stochunk *) cmalloc(size);
	if (chunk == (struct stochunk *) 0)
		return (struct item *) 0;		/* Malloc failed for some reason */

	op_stack.st_hd = chunk;						/* New stack (head of list) */
	op_stack.st_tl = chunk;						/* One chunk for now */
	op_stack.st_cur = chunk;					/* Current chunk */
	arena = (struct item *) (chunk + 1);		/* Header of chunk */
	op_stack.st_top = arena;					/* Empty stack */
	chunk->sk_arena = arena;					/* Base address */
	op_stack.st_end = chunk->sk_end = (struct item *)
		((char *) chunk + size);		/* First free location beyond stack */
	chunk->sk_next = (struct stochunk *) 0;
	chunk->sk_prev = (struct stochunk *) 0;

	return arena;			/* Stack allocated */
}

/* Stack handling routine. The following code has been cut/paste from the one
 * found in garcol.c and local.c as of this day. Hence the similarities and the
 * possible differences. What changes basically is that instead of storing
 * (char *) elements, we now store (struct item) ones.
 */

rt_public struct item *opush(register struct item *val)
{
	/* Push value 'val' on top of the operational stack. If it fails, raise
	 * an "Out of memory" exception. If 'val' is a null pointer, simply
	 * get a new cell at the top of the stack.
	 */
	RT_GET_CONTEXT
	struct item *top = op_stack.st_top;	/* Top of stack */
	
	if (top == (struct item *) 0)	{			/* No stack yet? */
		top = stack_allocate(eif_stack_chunk);		/* Create one */
		if (top == (struct item *) 0)	 		/* Could not create stack */
			enomem(MTC_NOARG);							/* No more memory */
	}

	if (op_stack.st_end == top) {
		/* The end of the current stack chunk has been reached. If there is
		 * a chunk allocated after the current one, use it, otherwise create
		 * a new one and insert it in the list.
		 */
		SIGBLOCK;									/* Critical section */
		if (op_stack.st_cur == op_stack.st_tl) {	/* Reached last chunk */
			if (-1 == stack_extend(eif_stack_chunk))
				enomem(MTC_NOARG);
			top = op_stack.st_top;					/* New top */
		} else {
			struct stochunk *current;		/* New current chunk */

			/* Update the new stack context (main structure) */
			current = op_stack.st_cur = op_stack.st_cur->sk_next;
			top = op_stack.st_top = current->sk_arena;
			op_stack.st_end = current->sk_end;
		}
		SIGRESUME;				/* Restore signal handling */
	}

	op_stack.st_top = top + 1;			/* Points to next free location */
	if (val != (struct item *) 0)		/* If value was provided */
		memcpy (top, val, ITEM_SZ);		/* Push it on the stack */

	return top;				/* Address of allocated item */
}

rt_private int stack_extend(register int size)
				   					/* Size of new chunk to be added */
{
	/* The operational stack is extended and the stack structure is updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */
	RT_GET_CONTEXT
	struct item *arena;		/* Address for the arena */
	struct stochunk *chunk;	/* Address of the chunk */

	size *= ITEM_SZ;
	size += sizeof(*chunk);
	chunk = (struct stochunk *) cmalloc(size);
	if (chunk == (struct stochunk *) 0)
		return -1;		/* Malloc failed for some reason */

	SIGBLOCK;									/* Critical section */
	arena = (struct item *) (chunk + 1);		/* Header of chunk */
	chunk->sk_next = (struct stochunk *) 0;		/* Last chunk in list */
	chunk->sk_prev = op_stack.st_tl;			/* Preceded by the old tail */
	op_stack.st_tl->sk_next = chunk;			/* Maintain link w/previous */
	op_stack.st_tl = chunk;						/* New tail */
	chunk->sk_arena = arena;					/* Where items are stored */
	chunk->sk_end = (struct item *)
		((char *) chunk + size);				/* First item beyond chunk */
	op_stack.st_top = arena;					/* New top */
	op_stack.st_end = chunk->sk_end;			/* End of current chunk */
	op_stack.st_cur = chunk;					/* New current chunk */
	SIGRESUME;									/* Restore signal handling */

	return 0;			/* Everything is ok */
}

rt_public struct item *opop(void)
{
	/* Removes one item from the operational stack and return a pointer to
	 * the removed item, which also happens to be the first free location.
	 */
	RT_GET_CONTEXT
	struct item *top = op_stack.st_top;	/* Top of the stack */
	struct stochunk *s;			/* To walk through stack chunks */
	struct item *arena;			/* Base address of current chunk */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. This avoids pointer manipulation (walking along the stack)
	 * which may induce swapping, who knows?
	 */

	arena = op_stack.st_cur->sk_arena;
	if (--top >= arena) {			/* Hopefully, we remain in current chunk */
		op_stack.st_top = top;		/* Yes! Update top */
		return top;					/* Done, we're lucky */
	}

	/* Unusual case: top is just in the first place of next chunk */

	SIGBLOCK;
	s = op_stack.st_cur = op_stack.st_cur->sk_prev;

#ifdef MAY_PANIC
	if (s == (struct stochunk *) 0)
		eif_panic("operational stack underflow");
#endif

	top = op_stack.st_end = s->sk_end;
	op_stack.st_top = --top;
	SIGRESUME;

	return op_stack.st_top;
}

rt_private void npop(register int nb_items)
{
	/* Removes 'nb_items' from the operational stack. Occasionaly, we also
	 * try to truncate the unused chunks from the tail of the stack. We do
	 * not do that in opop() because that would create an overhead...
	 */
	RT_GET_CONTEXT
	struct item *top;			/* Current top of operational stack */
	struct stochunk *s;		/* To walk through stack chunks */
	struct item *arena;		/* Base address of current chunk */
	rt_int_ptr nb = nb_items;

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. That would indeed make popping very efficient.
	 */

	arena = op_stack.st_cur->sk_arena;
	top = op_stack.st_top;
	top -= nb;				/* Hopefully, we remain in current chunk */
	if (top >= arena) {
		op_stack.st_top = top;		/* Yes! Update top */
		return;						/* Done, how lucky we were! */
	}

	/* Normal case (which should be reasonably rare): we have to pop more
	 * than the number of items in the current chunk. Loop until we popped
	 * enough items (one iteration should be the norm).
	 */

	SIGBLOCK;			/* Entering protected section */

	top = op_stack.st_top;
	for (s = op_stack.st_cur; nb > 0; /* empty */) {
		arena = s->sk_arena;
		nb -= top - arena;
		if (nb <= 0) {			/* Have we gone too far? */
			top = arena - nb;		/* Yes, reset top correctly */
			break;						/* Done */
		}
		s = s->sk_prev;					/* Look at previous chunk */
		if (s)
			top = s->sk_end;			/* Top at the end of previous chunk */
		else
			break;						/* We reached the bottom */
	}
		
#ifdef MAY_PANIC
	/* Consistency check: we cannot have reached the end of the stack */
	if (s == (struct stochunk *) 0)
		eif_panic("operational stack underflow");
#endif

	/* Update the stack structure */
	op_stack.st_cur = s;
	op_stack.st_top = top;
	op_stack.st_end = s->sk_end;

	SIGRESUME;						/* End of protected section */

	/* There is not much overhead calling stack_truncate(), because this is
	 * only done when we are popping at a chunk edge. We have to make sure the
	 * program is running though, as popping done in debugging mode is only
	 * temporary--RAM.
	 */

	if (d_cxt.pg_status == PG_RUN)	/* Program is running */
		stack_truncate();			/* Eventually remove unused chunks */
}

rt_public struct item *otop(void)
	{
	/* Returns a pointer to the top of the stack or a NULL pointer if
	 * stack is empty. I assume a value has already been pushed (i.e. the
	 * stack has been created).
	 */
	
	RT_GET_CONTEXT
	struct item *last_item;		/* Address of last item stored */
	struct stochunk *prev;		/* Previous chunk in stack */

	if (op_stack.st_top==NULL)
		return NULL;

	last_item = op_stack.st_top - 1;
	if (last_item >= op_stack.st_cur->sk_arena)
		return last_item;
	
	/* It seems the current top of the stack (i.e. the next free location)
	 * is at the left edge of a chunk. Look for previous chunk then...
	 */
	prev = op_stack.st_cur->sk_prev;

	if (prev == NULL)
		return NULL;
	else
		return prev->sk_end - 1;			/* Last item of previous chunk */
	}

rt_private struct item *oitem(uint32 n)
	{
	/* Returns a pointer to the item at position `n' down the stack or a NULL pointer if */ 
	/* stack is empty. It assumes a value has already been pushed (i.e. the stack has been created). */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	struct item		*access_item;	/* Address of item we try to access */
	struct stochunk	*prev;			/* Previous chunk in stack */
	struct stochunk	*curr;			/* Current chunk in stack */

	access_item = (op_stack.st_top - 1 - n);
	if (access_item >= (op_stack.st_cur->sk_arena))
		return access_item;

	/* It seems the item is at the left edge of a chunk. Look for previous chunk then... */
	prev = cop_stack.st_cur;

	do
		{
		/* Item is not in the current chunk. Let's see if it's not in the previous one */
		curr = prev;
		prev = prev->sk_prev;

		if (prev == NULL)
			return NULL; /* operational stack is empty, we return NULL */
		access_item = prev->sk_end - (curr->sk_arena - access_item);
		}
	while (access_item < prev->sk_arena);
		
	return access_item;
	}

rt_private void stack_truncate(void)
	{
	/* Free unused chunks in the stack. If the current chunk has at least
	 * MIN_FREE locations, then we may free all the chunks starting with the
	 * next one. Otherwise, we skip the next chunk and free the remainder.
	 */

	RT_GET_CONTEXT
	struct item *top;		/* The current top of the stack */
	struct stochunk *next;			/* Address of next chunk */

	/* We know the program is running, because this function is only called
	 * via npop(), and npop() cannot be called by the debugger--RAM.
	 */

	top = op_stack.st_top;						/* The first free location */
	if (op_stack.st_end - top > MIN_FREE) {		/* Enough locations left */
		op_stack.st_tl = op_stack.st_cur;		/* Last chunk from now on */
		wipe_out(op_stack.st_cur->sk_next);		/* Free starting at next chunk */
	} else {									/* Current chunk is nearly full */
		next = op_stack.st_cur->sk_next;		/* We are followed by 'next' */
		if (next != (struct stochunk *) 0) {	/* There is indeed a next chunk */
			op_stack.st_tl = next;			/* New tail chunk */
			wipe_out(next->sk_next);		/* Skip it, wipe out remainder */
		}
	}

	}

rt_private void wipe_out(register struct stochunk *chunk)
			/* First chunk to be freed */
	{
	/* Free all the chunks after 'chunk' */

	struct stochunk *next;	/* Address of next chunk */

	if (chunk == (struct stochunk *) 0)	/* No chunk */
		return;							/* Nothing to be done */

	chunk->sk_prev->sk_next = (struct stochunk *) 0;	/* Previous is last */

	for (
			next = chunk->sk_next; 
			chunk != (struct stochunk *) 0; 
			chunk = next, next = chunk ? chunk->sk_next : chunk
	)
		eif_rt_xfree((EIF_REFERENCE) chunk);
	}

rt_shared void opstack_reset(struct opstack *stk)
{
	/* Reset the stack 'stk' to its minimal state and disgard all its
	 * contents. Walking through the list of chunks, we free them and
	 * clear the 'stk' structure.
	 */

	struct stochunk *k;	/* To walk through the list */
	struct stochunk *n;	/* Save next before freeing chunk */

	for (k = stk->st_hd; k; k = n) {
		n = k->sk_next;		/* This is not necessary given current eif_rt_xfree() */
		eif_rt_xfree((EIF_REFERENCE) k);
	}

	memset (stk, 0, sizeof(struct opstack));
}

/*
 * For debugger: getting values of locals, arguments, Result and Current.
 */

/* VARARGS1 */
rt_public struct item *ivalue(int code, uint32 num, uint32 start)
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
	struct item 	*result_item = NULL;

	if (egc_frozen[exvect->ex_bodyid] == NULL) {
		/* if the feature is melted or super melted, 
		 * we look in the registers of the interpreter
		 */
		switch (code) {
		case IV_LOCAL:								/* Nth local */
			if (num > ilocnum->it_uint32)
				return (struct item *) 0;			/* Out of range */
			else if (num == ilocnum->it_uint32){		/* Off by one */
				if (iresult->type != SK_VOID)		/* If there is a result */
					return iresult;					/* Then return it */
				else
					return (struct item *) 0;		/* Else signal out of range */
			}
		return loc(num + 1);						/* Locals from 1 to ilocnum */

		case IV_ARG:								/* Nth argument */
			if (num >= iargnum->it_uint32)
				return (struct item *) 0;			/* Out of range */
			return arg(num + 1);					/* Arguments from 1 to iargnum */
			
		case IV_CURRENT:							/* Current */
			return icurrent;
			
		case IV_RESULT:								/* Result */
			return iresult;
				
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
				if (cresult->type != SK_VOID) {			/* If there is a result */
					result_item = cresult;				/* Then return it */
					break;
				} else {
					break;								/* Else signal out of range */
				}
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
		if (result_item != (struct item *)0) {
			switch (result_item->type & SK_HEAD) {
			case SK_BOOL:
			case SK_CHAR: result_item->it_char = *((EIF_CHARACTER *)(result_item->it_addr)); break;
			case SK_WCHAR: result_item->it_wchar = *((EIF_WIDE_CHAR *)(result_item->it_addr)); break;
			case SK_UINT8: result_item->it_uint8 = *((EIF_NATURAL_8 *)(result_item->it_addr)); break;
			case SK_UINT16: result_item->it_uint16 = *((EIF_NATURAL_16 *)(result_item->it_addr)); break;
			case SK_UINT32: result_item->it_uint32 = *((EIF_NATURAL_32 *)(result_item->it_addr)); break;
			case SK_UINT64: result_item->it_uint64 = *((EIF_NATURAL_64 *)(result_item->it_addr)); break;
			case SK_INT8: result_item->it_int8 = *((EIF_INTEGER_8 *)(result_item->it_addr)); break;
			case SK_INT16: result_item->it_int16 = *((EIF_INTEGER_16 *)(result_item->it_addr)); break;
			case SK_INT32: result_item->it_int32 = *((EIF_INTEGER_32 *)(result_item->it_addr)); break;
			case SK_INT64: result_item->it_int64 = *((EIF_INTEGER_64 *)(result_item->it_addr)); break;
			case SK_REAL32: result_item->it_real32 = *((EIF_REAL_32 *)(result_item->it_addr)); break;
			case SK_REAL64: result_item->it_real64 = *((EIF_REAL_64 *)(result_item->it_addr)); break;
			case SK_POINTER: result_item->it_ptr = *((EIF_POINTER *)(result_item->it_addr)); break;
			case SK_BIT: result_item->it_bit = *((EIF_REFERENCE *)(result_item->it_addr)); break;
			case SK_EXP:
			case SK_REF:
				result_item->it_ref = *((EIF_REFERENCE *)(result_item->it_addr)); break;
			case SK_VOID:
				/* nothing to do*/
				break;
			}
		}
	}
	return result_item;

	/* NOT REACHED */
}

/*
doc:</file>
*/
