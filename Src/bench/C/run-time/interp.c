/*

	#    #    #   #####  ######  #####   #####            ####
	#    ##   #     #    #       #    #  #    #          #    #
	#    # #  #     #    #####   #    #  #    #          #
	#    #  # #     #    #       #####   #####    ###    #
	#    #   ##     #    #       #   #   #        ###    #    #
	#    #    #     #    ######  #    #  #        ###     ####

	The Interpreter.
*/

#include "eif_project.h"
#include "eif_config.h"
#include "eif_portable.h"
#include "eif_interp.h"
#include "eif_malloc.h"
#include "eif_plug.h"
#include "eif_eiffel.h"
#include "eif_macros.h"
#include "eif_hashin.h"
#include "eif_cecil.h"
#include "eif_hector.h"
#include "eif_except.h"
#include "eif_local.h"
#include "eif_copy.h"
#include "eif_debug.h"
#include "eif_sig.h"
#include "eif_bits.h"
#include "eif_equal.h"	/* for xequal() */
#include <math.h>
#include "eif_main.h"
#include "eif_gen_conf.h"
#include "x2c.header"		/* For LNGPAD */

#ifdef CONCURRENT_EIFFEL
#include "eif_curextern.h"
#endif

/*#define SEP_DEBUG */  /**/
/*#define DEBUG 6 */	/**/
/*#define TEST */ /**/
#ifdef TEST
#include <stdio.h>
#endif

#define dprintf(n) if (DEBUG & n) printf

#undef STACK_CHUNK
#undef MIN_FREE
#define STACK_CHUNK		200			/* Number of items in a stack chunk */
#define MIN_FREE		40			/* Minimum free location to free chunk */
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
#define icurrent	(*iregs)					/* Value of Current */
#define iresult		(*(iregs+1))				/* Result of function */
#define ilocnum		(*(iregs+2))				/* Number of locals */
#define iargnum		(*(iregs+3))				/* Number of arguments */
#define loc(n)		(*(iregs+3+(n)))			/* Locals from 1 to locnum */
#define arg(n)		(*(iregs+3+locnum+(n)))		/* Arguments from 1 to argnum */
#define nbregs		(locnum+argnum+SPECIAL_REG)	/* Total # of registers */
#define icur_dtype	Dtype(icurrent->it_ref)		/* Dtype of current */
#define icur_dftype	Dftype(icurrent->it_ref)		/* Dftype of current */
/* Interpreter routine flag */
#define INTERP_CMPD 1			/* Interpretation of a compound */
#define INTERP_INVA	2			/* Interpretation of invariant */

/* Access to precursor type */

#define GET_PTYPE   (is_extern ? -1 : get_short ())

#ifndef EIF_THREADS

/* Operational stack. This is the stack used by the virtual stack machine,
 * in a reverse polish notation manner (RPN). All the operations defined
 * by the interpreter take their argument(s) from the stack and push the
 * result back onto the stack. Of course, optimizations are here to avoid
 * useless stack manipulations.
 */
rt_shared struct opstack op_stack = { /* %%ss mt */
	(struct stochunk *) 0,		/* st_hd */
	(struct stochunk *) 0,		/* st_tl */
	(struct stochunk *) 0,		/* st_cur */
	(struct item *) 0,			/* st_top */
	(struct item *) 0,			/* st_end */
};

/* The interpreter counter is the location in byte code of the next instruction
 * to be fetched. Its behaviour is similar to the one of PC in a central
 * processing unit.
 */
rt_public char *IC = (char *)0;	/* Interpreter Counter (like PC on a CPU) */ /* %%ss mt */

/* To speed-up access of the local parameters and variables, they are all
 * gathered in a separate array (automagically resized). The value of Current
 * comes first, then Result (whether it is needed or not), then all the
 * arguments (number held in global argnum) and then the locals (number held
 * in global locnum). They can be viewed as the interpreter's registers and
 * are saved/backed upon each call. The 'argnum' and 'locnum' are also part
 * of the interpreter's registers, but for faster access, they are copied
 * to C global vars--RAM.
 */
rt_private struct item **iregs = (struct item **) 0;	/* Interpreter registers */ /* %%ss mt */
rt_private int iregsz = 0;	/* Size of 'iregs' array (bytes) */ /* %%ss mt */
rt_private int argnum = 0;		/* Number of arguments */ /* %%ss mt */
rt_private int locnum = 0;		/* Number of locals */ /* %%ss mt */

/* To optimize registers resync, we keep track of a tag value which is updated
 * each time we enter in an interpreted routine. This gives us the ability to
 * know if other interpreted routines where called since we left a given
 * routine due to a function call. If none have been called, then the registers
 * have no reason to have changed.
 */
rt_private unsigned long tagval = 0L;	/* Records number of interpreter's call */ /* %%ss mt */
#endif /* EIF_THREADS */

/* Error message */
rt_private char *botched = "Operational stack botched";
rt_private char *unknown_type = "unknown entity type";

/* Monadic and diadic operator handling */
rt_private void monadic_op(int code);				/* Execute a monadic operation */
rt_private void diadic_op(int code);				/* Execute a diadic operation */

/* Assertion checking */
rt_private void icheck_inv(EIF_CONTEXT char *obj, struct stochunk *scur, struct item *stop, int where);				/* Invariant check */
rt_private void irecursive_chkinv(EIF_CONTEXT int dtype, char *obj, struct stochunk *scur, struct item *stop, int where);		/* Recursive invariant check */

/* Getting constants */
rt_private uint32 get_uint32(void);			/* Get an unsigned int32 */
rt_private double get_double(void);			/* Get a double constant */
rt_private float get_float(void);				/* Get a float constant */
rt_private long get_long(void);				/* Get a long constant */
rt_private short get_short(void);				/* Get a short constant */
rt_private fnptr get_fnptr(void);				/* Get a function pointer */
rt_private char *get_address(void);			/* Get an address */
rt_private short get_compound_id(EIF_CONTEXT char *obj, short dtype);			/* Get a compound type id */

/* Writing constants */
rt_private void write_long(char *where, long int value);				/* Write long constant */
rt_private void write_float(char *where, float value);				/* Write a float constant */
rt_private void write_double(char *where, double value);			/* Write a double constant */
rt_private void write_fnptr(char *where, fnptr value);				/* Write a function pointer constant */
rt_private void write_address(char *where, char *value);			/* Write an address constant */

/* Interpreter interface */
rt_public void exp_call();				/* Sets IC before calling interpret */ /* %%ss undefine */
rt_public void xinterp(EIF_CONTEXT char *icval);	/* Sets IC before calling interpret */
rt_public void xinitint(void);			/* Initialization of the interpreter */
rt_private void interpret(EIF_CONTEXT int flag, int where);	/* Run the interpreter */

/* Feature call and/or access  */
rt_private int icall(EIF_CONTEXT int fid, int stype, int is_extern, int ptype);					/* Interpreter dispatcher (in water) */
rt_private int ipcall(EIF_CONTEXT int32 origin, int32 offset, int is_extern, int ptype);					/* Interpreter precomp dispatcher */
rt_private void interp_access(int fid, int stype, uint32 type);			/* Access to an attribute */
rt_private void interp_paccess(int32 origin, int32 f_offset, uint32 type);			/* Access to a precompiled attribute */
rt_private void address(int32 fid, int stype, int for_rout_obj);					/* Address of a routine */
rt_private void assign(long int fid, int stype, uint32 type);					/* Assignment in an attribute */
rt_private void passign(int32 origin, int32 f_offset, uint32 type);					/* Assignment in a precomp attribute */

/* Calling protocol */
rt_private void init_var(struct item *ptr, long int type, char *current_ref);	/* Initialize to 0 a variable entity */
rt_private void init_registers(EIF_CONTEXT_NOARG);	/* Intialize registers in callee */
rt_private void allocate_registers(EIF_CONTEXT_NOARG);		/* Allocate the register array */
rt_shared void sync_registers(EIF_CONTEXT struct stochunk *stack_cur, struct item *stack_top);			/* Resynchronize the register array */
rt_private void pop_registers(void);			/* Remove local vars and arguments */

/* Operational stack handling routines */
rt_public struct item *opush(register struct item *val);			/* Push one value on op stack */
rt_public struct item *opop(void);				/* Pop last item */
rt_private struct item *stack_allocate(register int size);	/* Allocates first chunk */
rt_private int stack_extend(register int size);				/* Extend stack's size */
rt_private void npop(register int nb_items);					/* Pop 'n' items */
rt_public struct item *otop(void);				/* Pointer to value at the top */
rt_private struct item *oitem(uint32 n);			/* Pointer to value at position `n' down the stack */
rt_private void stack_truncate(void);			/* Truncate stack if necessary */
rt_private void wipe_out(register struct stochunk *chunk);				/* Remove unneeded chunk from stack */
#ifdef DEBUG
rt_private void dump_stack(void);				/* Dumps the operational stack */
rt_public void idump(FILE *, char *);					/* Byte code dumping */
rt_private void iinternal_dump(FILE *, char *);			/* Internal (compound) dumping */
#endif

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
	struct dcall *dtop;				\
	struct stdchunk *dcur;			\
	struct item *stop;				\
	struct stochunk *scur
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

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif


rt_public void xinterp(EIF_CONTEXT char *icval)
{
	/* Starts interpretation at IC = icval. It is the interpreter entry
	 * point for C code. When an exception occurs in the interpreted
	 * code, before propagating it to the C code, the operational stack
	 * must be cleaned.
	 */
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

	excatch(MTC (char *) exenv);	/* Record pseudo execution vector */

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

	EIF_END_GET_CONTEXT
}

rt_public void xiinv(EIF_CONTEXT char *icval, int where)
			
				/* Invariant checked after or before ? */
{
	/* Starts interpretation of invariant at IC = icval. */
	EIF_GET_CONTEXT
	jmp_buf exenv;			/* C code call to interpreter exec. vector */
	RTXD;					/* Save stack contexts */
	STACK_PRESERVE;			/* Stack contextual informations */

	IC = icval;					/* Where interpretation starts */
	tagval++;					/* One more call to interpreter */
	dstart();					/* Get calling record */
	SAVE(db_stack, dcur, dtop);	/* Save debugger stack */
	SAVE(op_stack, scur, stop);	/* Save operation stack */
	excatch(MTC (char *) exenv);	/* Record pseudo execution vector */

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

	EIF_END_GET_CONTEXT
}

rt_public void xinitint(EIF_CONTEXT_NOARG)
{
	/* Creation of the register array. */
	EIF_GET_CONTEXT

	iregsz = REGISTER_SIZE * sizeof(struct item *);
	iregs = (struct item **) cmalloc(iregsz);
	if (iregs == (struct item **) 0)	/* Not enough room */
		enomem(MTC_NOARG);

	EIF_END_GET_CONTEXT
}

rt_private void interpret(EIF_CONTEXT int flag, int where)
					/* Flag set to INTERP_INVA or INTERP_CMPD */
					/* Are we checking invariant before or after compound? */
{
	/* Interprets the byte-code starting at IC. For effeciency reasons, some
	 * "globals" are used by the main interpreting loop, to save some precious
	 * CPU cycles--RAM.
	 */

	EIF_GET_CONTEXT
	register1 int code;				/* Current intepreted byte code */
	register2 struct item *last;	/* Last pushed value */
	register3 long offset;			/* Offset for jumps and al */
	register4 char *string;			/* Strings for assertions tag */
	int type;						/* Often used to hold type values */
	int32 once_code = 0;			/* Once H code value */
	char *rescue;					/* Location of rescue clause */
	jmp_buf exenv;					/* In case we have to setjmp() */
	struct ex_vect *exvect;			/* Routine's execution vector */
	struct item *stop;				/* To save stack context */
	struct stochunk *scur;			/* Current chunk (stack context) */
	char **l_top;					/* Local top */
	struct stchunk *l_cur;			/* Current local chunk */
	char **ls_top;					/* loc_stack top */
	struct stchunk *ls_cur;			/* Current loc_stack chunk */
	char **h_top;					/* Hector stack top */
	struct stchunk *h_cur;			/* Current hector stack chunk */
	int assert_type;				/* Assertion type */
	int is_extern = 0;				/* External flag for featue call */
	char pre_success;				/* Flag for precondition success */ 
	char in_first_block;			/* Flag for chained preconditions */ 
	long rtype;						/* Result type */
	char *rvar;						/* Result address for once */
	int32 rout_id;					/* Routine id */
	int32 body_id;					/* Body id of once routine */
	int current_trace_level;		/* Saved call level for trace, only needed when routine is retried */
	char **saved_prof_top;			/* Saved top of `prof_stack' */
	long once_key;			/* Index in once table */
	int  is_once;			/* Is it a once routine? */
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

	is_once = 0;

	if (*IC++)
	{
		is_once  = 1;
		once_key = get_long ();
	}

	for (;;) {

#ifdef DEBUG
	dprintf(2)("0x%lX: ", IC);
#endif

	switch (code = *IC++) {		/* Read current byte-code and advance IC */

	/*
	 * Start of debuggable byte code.
	 */
	case BC_DEBUGABLE:
#ifdef DEBUG
		dprintf(2)("BC_DEBUGABLE\n");
		dprintf(2)("0x%lX: ", IC + sizeof(long) - 1);
#endif
		offset = get_long();	/* Get the body ID */
		drun(offset);			/* Initialize debugger for this feature */
		/* Fall through */

	/*
	 * Start of routine byte code.
	 */
	case BC_START:
#ifdef DEBUG
		dprintf(2)("BC_START\n");
#endif
		rout_id = (int32) get_long();	/* Get the routine id */
		rtype = get_long();				/* Get the result type */
		argnum = get_short();			/* Get the argument number */
	
		if (is_once) {				/* If it is a once */
			body_id = (uint32) get_long();	/* Get the body id */

				/* Put pointer to 'result' in 'rvar' */

				/* MTOG = MT Once Get */
			if (MTOG((char *),EIF_once_values[once_key], rvar))
			{
				/* Already executed. 'rvar' points to result */

				npop(argnum + 1);       /* Pop Current and the arguments */

				/* Retrieve value and then return */

				if ((rtype & SK_HEAD) != SK_VOID) 
				{
					last = iget();          /* Leave result on stack */
					last->type = rtype;

					switch (rtype & SK_HEAD) 
					{
						case SK_BOOL:
						case SK_CHAR:   
								last->it_char = *rvar;
								break;
						case SK_INT:    
								last->it_long = *((long*)rvar);
								break;
						case SK_FLOAT:  
								last->it_float = *((float*)rvar);
								break;
						case SK_DOUBLE: 
								last->it_double = *((double*)rvar);
								break;
						case SK_POINTER:
								last->it_ptr = *((char**) rvar);
								break;
						case SK_BIT:
						case SK_EXP:
						case SK_REF:
						/* %%zs Obsolete comment: */
						/* Once access is done via an hector pointer, since
						 * the address where the value is stored might not be
						 * suitably aligned, therefore making it impossible to
						 * use onceset.
						 */
								last->it_ref = eif_access(rvar);
								break;
						default:
								eif_panic(MTC "invalid result type");
					}
				}

				return;
			}
			else
			{
				/* Allocate space for 'result' then thread-specific (if MT
				   mode) store it via the key table. */

				if ((rtype & SK_HEAD) != SK_VOID) 
				{
					switch (rtype & SK_HEAD) 
					{
						case SK_BOOL:
						case SK_CHAR:   
								rvar = cmalloc (sizeof (char));
								break;
						case SK_INT:    
								rvar = (char *) cmalloc (sizeof (long));
								break;
						case SK_FLOAT:  
								rvar = (char *) cmalloc (sizeof (float));
								break;
						case SK_DOUBLE: 
								rvar = (char *) cmalloc (sizeof (double));
								break;
						case SK_POINTER:
								rvar = (char *) cmalloc (sizeof (char *));
								break;
						case SK_BIT:
						case SK_EXP:
						case SK_REF:    
							/*	rvar = (char *) cmalloc (sizeof (char *)); */
							/* rvar allocated in hector stack */
								rvar = henter((char *) 0);
								break;
					default:        
								eif_panic(MTC "invalid result type");
					}
				}
				else
				{
					/* It's a procedure we need only to store something != 0 */
					rvar = (char *) 1;
				}

				/* MTOS = MT Once Set */
				MTOS(EIF_once_values[once_key], rvar);
			}

			onceadd(body_id);	/* Add this routine to the list of already */
								/* called once routines */
		}

		locnum = get_short();		/* Get the local number */
		init_registers(MTC);		/* Initialize the registers */

		/* Expanded clone of arguments (if any) */
		while (*IC++ != BC_NO_CLONE_ARG) {
			char *ref;

			code = get_short();		/* Get the argument number to clone */
			last = arg(code);
			ref = last->it_ref;
			if (ref == (char *) 0)
				xraise(EN_VEXP);	/* Void assigned to expanded */
			switch (last->type & SK_HEAD) {
			case SK_REF:			/* Lovely comment */
			case SK_EXP:
				epush(&loc_stack, (char *)(&ref));
				type = get_short ();
				type = get_compound_id(MTC icurrent->it_ref, (short) type);
				last->it_ref = RTLN(type);
				epop(&loc_stack, 1);
				last->type = SK_EXP;
				ecopy(ref, last->it_ref);
				break;
			case SK_BIT:
				epush(&loc_stack, (char *)(&ref));
				last->it_bit = RTLB(get_short());
				epop(&loc_stack, 1);
				b_copy(ref, last->it_bit);
				break;
			}
		}

		init_var(iresult, rtype, icurrent->it_ref);

		switch(flag) {				/* What are we interpreting? */
		case INTERP_CMPD:			/* A compound (i.e. Eiffel feature) */
			string = IC;			/* Get the feature name */
			IC += strlen(IC) + 1;
			code = get_short();		/* Dynamic type where feature is written */

			/* Get an execution vector for the current feature, and link it
			 * with the current debugging calling context. It is important to
			 * have those pointers from the calling context into the Eiffel
			 * stack when dumping the execution stack (because we are able to
			 * compute the relative position of the features recorded in that
			 * calling context wrt the global execution flow in the Eiffel
			 * stack).
			 */
			RTEA(string, code, icurrent->it_ref);
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
			eif_panic(MTC botched);
		}

		rescue = (char *) 0;		/* No rescue */
		if (*IC++) {
			offset = get_long();	/* Fetch rescue offset */
			rescue = IC + offset;	/* Compute rescue start */
		}

		switch (flag) {
		case INTERP_CMPD: {
			int i;
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
					if (tagval != stagval) 
						sync_registers(MTC scur, stop);
					last->type = SK_BIT;
					break;
				default:
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
				if (is_once) {
					/* If the Result is an expanded, then we have an hector pointer
					 * in place of the result.
					 */
					eif_access(rvar) = last->it_ref;
				}
				break;
			case SK_BIT:
				last->type = SK_POINTER;    /* GC: wait for malloc */
				last->it_bit = RTLB(type & SK_BMASK);
				last->type = type;
				if (is_once) {
					/* If the Result is a bit, then we have an hector pointer
					* in place of the result.
					*/
					eif_access(rvar) = last->it_bit;
				}
				break;
			default:
				break;
			}

			if (rescue != (char *) 0) {	/* If there is a rescue clause */
				l_top = loc_set.st_top;		/* Save C local stack */
				l_cur = loc_set.st_cur;
				ls_top = loc_stack.st_top;	/* Save loc_stack */
				ls_cur = loc_stack.st_cur;
				h_top = hec_stack.st_top;	/* Save hector stack */
				h_cur = hec_stack.st_cur;
				current_trace_level = trace_call_level;	/* Save trace call level */
				if (prof_stack) saved_prof_top = prof_stack->st_top;
				exvect->ex_jbuf = (char *) exenv;	/* Longjmp address */
				if (setjmp(exenv))
					IC = rescue;				/* Jump to rescue clause */
			}
		}
			break;
		case INTERP_INVA:
			break;
		default:
			eif_panic(MTC botched);
		}
/* end:*/ /* %%ss removed */
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
		loc_set.st_cur = l_cur;
		if (l_cur) loc_set.st_end = l_cur->sk_end;
		loc_set.st_top = l_top;
		loc_stack.st_cur = ls_cur;
		if (ls_cur) loc_stack.st_end = ls_cur->sk_end;
		loc_stack.st_top = ls_top;
		hec_stack.st_cur = h_cur;
		if (h_cur) hec_stack.st_end = h_cur->sk_end;
		hec_stack.st_top = h_top;
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
		prof_stack_rewind(saved_prof_top);
		in_assertion = 0;
		offset = get_long();					/* Get the retry offset */
		IC += offset;
		exvect = exret(MTC exvect);					/* Retries a routine */
		break;

	/*
	 * Start of precondition(s).
	 */
	case BC_PRECOND:
#ifdef DEBUG
		dprintf(2)("BC_PRECOND\n");
#endif
		offset = get_long();
		if (!(~in_assertion & WASC(icur_dtype) & CK_REQUIRE))	/* No precondition check? */
			IC += offset;						/* Skip preconditions */

		pre_success = '\01';
		in_first_block = '\01';
		break;

	/*
	 * Start of postcondition(s).
	 */
	case BC_POSTCOND:
#ifdef DEBUG
		dprintf(2)("BC_POSTCOND\n");
#endif
		offset = get_long();
		if (!(~in_assertion & WASC(icur_dtype) & CK_ENSURE))	/* No postcondition check? */
			IC += offset;						/* Skip postconditions */
		break;

	/*
	 * Cast of a numeric type
	 */

	case BC_CAST_LONG:
#ifdef DEBUG
		dprintf(2)("BC_CAST_LONG\n");
#endif
		last = otop ();
		switch (last->type & SK_HEAD) {
			case (SK_FLOAT):{
				float f = last->it_float;
				last->it_long = (long) f;
				}
				break;
			case (SK_DOUBLE):{
				double d = last->it_double;
				last->it_long = (long) d;
				}
				break;
			case (SK_INT):
				break;
			default:
				eif_panic (MTC "Illegal cast operation");
			}
		last->type = SK_INT;
		break;

	/*
	 * Cast of a numeric type
	 */

	case BC_CAST_FLOAT:
#ifdef DEBUG
		dprintf(2)("BC_CAST_FLOAT\n");
#endif
		last = otop ();
		switch (last->type & SK_HEAD) {
			case (SK_INT):{
				long l = last->it_long;
				last->it_float = (float) l;
				}
				break;
			case (SK_DOUBLE):{
				double d = last->it_double;
				last->it_float = (float) d;
				}
				break;
			case (SK_FLOAT):
				break;
			default:
				eif_panic (MTC "Illegal cast operation");
			}
		last->type = SK_FLOAT;
		break;

	/*
	 * Cast of a numeric type
	 */

	case BC_CAST_DOUBLE:
#ifdef DEBUG
		dprintf(2)("BC_CAST_DOUBLE\n");
#endif
		last = otop ();
		switch (last->type & SK_HEAD) {
			case (SK_INT):{
				long l = last->it_long;
				last->it_double = l;
				}
				break;
			case (SK_FLOAT):{
				float f = last->it_float;
				last->it_double = f;
				}
				break;
			case (SK_DOUBLE):
				break;
			default:
				eif_panic (MTC "Illegal cast operation");
			}
		last->type = SK_DOUBLE;
		break;

	/*
	 * Assignment to result.
	 */
	case BC_RASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_RASSIGN\n");
#endif
		bcopy(opop(), iresult, ITEM_SZ);
		/* Register once function if needed. This has to be done constantly
		 * whenever the Result is changed, in case the once calls another
		 * feature which is going to call this once feature again.
		 */
		if (is_once) {
			last = iresult;
			switch (rtype & SK_HEAD) 
			{
				case SK_BOOL:
				case SK_CHAR:   
						*rvar = last->it_char;
						break;
				case SK_INT:    
						*((long*)rvar) = last->it_long;
						break;
				case SK_FLOAT:  
						*((float*)rvar) = last->it_float; 
						break;
				case SK_DOUBLE: 
						*((double*)rvar) = last->it_double;
						break;
				case SK_POINTER:
						*((char**) rvar) = last->it_ptr;
						break;
				case SK_BIT:
				case SK_EXP:
				case SK_REF:
				/* Once access is done via an hector pointer, since
				 * the address where the value is stored might not be
				 * suitably aligned, therefore making it impossible to
				 * use onceset.
				 */
						eif_access(rvar) = last->it_ref;
						break;
			}
		}
		break;

	/*
	 * Assignment to an expanded result
	 */
	case BC_REXP_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_REXP_ASSIGN\n");
#endif
		{	char *ref = opop()->it_ref;

			if (ref == (char *) 0)
				xraise(EN_VEXP);	/* Void assigned to expanded */
			ecopy(ref, iresult->it_ref);

			if (is_once) {
				last = iresult;
				switch (rtype & SK_HEAD) {	/* Result type held in rtype */
				case SK_BIT:
				case SK_EXP:
				case SK_REF:	/* See below */ 
					/* If the Result is a reference, then we have an hector pointer
				 	* in place of the result.
					*/
					eif_access(rvar) = last->it_ref;
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
		code = get_short();		/* Get the local number (from 1 to locnum) */
		bcopy(opop(), loc(code), ITEM_SZ);
		break;

	/*
	 * Assignment to a bit local variable.
	 */
	case BC_LBIT_ASSIGN:
#ifdef DEBUG
		dprintf(2)("BC_LBIT_ASSIGN\n");
#endif
		code = get_short();		/* Get the local number (from 1 to locnum) */
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
		{	char *ref = opop()->it_ref;

			if (ref == (char *) 0)
				xraise(EN_VEXP);	/* Void assigned to expanded */
			code = get_short();		/* Get the local # (from 1 to locnum) */
			ecopy(ref, loc(code)->it_ref);		/* Copy */
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

			offset = get_long();		/* Get the feature id */
			code = get_short();			/* Get the static type */
			type = get_uint32();		/* Get attribute meta-type */
			assign(offset, code, type);
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

			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			type = get_uint32();		/* Get attribute meta-type */
			passign(origin, ooffset, type);
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
			char *ref;

			ref = opop()->it_ref;		/* Expression type */
			if (ref == (char *) 0)
				xraise(EN_VEXP);		/* Void assigned to expanded */
			offset = get_long();		/* Get the feature id */
			code = get_short();			/* Get the static type */
			type = get_uint32();		/* Get attribute meta-type */
			offset = RTWA(code, offset, icur_dtype);
			ecopy (ref, icurrent->it_ref + offset);
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
			char *ref;
			int32 origin, ooffset;

			ref = opop()->it_ref;		/* Expression type */
			if (ref == (char *) 0)
				xraise(EN_VEXP);		/* Void assigned to expanded */
			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			type = get_uint32();		/* Get attribute meta-type */
			offset = RTWPA(origin, ooffset, icur_dtype);
			ecopy (ref, icurrent->it_ref + offset);
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
		type = get_short();			/* Get the reverse type */
		last = opop();

/* GENERIC CONFORMANCE */
		type = get_compound_id(MTC icurrent->it_ref,(short) type);

		if (!RTRA(type, last->it_ref))
			iresult->it_ref = (char *) 0;
		else
			iresult->it_ref = last->it_ref;

		/* Register once function if needed. This has to be done constantly
		 * whenever the Result is changed, in case the once calls another
		 * feature which is going to call this once feature again.
		 */
		if (is_once) {
			last = iresult;
				/* If the Result is a reference, then we have an hector pointer
				 * in place of the result.
				 */
			eif_access(rvar) = last->it_ref;
		}
		break;

	/*
	 * Reverse assignment to a local variable.
	 */
	case BC_LREVERSE:
#ifdef DEBUG
		dprintf(2)("BC_LREVERSE\n");
#endif
		code = get_short();			/* Get local number */
		type = get_short();			/* Get the reverse type */
		last = opop();

/* GENERIC CONFORMANCE */
		type = get_compound_id(MTC icurrent->it_ref, (short)type);

		if (!RTRA(type, last->it_ref))
			loc(code)->it_ref = (char *) 0;
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

			offset = get_long();		/* Get the feature id */
			code = get_short();			/* Get the static type */
			meta = get_uint32();		/* Get the attribute meta-type */
			type = get_short();			/* Get the reverse type */
			last = otop();

/* GENERIC CONFORMANCE */
			type = get_compound_id(MTC icurrent->it_ref,(short)type);

			if (!RTRA(type, last->it_ref))
				last->it_ref = (char *) 0;
			assign(offset, code, meta);
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

			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			meta = get_uint32();		/* Get the attribute meta-type */
			type = get_short();			/* Get the reverse type */
			last = otop();

/* GENERIC CONFORMANCE */
			type = get_compound_id(MTC icurrent->it_ref,(short)type);

			if (!RTRA(type, last->it_ref))
				last->it_ref = (char *) 0;
			passign(origin, ooffset, meta);
		}
		break;

	/*
	 * Clone of a reference
	 */
	case BC_CLONE:
#ifdef DEBUG
		dprintf(2)("BC_CLONE\n");
#endif
		{	char *ref;
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
			ecopy(ref, last->it_ref);	/* Copy to complete the clone */
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
#ifdef DEBUG
		dprintf(2)("BC_VOID\n");
#endif
		otop()->it_ref = (char *) 0;
		break;
	
	/*
	 * Check instruction.
	 */
	case BC_CHECK:
#ifdef DEBUG
		dprintf(2)("BC_CHECK\n");
#endif
		offset = get_long();	/* Jump offset in assertion is not checked */
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
		offset = get_long();	/* Jump offset if assertion is not checked */
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
			string = IC;
			IC += strlen(IC) + 1;
			if ((assert_type == EX_CINV) || (assert_type == EX_INVC))
				RTIT(string, icurrent->it_ref);
			else
				RTCT(string, assert_type);
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
	case BC_END_FST_PRE:
#ifdef DEBUG
		dprintf(2)("BC_END_FST_PRE\n");
#endif
		offset = get_long();		/* get the offset to the precondition
									 * block's corresponding "BC_GOTO_BODY"
									*/
		code = (int) opop()->it_char;	
									/* Get the assertion boolean result */
		if (!code) {
			pre_success = '\0'; 
			IC += offset;
		}
		else {
			RTCK;
		}
		break;

	/*
	 * Remove precondition exception. 
	 */
	case BC_END_PRE:
#ifdef DEBUG
		dprintf(2)("BC_END_PRE\n");
#endif
		offset = get_long(); 	/* the offset to the corresponding 
								 * precondition block's "BC_GOTO_BODY"
								*/
		code = (int) opop()->it_char;	
									/* Get the assertion boolean result */
		if (!code) {
			pre_success = '\0';
			IC += offset;
		}
		break;

	/*
	 * Raise exception. 
	 */
	case BC_RAISE_PREC:
#ifdef DEBUG
		dprintf(2)("BC_RAISE_PREC\n");
#endif
		RTCF;
		break;

	/*
	 * Go to the body of the routine 
	 */
	case BC_GOTO_BODY:
#ifdef DEBUG
		dprintf(2)("BC_GOTO_BODY\n");
#endif
		{
			offset = get_long(); 	/* Get offset to skip remaining 
									 * chained assertions.
									 */
			if (pre_success){ 
				IC += offset;		/* Go to the body of routine */
				if (!in_first_block) {
					RTCK;
				}
			}
			else
				pre_success = '\01';
									/* Reset success for next block */
			in_first_block = '\0';
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

			code = get_short();		/* Get the local variant index */
			last = loc(code);
			offset = opop()->it_long;	/* Get the new variant value */
			old_val = last->it_long;	/* Get the old variant value */
			last->it_long = offset;		/* Save the new variant value */
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
		code = get_short();
		loc(code)->it_long = -1;
		break;

	/*
	 * Debug statement.
	 */
	case BC_DEBUG:
#ifdef DEBUG
		dprintf(2)("BC_DEBUG\n");
#endif
		offset = get_long();	/* Number of keys */
		if (offset == 0L)
			code = WDBG(icur_dtype, (char *) 0);		/* No debug key */
		else {
			int i;
			for (i = 0, code = 0; i < offset; i++) {
				string = IC;						/* Get a debug key */
				IC += strlen(IC) + 1;
				code |= WDBG(icur_dtype, string);
			}
		}
		offset = get_long();	/* Get the jump value */
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
			char *new_obj;						/* New object */
			unsigned long stagval;
			short has_args, has_open, has_closed;
			struct item *addr, *aargs, *aopen, *aclosed;
			char *args, *open, *closed;

			args = open = closed = (char *) 0;
			has_args = get_short(); /* Do we have an argument tuple? */
			has_open = get_short(); /* Do we have an open map array? */
			has_closed = get_short(); /* Do we have a closed map array? */
			type = get_short();
			type = get_compound_id(MTC icurrent->it_ref,(short)type);
			addr = opop();  /* Address of routine */
			if (has_closed)
			{
				aclosed = opop();
				closed = (char *) (aclosed->it_ref);
			}
			if (has_open)
			{
				aopen = opop();
				open = (char *) (aopen->it_ref);
			}
			if (has_args)
			{
				aargs = opop();
				args = (char *) (aargs->it_ref);
			}
			stagval = tagval;
			new_obj = RTLNR((int16)type, addr->it_ptr, args, open, closed);		/* Create new object */
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
		switch (*IC++) {
		case BC_CTYPE:				/* Hardcoded creation type */
			type = get_short();
/* GENERIC CONFORMANCE */
			type = get_compound_id(MTC icurrent->it_ref,(short)type);
			break;
		case BC_CREATE_EXP:			/* Hardcoded creation expression type */
			need_push = *IC++;		/* If there is a creation routine to call
									   we need to push twice the created object */
			*IC++;
			type = get_short();
/* GENERIC CONFORMANCE */
			type = get_compound_id(MTC icurrent->it_ref,(short)type);
			break;
		case BC_CARG:				/* Like argument creation type */
			type = get_short();		/* Default creation type if void arg.  */
/* GENERIC CONFORMANCE */
			type = get_compound_id(MTC icurrent->it_ref,(short)type);
			code = get_short();		/* Argument position */
			type = RTCA(arg(code)->it_ref, type);
			break;
		case BC_CLIKE:				/* Like feature creation type */
			code = get_short();		/* Get the static type first */
			offset = get_long();	/* Get the feature id of the anchor */
/* GENERIC CONFORMANCE */
			type = RTWCT(code, offset, icurrent->it_ref);
			break;
		case BC_PCLIKE:				/* Like feature creation type */
			{
			short stype;
			int32 origin, ooffset;

			stype = get_short();			/* Get static type of caller */
			origin = get_long();			/* Get the origin class id */
			ooffset = get_long();			/* Get the offset in origin */
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

			current_type = get_short ();		/* Get static type of caller */
			formal_position = get_long ();	/* Get position of formal generic
											   we want to create */
			type = (int) RTGPTID(current_type, icurrent->it_ref, formal_position);
			}
			break;
		default:
			eif_panic(MTC "creation type lost");
			/* NOTREACHED */
		}	
		/* Creation of a new object. We know there will be no call to a
		 * creation routine, so it's useless to resynchronize registers--RAM.
		 */
		{
			char *new_obj;						/* New object */
			unsigned long stagval;

			stagval = tagval;
			new_obj = RTLN(type);		/* Create new object */
			last = iget();				/* Push a new value onto the stack */
			last->type = SK_REF;	
			last->it_ref = new_obj;		/* Now it's safe for GC to see it */
			if (need_push == (char) 1)
				opush (last);
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
	 * Once case of multi-branch instruction (when part).
	 */
	case BC_RANGE:
#ifdef DEBUG
		dprintf(2)("BC_RANGE\n");
#endif
		{
			struct item *lower, *upper;
			long intval;
			char charval;

			upper = opop();				/* Get the upper bound */
			lower = opop();				/* Get the lower bound */
			last = otop();				/* Get the inspect expression value */
			offset = get_long();		/* Get the jump value */
			switch (last->type) {
			case SK_INT:
				intval = last->it_long;
				if (lower->it_long <= intval && intval <= upper->it_long)
					IC += offset;
				break;
			case SK_CHAR:
				charval = last->it_char;
				if (lower->it_char <= charval && charval <= upper->it_char)
					IC += offset;
				break;
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
		{	char *new_obj;
			uint32 head_type;
			unsigned long stagval;

			last = opop();
			stagval = tagval;
			head_type = last->type & SK_HEAD;
			if (head_type != SK_BIT) {
				switch (head_type) {
				case SK_BOOL:
					new_obj = RTLN(egc_bool_ref_dtype);
					*new_obj = last->it_char;
					break;
				case SK_CHAR:	
					new_obj = RTLN(egc_char_ref_dtype);
					*new_obj = last->it_char;
					break;
				case SK_INT:
					new_obj = RTLN(egc_int_ref_dtype);
					*(long *) new_obj = last->it_long;
					break;
				case SK_FLOAT:
					new_obj = RTLN(egc_real_ref_dtype);
					*(float *) new_obj = last->it_float;
					break;
				case SK_DOUBLE:
					new_obj = RTLN(egc_doub_ref_dtype);
					*(double *) new_obj = last->it_double;
					break;
				case SK_POINTER:
					new_obj = RTLN(egc_point_ref_dtype);
					*(char **) new_obj = last->it_ptr;
					break;
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
				/* Bit metamorhose is a clone */
				new_obj = b_clone(last->it_bit);
				last = iget();
				last->type = SK_REF;
				last->it_ref = new_obj;
			}
			if (tagval != stagval)				/* If G.C calls melted dispose */
				sync_registers(MTC scur, stop);
		}
		break;

	/*
	 * Calling an external function.
	 */
	case BC_EXTERN:
#ifdef DEBUG
		dprintf(2)("BC_EXTERN\n");
#endif
		is_extern = 1;
		/* Fall through */

	/*
	 * Calling an Eiffel feature.
	 */
	case BC_FEATURE:
#ifdef DEBUG
		if (!is_extern)
			dprintf(2)("BC_FEATURE\n");
#endif
		offset = get_long();				/* Get the feature id */
		code = get_short();					/* Get the static type */
		nstcall = 0;						/* Invariant check turned off */
		if (icall(MTC (int)offset, code, is_extern, GET_PTYPE))
			sync_registers(MTC scur, stop);
		is_extern = 0;
		break;

	/*
	 * Calling a precompiled external function.
	 */
	case BC_PEXTERN:
#ifdef DEBUG
		dprintf(2)("BC_PEXTERN\n");
#endif
		is_extern = 1;
		/* Fall through */

	/*
	 * Calling a precompiled Eiffel feature.
	 */
	case BC_PFEATURE:
#ifdef DEBUG
		if (!is_extern)
			dprintf(2)("BC_PFEATURE\n");
#endif
		{
			int32 origin, offset;

			origin = get_long();			/* Get the origin class id */
			offset = get_long();			/* Get the offset in origin */
			nstcall = 0;					/* Invariant check turned off */
			if (ipcall(MTC origin, offset, is_extern, GET_PTYPE))
				sync_registers(MTC scur, stop);
			is_extern = 0;
			break;
		}

	/*
	 * Calling an external in a nested expression (invariant check needed).
	 */
	case BC_EXTERN_INV:
#ifdef DEBUG
		dprintf(2)("BC_EXTERN_INV");
#endif
		is_extern = 1;
		/* Fall through */

	/*
	 * Calling an Eiffel feature in a nested expression (invariant check).
	 */
	case BC_FEATURE_INV:
#ifdef DEBUG
		if (!is_extern)
			dprintf(2)("BC_FEATURE_INV\n");
#endif
		string = IC;					/* Get the feature name */
		IC += strlen(IC) + 1;
		if (otop()->it_ref == (char *) 0)	/* Called on a void reference? */
			eraise(string, EN_VOID);		/* Yes, raise exception */
		offset = get_long();				/* Get the feature id */
		code = get_short();					/* Get the static type */

		nstcall = 1;					/* Invariant check turned on */
		if (icall(MTC (int)offset, code, is_extern, GET_PTYPE))
			sync_registers(MTC scur, stop);
		is_extern = 0;						/* No side effect */
		break;

	/*
	 * Calling a precompiled external in a nested expression (invariant check needed).
	 */
	case BC_PEXTERN_INV:
#ifdef DEBUG
		dprintf(2)("BC_PEXTERN_INV");
#endif
		is_extern = 1;
		/* Fall through */

	/*
	 * Calling a precompiled Eiffel feature in a nested expression
	 * (invariant check).
	 */
	case BC_PFEATURE_INV:
#ifdef DEBUG
		if (!is_extern)
			dprintf(2)("BC_PFEATURE_INV\n");
#endif
		{
			int32 offset, origin;

			string = IC;					/* Get the feature name */
			IC += strlen(IC) + 1;
			if (otop()->it_ref == (char *) 0)/* Called on a void reference? */
				eraise(string, EN_VOID);	/* Yes, raise exception */
			origin = get_long();			/* Get the origin class id */
			offset = get_long();			/* Get the offset in origin */
			nstcall = 1;					/* Invariant check turned on */
			if (ipcall(MTC origin, offset, is_extern, GET_PTYPE))
				sync_registers(MTC scur, stop);
			is_extern = 0;						/* No side effect */
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

			offset = get_long();				/* Get feature id */
			code = get_short();					/* Get static type */
			type = get_uint32();				/* Get attribute meta-type */
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

			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			type = get_uint32();		/* Get attribute meta-type */
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

			string = IC;					/* Get the attribute name */
			IC += strlen(IC) + 1;			
			if (otop()->it_ref == (char *) 0)
				eraise(string, EN_VOID);
			offset = get_long();			/* Get feature id */
			code = get_short();				/* Get static type */
			type = get_uint32();			/* Get attribute meta-type */
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

			string = IC;					/* Get the attribute name */
			IC += strlen(IC) + 1;			
			if (otop()->it_ref == (char *) 0)
				eraise(string, EN_VOID);
			origin = get_long();			/* Get the origin class id */
			ooffset = get_long();			/* Get the offset in origin */
			type = get_uint32();			/* Get attribute meta-type */
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

			code = get_short() - 1;
			new = opop();
			bcopy(new, &prev, ITEM_SZ);

#ifdef USE_STRUCT_COPY
			op_context = op_stack;
#else
			bcopy(&op_stack, &op_context, sizeof(struct opstack));
#endif

			while (code-- > 0) {
				new = opop();
				bcopy(new, &old, ITEM_SZ);
				bcopy(&prev, new, ITEM_SZ);
#ifdef USE_STRUCT_COPY
				prev = old;
#else
				bcopy(&old, &prev, ITEM_SZ);
#endif
			}

#ifdef USE_STRUCT_COPY
			op_stack = op_context;
#else
			bcopy(&op_context, &op_stack, sizeof(struct opstack));
#endif

			opush(&prev);
		}
		break;

	/*
	 * Hector protection of an address
	 */
	case BC_PROTECT:
#ifdef DEBUG
		dprintf(2)("BC_PROTECT\n");
#endif
		last = otop();
		last->type = SK_POINTER;	/* So the EIF_OBJECT will be ignored by GC */
		last->it_ref = (char *) RTHP(last->it_ref);
		break;

	/* 
	 * Hector address release
	 */
	case BC_RELEASE:
#ifdef DEBUG
		dprintf(2)("BC_RELEASE\n");
#endif
		code = get_short();
		RTHF(code);
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
	 * Integer constant.
	 */
	case BC_INT:
#ifdef DEBUG
		dprintf(2)("BC_INT\n");
#endif
		last = iget();
		last->type = SK_INT;
		last->it_long = get_long();
		break;

	/*
	 * Real constant.
	 */
	case BC_FLOAT:
#ifdef DEBUG
		dprintf(2)("BC_FLOAT\n");
#endif
		last = iget();
		last->type = SK_FLOAT;
		last->it_float = (float) get_double();
		break;

	/*
	 * Double constant.
	 */
	case BC_DOUBLE:
#ifdef DEBUG
		dprintf(2)("BC_DOUBLE\n");
#endif
		last = iget();
		last->type = SK_DOUBLE;
		last->it_double = get_double();
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
		code = get_short();				/* Get number (from 1 to locnum) */
		last = iget();
		bcopy(loc(code), last, ITEM_SZ);
		break;

	/*
	 * Access to an argument.
	 */
	case BC_ARG:
#ifdef DEBUG
		dprintf(2)("BC_ARG\n");
#endif
		code = get_short();				/* Get number (from 1 to argnum) */
		last = iget();
		bcopy(arg(code), last, ITEM_SZ);
		break;

	/*
	 * And then operator (left value).
	 */
	case BC_AND_THEN:
#ifdef DEBUG
		dprintf(2)("BC_AND_THEN\n");
#endif
		offset = get_long();
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
		offset = get_long();
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
	 * Expanded comparison
 	 */
	case BC_STANDARD_EQUAL:
#ifdef DEBUG
	dprintf(2)("BC_STANDARD_EQUAL\n");
#endif
		{	char *ref;

			ref = opop()->it_ref;
			last = otop();
			last->it_char = (char) RTEQ(ref, last->it_ref);
			last->type = SK_BOOL;
		}
		break;

	/*
	/*
	 * Bit comparison
 	 */
	case BC_BIT_STD_EQUAL:
#ifdef DEBUG
	dprintf(2)("BC_STD_EQUAL\n");
#endif
		{	char *bit;

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
		offset = get_long();			/* Get the feature id */
		code = get_short();				/* Get the static type */
		address((int32)offset, code, (int) get_short());
		break;

	/*
	 * Reserved space (for object address)
	 */
	case BC_RESERVE:
#ifdef DEBUG
		dprintf(2)("BC_RESERVE\n");
#endif
		last = iget();
		break;
	/*
	 * Object address operator.
	 */
	case BC_OBJECT_ADDR:
		{
		struct item *pointed_object;
	 	EIF_BOOLEAN is_attribute = EIF_FALSE;
		uint32 value_offset = get_uint32();
#ifdef DEBUG
		dprintf(2)("BC_OBJECT_ADDR\n");
#endif

		switch(*IC++) {
			case BC_LOCAL:
				code = get_short();		/* Get number (from 1 to locnum) */
				pointed_object = loc(code);
				break;
			case BC_ARG:
				code = get_short();		/* Get number (from 1 to argnum) */
				pointed_object = arg(code);
				break;
			case BC_RESULT:
				pointed_object = iresult;
				break;
			case BC_CURRENT:
				switch (*IC++) {
				case BC_ATTRIBUTE:
					is_attribute = EIF_TRUE;
					offset = get_long();		/* Get feature id */
					code = get_short();			/* Get static type */
					type = get_uint32();		/* Get attribute meta-type */
					offset = RTWA(code, (int)offset, Dtype(icurrent->it_ref));
					break;
				case BC_PATTRIBUTE:
					{
					int32 origin, ooffset;

					is_attribute = EIF_TRUE;
					origin = get_long();		/* Get the origin class id */
					ooffset = get_long();		/* Get the offset in origin */
					type = get_uint32();		/* Get attribute meta-type */
					offset = RTWPA(origin, ooffset, Dtype(icurrent->it_ref));
					break;
					}
				default:
					eif_panic(MTC "illegal access to Current");
				}

				last = oitem(value_offset);
				last->type = SK_POINTER;
				last->it_ref = (char *) (icurrent->it_ref+offset);
				break;
			default:
				eif_panic(MTC "illegal address access");
			}
			if (is_attribute == EIF_FALSE){
				last = oitem(value_offset);
				last->type = SK_POINTER;

				switch (pointed_object->type & SK_HEAD) {
					case SK_BOOL:
					case SK_CHAR: last->it_ref = (char *) (&(pointed_object->it_char)); break;
					case SK_INT: last->it_ref = (char *) (&(pointed_object->it_long)); break;
					case SK_FLOAT: last->it_ref = (char *) (&(pointed_object->it_float)); break;
					case SK_DOUBLE: last->it_ref = (char *) (&(pointed_object->it_double)); break;
					case SK_BIT: last->it_ref = (char *) (&(pointed_object->it_bit)); break;
					case SK_POINTER: last->it_ref = (char *) (&(pointed_object->it_ptr)); break;
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

		ptr_pos = get_uint32();
		value_pos = get_uint32();

		pointed_object = oitem(value_pos);
		last = oitem(ptr_pos);
		last->type = SK_POINTER;

		switch (pointed_object->type & SK_HEAD) {
			case SK_BOOL:
			case SK_CHAR: last->it_ref = (char *) (&(pointed_object->it_char)); break;
			case SK_INT: last->it_ref = (char *) (&(pointed_object->it_long)); break;
			case SK_FLOAT: last->it_ref = (char *) (&(pointed_object->it_float)); break;
			case SK_DOUBLE: last->it_ref = (char *) (&(pointed_object->it_double)); break;
			case SK_BIT: last->it_ref = (char *) (&(pointed_object->it_bit)); break;
			case SK_POINTER: last->it_ref = (char *) (&(pointed_object->it_ptr)); break;
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
		uint32 i, nb_uint32 = get_uint32();
		for (i = 0; i < nb_uint32; i++)
			opop();
		}
		break;

	/*
	 * Manifest array
	 */
 
	case BC_ARRAY:
#ifdef DEBUG
		dprintf(2)("BC_ARRAY\n");
#endif
		{
			long nbr_of_items;
			char *new_obj;
			char *sp_area;
			short stype, dtype, feat_id;
			unsigned long stagval;
			int curr_pos = 0;
			struct item *it;
			long elem_size;
			char *OLD_IC;
			short is_tuple;
 
			stype = get_short();			/* Get the static type */
			dtype = get_short();			/* Get the static type */

/*GENERIC CONFORMANCE */
			dtype = get_compound_id(MTC icurrent->it_ref,dtype);

			feat_id = get_short();		  	/* Get the feature id */
			nbr_of_items = get_long();	  	/* Number of items in array */
			is_tuple = get_short(); /* Is it actually a TUPLE? */

			stagval = tagval;
			OLD_IC = IC;					/* Save IC counter */
 
			new_obj = RTLN(dtype);			/* Create new object */

			epush (&loc_stack, (char *)(&new_obj));   /* Protect new_obj */
			if (is_tuple)
				((void (*)()) RTWF(stype, feat_id, Dtype(new_obj)))(new_obj);
			else
				((void (*)()) RTWF(stype, feat_id, Dtype(new_obj)))(new_obj, 1L, nbr_of_items);

			IC = OLD_IC;
			if (tagval != stagval)
				sync_registers(MTC scur, stop); /* If calls melted make of array */ 
		
			sp_area = *(char **) new_obj;
			while ((curr_pos++) != nbr_of_items) {
				/* Fill the special area with the expressions
				* for the manifest array.
				*/

				it = opop();		/* Pop expression off stack */
				switch (it->type & SK_HEAD) {
					case SK_BOOL:
					case SK_CHAR:
						*(char *) sp_area = it->it_char;
						sp_area += sizeof(char);
						break;
					case SK_BIT:
						*(char **) sp_area = it->it_bit;
						sp_area += BITOFF(LENGTH(it->it_bit)); 
						break;
					case SK_EXP:
						elem_size = *(long *) (sp_area + (HEADER(sp_area)->ov_size & B_SIZE) - LNGPAD_2 + sizeof(long));
						ecopy(it->it_ref, sp_area + OVERHEAD + elem_size * curr_pos);
						break;
					case SK_REF:
						/* No need to call RTAS as the area is the last object allocated and is thus in the NEW set */
						*(char **) sp_area = it->it_ref;
						sp_area += sizeof(char *);
						break;
					case SK_INT:
						*(long *) sp_area = it->it_long;
						sp_area += sizeof(long);
						break;
					case SK_FLOAT:
						*(float *) sp_area = it->it_float;
						sp_area += sizeof(float);
						break;
					case SK_DOUBLE:
						*(double *) sp_area = it->it_double;
						sp_area += sizeof(double);
						break;
					case SK_POINTER:
						*(char **) sp_area = it->it_ptr;
						sp_area += sizeof(fnptr);
						break;
					default:
						eif_panic(MTC botched);
				}
			}
			epop (&loc_stack, 1);			/* Release protection of `new_obj' */
			last = iget();
			last->type = SK_REF;
			last->it_ref = new_obj;
			break;
		}

	/*
	 * Manifest array (when ARRAY is precompiled)
	 */
 
	case BC_PARRAY:
#ifdef DEBUG
		dprintf(2)("BC_PARRAY\n");
#endif
		{
			int32 origin, ooffset;
			long nbr_of_items;
			char *new_obj;
			char *sp_area;
			short dtype;
			unsigned long stagval;
			int curr_pos = 0;
			struct item *it;
			long elem_size;
			char *OLD_IC;
			short is_tuple;
 
			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			dtype = get_short();			/* Get the static type */

/*GENERIC CONFORMANCE */
			dtype = get_compound_id(MTC icurrent->it_ref,dtype);

			nbr_of_items = get_long();	  	/* Number of items in array */
			is_tuple = get_short(); /* Is it actually a TUPLE?*/
			stagval = tagval;
			OLD_IC = IC;					/* Save IC counter */
 
			new_obj = RTLN(dtype);			/* Create new object */
			epush (&loc_stack, (char *)(&new_obj));   /* Protect new_obj */
			if (is_tuple)
				((void (*)()) RTWPF(origin, ooffset, Dtype(new_obj)))(new_obj);
			else
				((void (*)()) RTWPF(origin, ooffset, Dtype(new_obj)))(new_obj, 1L, nbr_of_items);

			IC = OLD_IC;
			if (tagval != stagval)
				sync_registers(MTC scur, stop); /* If calls melted make of array */ 
		
			sp_area = *(char **) new_obj;
			while ((curr_pos++) != nbr_of_items) {
				/* Fill the special area with the expressions
				* for the manifest array.
				*/
				it = opop();		/* Pop expression off stack */
				switch (it->type & SK_HEAD) {
					case SK_BOOL:
					case SK_CHAR:
						*(char *) sp_area = it->it_char;
						sp_area += sizeof(char);
						break;
					case SK_BIT:
						*(char **) sp_area = it->it_bit;
						sp_area += BITOFF(LENGTH(it->it_bit)); 
						break;
					case SK_EXP:
						elem_size = *(long *) (sp_area + (HEADER(sp_area)->ov_size & B_SIZE) - LNGPAD_2 + sizeof(long));
						ecopy(it->it_ref, sp_area + OVERHEAD + elem_size * curr_pos);
						break;
					case SK_REF:
						/* No need to call RTAS as the area is the last object allocated and is thus in the NEW set */
						*(char **) sp_area = it->it_ref;
						sp_area += sizeof(char *);
						break;
					case SK_INT:
						*(long *) sp_area = it->it_long;
						sp_area += sizeof(long);
						break;
					case SK_FLOAT:
						*(float *) sp_area = it->it_float;
						sp_area += sizeof(float);
						break;
					case SK_DOUBLE:
						*(double *) sp_area = it->it_double;
						sp_area += sizeof(double);
						break;
					case SK_POINTER:
						*(char **) sp_area = it->it_ptr;
						sp_area += sizeof(fnptr);
						break;
					default:
						eif_panic(MTC botched);
				}
			}
			epop (&loc_stack, 1);			/* Release protection of `new_obj' */
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
		code = get_short();             /* Get number (from 1 to locnum) */
		last = iget();
		bcopy(loc(code), last, ITEM_SZ);
		break;

	/*
	 * Beginning of old evaluation
	 */
	case BC_START_EVAL_OLD:
#ifdef DEBUG
		dprintf(2)("BC_START_EVAL_OLD\n");
#endif
		
		offset = get_long();		/* Get offset for skipping old evaluation block */
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
		code = get_short();     /* Get the local number (from 1 to locnum) */
		bcopy(last, loc(code), ITEM_SZ);
		break;

	/*
	 * Add attribute name to be stripped. 
	 */
	case BC_ADD_STRIP:
#ifdef DEBUG
		dprintf(2)("BC_ADD_STRIP\n");
#endif
		string = IC;
		IC += strlen(IC) + 1;
		last = iget();
		last->type = SK_REF;
		last->it_ref = string;
		break;

	/*
	 * End strip execution 
	 */
	case BC_END_STRIP:
#ifdef DEBUG
		dprintf(2)("BC_END_STRIP\n");
#endif
		{	long nbr_of_items, temp;
			char **stripped;
			char *array;
			short d_type; /* %%ss removed , s_type; */
			unsigned long stagval;

			stagval = tagval;
			d_type = get_short();           /* Get the dynamic type */
			nbr_of_items = get_long();
			temp = nbr_of_items;
			stripped = (char **) cmalloc(sizeof(char *)*nbr_of_items);
			if (stripped == (char **) 0) 
				enomem(MTC_NOARG);
			while (nbr_of_items--) {
				last = opop();
				stripped[nbr_of_items] = last->it_ref; 
			}
			array = striparr(icurrent->it_ref, d_type, stripped, temp);
			if (tagval != stagval)
				sync_registers(MTC scur, stop); /* If G.C calls melted dispose */
			xfree ((char *) stripped);
			last = iget();
			last->type = SK_REF;
			last->it_ref = array;
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
			char *str_obj;			  /* String object created */
			unsigned long stagval;
 
			 stagval = tagval;
			string = IC;
			/* FIXME: string length */
			IC += strlen(IC) + 1;
			last = iget();
			last->type = SK_INT;		/* Protect empty cell from GC */
 
			/* We have to use the str_obj temporary variable instead of doing
			 * the assignment directly into last->it_ref because the GC might
			 * run a cycle when makestr() is called...
			 */

			str_obj = makestr(string, strlen(string));
 
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
			char  *new_obj;		/* New bit object created */
			uint32 bcount;		/* Bit count */
			uint32 realcount;	/* Real bit count */
			int nb_uint32;
			uint32 *addr;

			last = iget();
			realcount = get_uint32();
			bcount = get_uint32();			/* Read bit count */
			new_obj = RTLB(realcount);			/* Creation */
			addr = ARENA(new_obj);
			nb_uint32 = BIT_NBPACK(bcount);
			while (nb_uint32--)	/* Write bit count and value in `new_obj' */ 
				*addr++ = get_uint32();
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
		offset = get_long();	/* Get jump offset */
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
		offset = get_long();	/* Get jump offset */
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
		offset = get_long();	/* Because get_long() updates IC on the fly */
		IC += offset;
		break;

	/*
	 * Next debugging instruction.
	 */
	case BC_NEXT:
#ifdef DEBUG
		dprintf(2)("BC_NEXT\n");
#endif
		dnext();				/* Debugger hook */
		break;

	/*
	 * Active breakpoint.
	 */
	case BC_BREAK:
#ifdef DEBUG
		dprintf(2)("BC_BREAK\n");
#endif
		dbreak(MTC PG_BREAK);		/* Debugger hook */
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


#ifdef CONCURRENT_EIFFEL
	/* The following instructions started with BC_SEP are used by
	 * Concurrent Eiffel.
	*/

	/* the current has called a separate feature in checking its
	 * pre-condition.
	*/
	case BC_SEP_SET:
#ifdef DEBUG
		dprintf(2)("BC_SEP_SET\n");
#endif
		has_called_sep_feature = 1;
		break;
	
	/* clear the flag indicating whether the current separate feature
	 * has called a separate feature call in its pre-condition 
	 * checking.
	*/
	case BC_SEP_UNSET:
#ifdef DEBUG
		dprintf(2)("BC_SEP_UNSET\n");
#endif
		has_called_sep_feature = 0;
		break;

	/* reserve separate parameters of the current feature which are
	 * used in at least one separate feature call.
	*/
	case BC_SEP_RESERVE: 
#ifdef DEBUG
		dprintf(2)("BC_SEP_RESERVE\n");
#endif
		{
			short nb_of_sep_paras;
			short sep_para_index[constant_max_number_of_sep_paras];
			short tmp_tyc;
			nb_of_sep_paras = get_short();
			for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; tmp_tyc++) {
				sep_para_index[tmp_tyc] = get_short();
			}
			for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; ) {
#ifdef SEP_DEBUG
				printf("Now, test %d parameter: %lx\n", sep_para_index[tmp_tyc]+1, ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref);
				if (Dtype(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref) != sep_obj_id) {
					printf ("Error, Dtype(%d)=%d\n", tmp_tyc, Dtype(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref));
				}
				else {
					printf("To Reserve <%s, %d, %d>\n", hostname_of_sep_obj(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref), pid_of_sep_obj(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref), oid_of_sep_obj(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref)); 
				}
#endif
				if (CURRSO(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref)) {
					for(tmp_tyc--; tmp_tyc >= 0; tmp_tyc--) {
						CURFSO(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref);
					}
					tmp_tyc = 0;
					CURRSFW;
				}
				else 
					tmp_tyc++;
			}
		}	
		break;

	/* free separate parameters of the current feature which are
	 * used in at least one  separate feature call.
	*/
	case BC_SEP_FREE: 
#ifdef DEBUG
		dprintf(2)("BC_SEP_FREE\n");
#endif
		{
			short nb_of_sep_paras;
			short tmp_tyc;
			nb_of_sep_paras = get_short();
			for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; tmp_tyc++) {
				CURFSO(ivalue(MTC IV_ARG, get_short())->it_ref);
			}
		}	
		break;

	/* change the local object stored in the top of the operation stack into 
	 * a separate object 
	*/
	case BC_SEP_TO_SEP:
#ifdef DEBUG
		dprintf(2)("BC_SEP_TO_SEP\n");
#endif
		otop()->it_ref = CURLTS(otop()->it_ref);
		break;

	/* to perform a separate external feature call */
	case BC_SEP_EXTERN:
	case BC_SEP_PEXTERN:
		is_extern = 1;
		/* Fall Through */

	/* to perform a separate feature call */
	case BC_SEP_FEATURE:
	case BC_SEP_PFEATURE:
		{
			short nb_of_paras;
			short tyc_tmp;
			struct item *tyc_last;
			EIF_REFERENCE tyc_current;
			uint32 ret_type;
			char need_ack;
			char *feature_name;
			char *class_name;
			char tyc_command = *(IC-1);

			int32 origin;

#ifdef DEBUG
			if (tyc_command == BC_SEP_FEATURE) {
				dprintf(2)("BC_SEP_FEATURE\n");
			} else if (tyc_command == BC_SEP_PFEATURE) {
				dprintf(2)("BC_SEP_PFEATURE\n");
			} else if (tyc_command == BC_SEP_EXTERN) {
				dprintf(2)("BC_SEP_EXTERN\n");
			} else if (tyc_command == BC_SEP_PEXTERN) {
				dprintf(2)("BC_SEP_PEXTERN\n");
			}
#endif
			nb_of_paras = get_short();	/* number of parameters */
			class_name = IC;			/* get the class name   */
			IC += strlen(IC) + 1;
			feature_name = IC;			/* get the feature name */
			IC += strlen(IC) + 1;
			ret_type = get_uint32();	/* Get the feature's return type */
			need_ack = *IC++;			/* if the proc needs acknowledgement */
#ifdef DEBUG
			dprintf(2)("	paras#=%d, class=%s, feature=%s, ret=%d\n", nb_of_paras, class_name, feature_name, ret_type & SK_HEAD);
#endif

			if (tyc_command == BC_SEP_FEATURE || tyc_command == BC_SEP_EXTERN) {
				offset = get_long(); 		/* Get the feature id */		
				code = get_short();   		/* Get the static type */
#ifdef DEBUG
			dprintf(2)("	offset=%d, code=%d\n", offset, code);
#endif
			} else if (tyc_command == BC_SEP_PFEATURE || tyc_command == BC_SEP_PEXTERN) {
				origin = get_long();		/* Get the origin class id */
				offset = get_long(); 		/* Get the offset in origin */
#ifdef DEBUG
			dprintf(2)("	origin=%d, offset=%d\n", origin, offset);
#endif
			}
			nstcall = 0;        		/* Invariant check turned off */

			if (on_local_processor(otop()->it_ref)) {
			/* execute the feature on the local processor */
 			/* In the current implementation, it's impossible for this part
			 * to be executed, because BC_SEP_FEXTURE, BC_SEP_PFEATURE, BC_SEP_EXTERN
			 * and BC_SEP_PEXTERN are possible only for the creation of a separate
			 * object, but the created separate object will never be on the local
			 * processor. 
			 */
				/* get the current object on the local processor */
				otop()->it_ref = CURPROXY_OBJ(otop()->it_ref); 
				if (tyc_command == BC_SEP_FEATURE || tyc_command == BC_SEP_EXTERN) {
					if (icall(MTC (int)offset, code, is_extern, GET_PTYPE))
						sync_registers(MTC scur, stop);
				} else if (tyc_command == BC_SEP_PFEATURE || tyc_command == BC_SEP_PEXTERN) {
					if (ipcall(origin, offset, is_extern, GET_PTYPE))
						sync_registers(MTC scur, stop);
				}
				/* if the return value's type is REFERENCE object, change it 
				 * into a separate object.
				*/
				switch (ret_type & SK_HEAD) {
					case SK_REF:
						/* change the return REFERENCE object into separate
						 * object.
						*/
						otop()->it_ref = CURLTS(otop()->it_ref);
						break;
					default:
						break;
				}
			}
			else {
			/* send a request to the remote processor */
				if ((ret_type & SK_HEAD) != SK_VOID) {
					CURSARI(constant_execute_query, oid_of_sep_obj(otop()->it_ref), constant_query, class_name, feature_name, nb_of_paras);
				}
				else {
					if (need_ack) {
						CURSARI(constant_execute_procedure, oid_of_sep_obj(otop()->it_ref), constant_procedure_with_ack, class_name, feature_name, nb_of_paras);
					} else {
						CURSARI(constant_execute_procedure, oid_of_sep_obj(otop()->it_ref), constant_procedure_without_ack, class_name, feature_name, nb_of_paras);
					}
				}
				tyc_current = henter(opop()->it_ref);
				for (tyc_tmp=nb_of_paras-1; tyc_tmp>=0; tyc_tmp--) {
					tyc_last = otop();
					/* The reason that I use the above statement and the following
					 * statement:
					 *	tyc_last = opop()
					 * instead of using
					 * 	tyc_last = opop(0)
					 * directly is that GC may move the corresponding object stored
					 * in the stack element but not change the information of the 
					 * stack element.
					 */
#ifdef SEP_DEBUG
	fprintf(stdout, "	Put %dth parameter with type %lx into %dth cell\n", tyc_tmp+1, tyc_last->type, tyc_tmp);
#endif
					switch (tyc_last->type & SK_HEAD) {
						case SK_BOOL: 
							CURPB(tyc_last->it_char, tyc_tmp); break;
						case SK_CHAR: 
							CURPC(tyc_last->it_char, tyc_tmp); break;
						case SK_INT: 
							CURPI(tyc_last->it_long, tyc_tmp); break;
						case SK_FLOAT:
							CURPR(tyc_last->it_float, tyc_tmp); break;
						case SK_DOUBLE:
							CURPD(tyc_last->it_double, tyc_tmp); break;
						case SK_REF:
							CURPSO(tyc_last->it_ref, tyc_tmp); break;
						case SK_POINTER:
							CURPP(tyc_last->it_ptr, tyc_tmp); break; 
						case SK_BIT:
						case SK_EXP:
						default:	
							add_nl;
							sprintf(crash_info, "    Not implemented type(0x%x) of separate feature.", tyc_last->type);
							c_raise_concur_exception(exception_implementation_error);
					}
					tyc_last = opop();
				}
				CURSG(eif_access(tyc_current));
				tyc_current = eif_wean(tyc_current);
				if ((ret_type & SK_HEAD) != SK_VOID) {
					last = iget();
					last->type = ret_type;
					switch (ret_type & SK_HEAD) {
						case SK_BOOL: 	last->it_char = (char)(CURGB(0)); break;
						case SK_CHAR: 	last->it_char = CURGC(0); break;
						case SK_INT: 	last->it_long = CURGI(0); break;
						case SK_FLOAT: 	last->it_float = CURGR(0); break;
						case SK_DOUBLE:	last->it_double = CURGD(0); break; 
						case SK_REF: 	last->it_ref = CURGSO(0); break;
						case SK_POINTER: last->it_ptr = CURGP(0); break;
						case SK_BIT: 
						case SK_EXP: 
						default:	
							add_nl;
							sprintf(crash_info, "    Not implemented type(0x%x) of separate feature.", ret_type);
							c_raise_concur_exception(exception_implementation_error);
					}
				}
			}
		}	
		is_extern = 0;
		break;


	/* to perform a separate external feature call */
	case BC_SEP_EXTERN_INV:
	case BC_SEP_PEXTERN_INV:
		is_extern = 1;
		/* Fall Through */

	/* to perform a separate feature call */
	case BC_SEP_FEATURE_INV:
	case BC_SEP_PFEATURE_INV:
		{
			short nb_of_paras;
			short tyc_tmp;
			struct item *tyc_last;
			EIF_REFERENCE tyc_current;
			uint32 ret_type;
			char need_ack;
			char *feature_name;
			char *class_name;
			char tyc_command = *(IC-1);

			int32 origin;

#ifdef DEBUG
			if (tyc_command == BC_SEP_FEATURE_INV) {
				dprintf(2)("BC_SEP_FEATURE_INV\n");
			} else if (tyc_command == BC_SEP_PFEATURE_INV) {
				dprintf(2)("BC_SEP_PFEATURE_INV\n");
			} else if (tyc_command == BC_SEP_EXTERN_INV) {
				dprintf(2)("BC_SEP_EXTERN_INV\n");
			} else if (tyc_command == BC_SEP_PEXTERN_INV) {
				dprintf(2)("BC_SEP_PEXTERN_INV\n");
			}
#endif
			nb_of_paras = get_short();	/* number of parameters */
			class_name = IC;			/* get the class name   */
			IC += strlen(IC) + 1;
			feature_name = IC;			/* get the feature name */
			IC += strlen(IC) + 1;
			ret_type = get_uint32();	/* Get the feature's return type */
			need_ack = *IC++;			/* if the proc needs acknowledgement */
#ifdef DEBUG
			dprintf(2)("	paras#=%d, class=%s, feature=%s, ret_type=0x%lx\n", nb_of_paras, class_name, feature_name, ret_type);
#endif

			string = feature_name;
			if (otop()->it_ref == (char *) 0) /* Called on a void reference? */
				eraise(string, EN_VOID); 	/* Yes, raise exception */
			if (tyc_command == BC_SEP_FEATURE_INV || tyc_command == BC_SEP_EXTERN_INV) {
				offset = get_long(); 		/* Get the feature id */		
				code = get_short();   		/* Get the static type */
#ifdef DEBUG
			dprintf(2)("	offset=%d, code=%d\n", offset, code);
#endif
			} else if (tyc_command == BC_SEP_PFEATURE_INV || tyc_command == BC_SEP_PEXTERN_INV) {
				origin = get_long();		/* Get the origin class id */
				offset = get_long(); 		/* Get the offset in origin */
#ifdef DEBUG
			dprintf(2)("	origin=%d, offset=%d\n", origin, offset);
#endif
			}
			nstcall = 1;        		/* Invariant check turned on */

			if (on_local_processor(otop()->it_ref)) {
			/* execute the feature on the local processor */
				/* get the current object on the local processor */
				otop()->it_ref = CURPROXY_OBJ(otop()->it_ref); 
				if (tyc_command == BC_SEP_FEATURE_INV || tyc_command == BC_SEP_EXTERN_INV) {
					if (icall(MTC (int)offset, code, is_extern, GET_PTYPE))
						sync_registers(MTC scur, stop);
				} else if (tyc_command == BC_SEP_PFEATURE_INV || tyc_command == BC_SEP_PEXTERN_INV) {
					if (ipcall(origin, offset, is_extern, GET_PTYPE))
						sync_registers(MTC scur, stop);
				}
				/* if the return value's type is REFERENCE object, change it 
				 * into a separate object.
				*/
				switch (ret_type & SK_HEAD) {
					case SK_REF:
						/* change the return REFERENCE object into separate
						 * object.
						*/
						otop()->it_ref = CURLTS(otop()->it_ref);
						break;
					default:
						break;
				}
			}
			else {
			/* send a request to the remote processor */
				if ((ret_type & SK_HEAD) != SK_VOID) {
					CURSARI(constant_execute_query, oid_of_sep_obj(otop()->it_ref), constant_query, class_name, feature_name, nb_of_paras);
				}
				else {
					if (need_ack) {
						CURSARI(constant_execute_procedure, oid_of_sep_obj(otop()->it_ref), constant_procedure_with_ack, class_name, feature_name, nb_of_paras);
					} else {
						CURSARI(constant_execute_procedure, oid_of_sep_obj(otop()->it_ref), constant_procedure_without_ack, class_name, feature_name, nb_of_paras);
					}
				}
				tyc_current = henter(opop()->it_ref);
				for (tyc_tmp=nb_of_paras-1; tyc_tmp>=0; tyc_tmp--) {
					tyc_last = otop();
					/* The reason that I use the above statement and the following
					 * statement:
					 *	tyc_last = opop()
					 * instead of using
					 * 	tyc_last = opop(0)
					 * directly is that GC may move the corresponding object stored
					 * in the stack element but not change the information of the 
					 * stack element.
					 */
#ifdef SEP_DEBUG
	fprintf(stdout, "	Put %dth parameter with type %lx into %dth cell\n", tyc_tmp+1, tyc_last->type, tyc_tmp);
#endif
					switch (tyc_last->type & SK_HEAD) {
						case SK_BOOL: 
							CURPB(tyc_last->it_char, tyc_tmp); break;
						case SK_CHAR: 
							CURPC(tyc_last->it_char, tyc_tmp); break;
						case SK_INT: 
							CURPI(tyc_last->it_long, tyc_tmp); break;
						case SK_FLOAT:
							CURPR(tyc_last->it_float, tyc_tmp); break;
						case SK_DOUBLE:
							CURPD(tyc_last->it_double, tyc_tmp); break;
						case SK_REF:
							CURPSO(tyc_last->it_ref, tyc_tmp); break;
						case SK_POINTER:
							CURPP(tyc_last->it_ptr, tyc_tmp); break;
						case SK_BIT:
						case SK_EXP:
						default:	
							add_nl;
							sprintf(crash_info, "    Not implemented type(0x%x) of separate feature.", tyc_last->type);
							c_raise_concur_exception(exception_implementation_error);
					}
					tyc_last = opop();
				}
				CURSG(eif_access(tyc_current));
				tyc_current = eif_wean(tyc_current);
				if ((ret_type & SK_HEAD) != SK_VOID) {
					last = iget();
					last->type = ret_type;
					switch (ret_type & SK_HEAD) {
						case SK_BOOL: 	last->it_char = (char)(CURGB(0)); break;
						case SK_CHAR: 	last->it_char = CURGC(0); break;
						case SK_INT: 	last->it_long = CURGI(0); break;
						case SK_FLOAT: 	last->it_float = CURGR(0); break;
						case SK_DOUBLE:	last->it_double = CURGD(0); break; 
						case SK_REF: 	last->it_ref = CURGSO(0); break;
						case SK_POINTER:last->it_ptr = CURGP(0); break; 
						case SK_BIT: 
						case SK_EXP: 
						default:	
							add_nl;
							sprintf(crash_info, "    Not implemented type(0x%x) of separate feature.", ret_type);
							c_raise_concur_exception(exception_implementation_error);
					}
				}
			}
		}	
		is_extern = 0;
		break;

	/* to perform a separate attribute call */
	case BC_SEP_ATTRIBUTE_INV:
	case BC_SEP_PATTRIBUTE_INV:
		{
			uint32 ret_type;
			char *feature_name;
			char *class_name;
			char tyc_command = *(IC-1);
			struct item *tyc_current;

			int32 origin, ooffset;

#ifdef DEBUG
			if (tyc_command == BC_SEP_ATTRIBUTE_INV) {
				dprintf(2)("BC_SEP_ATTRIBUTE_INV\n");
			} else if (tyc_command == BC_SEP_PATTRIBUTE_INV) {
				dprintf(2)("BC_SEP_PATTRIBUTE_INV\n");
			}
#endif
			class_name = IC;			/* get the class name   */
			IC += strlen(IC) + 1;
			feature_name = IC;			/* get the feature name */
			IC += strlen(IC) + 1;

#ifdef DEBUG
			dprintf(2)("	class=%s, feature=%s\n", class_name, feature_name);
#endif
			string = feature_name;
			if (otop()->it_ref == (char *) 0)
				eraise(string, EN_VOID);
			if (tyc_command == BC_SEP_ATTRIBUTE_INV) {
				offset = get_long();  			/* Get feature id */ 
				code = get_short();        		/* Get static type */
#ifdef DEBUG
			dprintf(2)("	offset=%d, code=%d, ", offset, code);
#endif
			} else if (tyc_command == BC_SEP_PATTRIBUTE_INV) {
				origin = get_long();   			/* Get the origin class id */
				ooffset = get_long();			/* Get the offset in origin */
#ifdef DEBUG
			dprintf(2)("	origin=%d, offset=%d, ", origin, ooffset);
#endif
			}
			ret_type = get_uint32();		/* Get attribute meta-type */
#ifdef DEBUG
			dprintf(2)(" ret_type=0x%lx\n", ret_type);
#endif
			
			if (on_local_processor(otop()->it_ref)) {
			/* execute the attribute on the local processor */
				/* get the current object on the local processor */
				otop()->it_ref = CURPROXY_OBJ(otop()->it_ref); 
				if (tyc_command == BC_SEP_ATTRIBUTE_INV) {
					interp_access((int)offset, code, ret_type);
				} else if (tyc_command == BC_SEP_PATTRIBUTE_INV) {
					interp_paccess(origin, ooffset, ret_type);
				}
				/* if the return value's type is REFERENCE object, change it 
				 * into a separate object.
				*/
				switch (ret_type & SK_HEAD) {
					case SK_REF:
						/* change the return REFERENCE object into separate
						 * object.
						*/
						otop()->it_ref = CURLTS(otop()->it_ref);
						break;
					default:
						break;
				}
			}
			else {
			/* send a request to the remote processor */
				CURSARI(constant_execute_query, oid_of_sep_obj(otop()->it_ref), constant_attribute, class_name, feature_name, 0);
				tyc_current = otop();
				CURSG(tyc_current->it_ref);
				tyc_current = opop();
				if ((ret_type & SK_HEAD) != SK_VOID) {
					last = iget();
					last->type = ret_type;
					switch (ret_type & SK_HEAD) {
						case SK_BOOL: 	last->it_char = (char)(CURGB(0)); break;
						case SK_CHAR: 	last->it_char = CURGC(0); break;
						case SK_INT: 	last->it_long = CURGI(0); break;
						case SK_FLOAT: 	last->it_float = CURGR(0); break;
						case SK_DOUBLE:	last->it_double = CURGD(0); break; 
						case SK_REF: 	last->it_ref = CURGSO(0); break;
						case SK_POINTER:last->it_ptr = CURGP(0); break; 
						case SK_BIT: 
						case SK_EXP: 
						default:	
							add_nl;
							sprintf(crash_info, "    Not implemented type(0x%x) of separate attribute.", ret_type);
							c_raise_concur_exception(exception_implementation_error);
					}
				}
			}
		}	
		break;

	/*
	 * process the failure of precondition checking with separate feature call(s)
	 */
	case BC_SEP_RAISE_PREC:
#ifdef DEBUG
		dprintf(2)("BC_SEP_RAISE_PREC\n");
#endif
		{
			short nb_of_sep_paras;
			short sep_para_index[constant_max_number_of_sep_paras];
			short tmp_tyc;
			char reserve_cmd = *IC++;
			if (reserve_cmd != BC_SEP_RESERVE) {
#ifdef DEBUG
		dprintf(2)("expect BC_SEP_RESERVE\n");
#endif
			}
			nb_of_sep_paras = get_short();
			for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; tmp_tyc++) {
				sep_para_index[tmp_tyc] = get_short();
			}
			offset = get_long(); 		/* get the offset to the point to recheck
										 * the pre-condition.
										*/
			if (!has_called_sep_feature) {
				RTCF;
			}
			else {
				RTCK;
				in_first_block = '\01';
				pre_success = '\01';
				/* free the separate parameters */
				for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; tmp_tyc++) {
					CURFSO(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref);

				}
				/* wait some time */
				CURCSPFW;
				/* reserve the separate parameters */
				for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; ) {
					if (CURRSO(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref)) {
						for(tmp_tyc--; tmp_tyc >= 0; tmp_tyc--) {
							CURFSO(ivalue(MTC IV_ARG, sep_para_index[tmp_tyc])->it_ref);
						}
						tmp_tyc = 0;
						CURRSFW;
					}
					else {
						tmp_tyc++;
					}
				}
				IC += offset;
				/* "has_called_sep_feature" will be unset by the next statement, 
				 * i.e, the instruction to which we will jump must be "BC_SEP_UNSET"
				 */
			}
		}	
		break;

	/* create separate object */
	case BC_SEP_CREATE:
		{
			char *class_name, *feature_name;
			struct item *tyc_last;
			class_name = IC;
			IC += strlen(IC) + 1;
			feature_name = IC;
			IC += strlen(IC) + 1;
#ifdef DEBUG
		dprintf(2)("BC_SEP_CREATE on %s with procedure <%s>\n", class_name, feature_name);
#endif
#ifdef SEP_DEBUG
fprintf(stdout, "$$$$$$$$$$ Before CREATE_SEP_OBJ, STACK_TOP=%lx\n", otop()); 
#endif
			last = iget();
			last->type = SK_REF;
			CURCCI(class_name, feature_name);
			CURCC(last->it_ref);
#ifdef SEP_DEBUG
fprintf(stdout, "$$$$$$$$$$Created separate obj <%s, %d, %d> on <%s, %d>\n", hostname_of_sep_obj(last->it_ref), pid_of_sep_obj(last->it_ref), oid_of_sep_obj(last->it_ref), _concur_hostname, _concur_pid); 
#endif
			if (strlen(feature_name)) {
			/* make a copy of the reference to the new-born separate object, because
			 * in the case, we have to release the reservation to the new-born 
			 * separate object later(after its creation feature is performed).
			 */
				tyc_last = last;
				last = iget();
				last->type = SK_REF;
				last->it_ref = tyc_last->it_ref;
				CURRSO(last->it_ref);
				has_reserved_new_born_sep = 1;
			}
			else 
				has_reserved_new_born_sep = 0;
		}
		break;

	/* finishing creating separate object */
	case BC_SEP_CREATE_END:
#ifdef DEBUG
		dprintf(2)("BC_SEP_CREATE_END\n");
#endif
		if (has_reserved_new_born_sep) {
			CURFSO(opop()->it_ref);
		}
#ifdef SEP_DEBUG
fprintf(stdout, "$$$$$$$$$$  After CREATE_SEP_OBJ, STACK_TOP=%lx\n", otop()); 
#endif
		break;

/* end of inserted instructions for Concurrent Eiffel */
#endif


	/*
	 * End of rescue clause
	 */
	case BC_END_RESCUE:
#ifdef DEBUG
		dprintf(2)("BC_END_RESCUE\n");
#endif
		RTEF;
		goto null;	/* RTOK skipped */

	/*
	 * End of current Eiffel routine.
	 */
	case BC_NULL:
#ifdef DEBUG
		dprintf(2)("BC_NULL\n");
#endif
		if (rescue != (char *) 0)
			RTOK;
null:

		if (is_nested)		/* Nested feature call (dot notation) */
			icheck_inv(MTC icurrent->it_ref, scur, stop, 1);	/* Invariant */
		pop_registers();	/* Pop registers */
		RTEE;				/* Remove vector pushed by RTEA */
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
	}							/* Remember: indentation was wrong--RAM */
	/* NOTREACHED */
	EIF_END_GET_CONTEXT
}

#ifndef EIF_THREADS
/*
 * Invariant checking
 */
char *inv_mark_table;	/* Marking table to avoid checking the same
									 * invariant several times
									 */ /* %%ss mt */
#endif /* EIF_THREADS */

rt_private void icheck_inv(EIF_CONTEXT char *obj, struct stochunk *scur, struct item *stop, int where)          
					  		/* Current chunk (stack context) */
							/* To save stack context */
		  					/* Invariant after or before */
{
	EIF_GET_CONTEXT
	/* Check invariant on non-void object `obj' */
	char *old_IC;		/* IC backup */
	union overhead *zone = HEADER(obj);
	int dtype = Dtype(obj);

	if (inv_mark_table == (char *) 0)
		if ((inv_mark_table = (char *) cmalloc (scount * sizeof(char))) == (char *) 0)
			enomem(MTC_NOARG);

	bzero (inv_mark_table, scount);

	if (~in_assertion & WASC(dtype) & CK_INVARIANT) {
		old_IC = IC;				/* Save IC */
		irecursive_chkinv(MTC dtype, obj, scur, stop, where);
		IC = old_IC;				/* Restore IC */
	}
	EIF_END_GET_CONTEXT
}

rt_private void irecursive_chkinv(EIF_CONTEXT int dtype, char *obj, struct stochunk *scur, struct item *stop, int where)
		  
		  
					  		/* Current chunk (stack context) */
				  			/* To save stack context */
		  					/* Invariant after or before */
{
	/* Recursive invariant check. */

	EIF_GET_CONTEXT
	struct cnode *node = esystem + dtype;
	int *cn_parents;
	int p_type;

	if (dtype <= 2) return;		/* ANY, GENERAL and PLATFORM do not have invariants */

	if ((char) 0 != inv_mark_table[dtype])	/* Already checked */
		return;
	else
		inv_mark_table[dtype] = (char) 1;	/* Mark as checked */

	/* Automatic protection of `obj' */
	epush(&loc_stack, (char *)(&obj));

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
		uint32 body_id;
		uint16 body_index;
		struct item *last;

		CBodyIdx(body_index,INVARIANT_ID,dtype);	
		if (body_index != INVALID_INDEX) {
			body_id = dispatch[body_index];
			if (body_id < zeroc) { 				/* Frozen invariant */
				unsigned long stagval = tagval;	/* Tag value backup */
	
				((void (*)()) egc_frozen[body_id])(obj, where);
	
				if (tagval != stagval)			/* Resynchronize registers */
					sync_registers(MTC scur, stop);
	
			} else 
#ifndef DLE
			{				/* Melted invariant */
				last = iget();					/* Push `obj' */
				last->type = SK_REF;
				last->it_ref = obj;

				/*IC = melt[body_id];
				/*interpret(INTERP_INVA, where);/* Interpret invariant code */

				/* The proper way to start the interpretation of a melted
		 		* invariant code is to call `xiinv' in order to initialize the
		 		* calling context (which is not done by `interpret').
		 		* `tagval' will therefore be set, but we have to 
				* resynchronize the registers anyway. --ericb
		 		*/
				xiinv(MTC melt[body_id], where);

				sync_registers(MTC scur, stop);		/* Resynchronize registers */
			}
#else
			if (body_id < dle_level) {
					/* Static melted invariant */
				last = iget();					/* Push `obj' */
				last->type = SK_REF;
				last->it_ref = obj;

				xiinv(MTC melt[body_id], where);
				sync_registers(MTC scur, stop);		/* Resynchronize registers */
			} else if (body_id < dle_zeroc) {
					/* Dynamic frozen invariant */
				unsigned long stagval = tagval;	/* Tag value backup */
				((void (*)()) dle_frozen[body_id])(obj, where);
				if (tagval != stagval)			/* Resynchronize registers */
					sync_registers(MTC scur, stop);
			} else {
					/* Dynamic melted invariant */
				last = iget();					/* Push `obj' */
				last->type = SK_REF;
				last->it_ref = obj;

				xiinv(MTC dle_melt[body_id], where);
				sync_registers(MTC scur, stop);		/* Resynchronize registers */
			}
#endif
		}
	}

	/* No more propection for `obj' */
	epop(&loc_stack, 1);

	EIF_END_GET_CONTEXT
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
		case SK_INT:	first->it_long = -first->it_long; break;
		case SK_FLOAT:	first->it_float = -first->it_float; break;
		case SK_DOUBLE:	first->it_double = -first->it_double; break;
		default:
			eif_panic(MTC botched);
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
		case SK_BOOL: first->it_char = !first->it_char; break;
		default:
			eif_panic(MTC botched);
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
#define b break

	second = opop();			/* Fetch second operand */
	first = otop();				/* First operand will be replace by result */

	switch (code) {				/* Execute operation */

	/*
	 * And operation (boolean).
	 */
	case BC_AND:
#ifdef DEBUG
		dprintf(2)("BC_AND\n");
#endif
		first->it_char = first->it_char && second->it_char;
		break;

	/*
	 * Or operation (boolean).
	 */
	case BC_OR:
#ifdef DEBUG
		dprintf(2)("BC_OR\n");
#endif
		first->it_char = first->it_char || second->it_char;
		break;

	/*
	 * Xor operation (boolean).
	 */
	case BC_XOR:
#ifdef DEBUG
		dprintf(2)("BC_XOR\n");
#endif
		first->it_char = (first->it_char && !second->it_char) ||
			(!first->it_char && second->it_char);
		break;

	/*
	 * Lesser or equal operation.
	 */
	case BC_LE:		/* Lesser or equal op */
#ifdef DEBUG
		dprintf(2)("BC_LE\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_CHAR: first->it_char = first->it_char <= second->it_char; break;
		case SK_INT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_long <= s->it_long; b;
			case SK_FLOAT: f->it_char = (float) f->it_long <= s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_long <= s->it_double; b;
			default: eif_panic(botched);
			}
			break;
		case SK_FLOAT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_float <= (float) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_float <= s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_float <= s->it_double; b;
			default: eif_panic(botched);
			}
			break;
		case SK_DOUBLE:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_double <= (double) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_double <= (double) s->it_float; b;
			case SK_DOUBLE: f->it_char = f->it_double <= s->it_double; b;
			default: eif_panic(botched);
			}
			break;
		default: eif_panic(MTC botched);
		}
		first->type = SK_BOOL;		/* Result is a boolean */
		break;

	/*
	 * Lesser than operation.
	 */
	case BC_LT:
#ifdef DEBUG
		dprintf(2)("BC_LT\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_CHAR: first->it_char = first->it_char < second->it_char; break;
		case SK_INT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_long < s->it_long; b;
			case SK_FLOAT: f->it_char = (float) f->it_long < s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_long < s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_float < (float) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_float < s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_float < s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_double < (double) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_double < (double) s->it_float; b;
			case SK_DOUBLE: f->it_char = f->it_double < s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		default: eif_panic(MTC botched);
		}
		first->type = SK_BOOL;		/* Result is a boolean */
		break;

	/*
	 * Equality operation.
	 */
	case BC_EQ:
#ifdef DEBUG
		dprintf(2)("BC_EQ\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR: first->it_char = first->it_char == second->it_char; break;
		case SK_INT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_long == s->it_long; b;
			case SK_FLOAT: f->it_char = (float) f->it_long == s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_long == s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_float == (float) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_float == s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_float == s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_double == (double) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_double == (double) s->it_float; b;
			case SK_DOUBLE: f->it_char = f->it_double == s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_REF:
			first->it_char = first->it_ref == second->it_ref;
			break;
		case SK_POINTER:
			first->it_char = first->it_ptr == second->it_ptr;
			break;
		default: eif_panic(MTC botched);
		}
		first->type = SK_BOOL;		/* Result is a boolean */
		break;

	/*
	 * Greater or equal operation.
	 */
	case BC_GE:
#ifdef DEBUG
		dprintf(2)("BC_GE\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_CHAR: first->it_char = first->it_char >= second->it_char; break;
		case SK_INT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_long >= s->it_long; b;
			case SK_FLOAT: f->it_char = (float) f->it_long >= s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_long >= s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_float >= (float) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_float >= s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_float >= s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_double >= (double) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_double >= (double) s->it_float; b;
			case SK_DOUBLE: f->it_char = f->it_double >= s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		default:
			eif_panic(MTC botched);
		}
		first->type = SK_BOOL;		/* Result is a boolean */
		break;

	/*
	 * Greater than operation.
	 */
	case BC_GT:
#ifdef DEBUG
		dprintf(2)("BC_GT\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_CHAR: first->it_char = first->it_char > second->it_char; break;
		case SK_INT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_long > s->it_long; b;
			case SK_FLOAT: f->it_char = (float) f->it_long > s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_long > s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_float > (float) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_float > s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_float > s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_double > (double) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_double > (double) s->it_float; b;
			case SK_DOUBLE: f->it_char = f->it_double > s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		default: eif_panic(MTC botched);
		}
		first->type = SK_BOOL;		/* Result is a boolean */
		break;

	/*
	 * Different operation (not equal).
	 */
	case BC_NE:
#ifdef DEBUG
		dprintf(2)("BC_NE\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR:
			first->it_char = first->it_char != second->it_char; break;
		case SK_INT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_long != s->it_long; b;
			case SK_FLOAT: f->it_char = (float) f->it_long != s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_long != s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_float != (float) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_float != s->it_float; b;
			case SK_DOUBLE: f->it_char = (double) f->it_float != s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_char = f->it_double != (double) s->it_long; b;
			case SK_FLOAT: f->it_char = f->it_double != (double) s->it_float; b;
			case SK_DOUBLE: f->it_char = f->it_double != s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_REF:
			first->it_char = first->it_ref != second->it_ref;
			break;
		case SK_POINTER:
			first->it_char = first->it_ptr != second->it_ptr;
			break;
		default: eif_panic(MTC botched);
		}
		first->type = SK_BOOL;		/* Result is a boolean */
		break;

	/*
	 * Minus operation.
	 */
	case BC_MINUS:
#ifdef DEBUG
		dprintf(2)("BC_MINUS\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_INT:
			first->type = second->type;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_long = f->it_long - s->it_long; b;
			case SK_FLOAT: f->it_float = (float) f->it_long - s->it_float; b;
			case SK_DOUBLE: f->it_double = (double) f->it_long - s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			first->type = second->type == SK_DOUBLE ? SK_DOUBLE : SK_FLOAT;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_float = f->it_float - (float) s->it_long; b;
			case SK_FLOAT: f->it_float = f->it_float - s->it_float; b;
			case SK_DOUBLE: f->it_double = (double) f->it_float - s->it_double;b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			first->type = SK_DOUBLE;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_double = f->it_double - (double) s->it_long; b;
			case SK_FLOAT: f->it_double = f->it_double - (double) s->it_float; b;
			case SK_DOUBLE: f->it_double = f->it_double - s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		default: eif_panic(MTC botched);
		}
		break;

	/*
	 * Modulo operator.
	 */
	case BC_MOD:
#ifdef DEBUG
		dprintf(2)("BC_MOD\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_INT: first->it_long = first->it_long % second->it_long; break;
		default: eif_panic(MTC botched);
		}
		break;

	/*
	 * Plus operator.
	 */

	case BC_PLUS:
#ifdef DEBUG
		dprintf(2)("BC_PLUS\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_INT:
			first->type = second->type;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_long = f->it_long + s->it_long; b;
			case SK_FLOAT: f->it_float = (float) f->it_long + s->it_float; b;
			case SK_DOUBLE: f->it_double = (double) f->it_long + s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			first->type = second->type == SK_DOUBLE ? SK_DOUBLE : SK_FLOAT;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_float = f->it_float + (float) s->it_long; b;
			case SK_FLOAT: f->it_float = f->it_float + s->it_float; b;
			case SK_DOUBLE: f->it_double = (double) f->it_float + s->it_double;b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			first->type = SK_DOUBLE;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_double = f->it_double + (double) s->it_long; b;
			case SK_FLOAT: f->it_double = f->it_double + (double) s->it_float; b;
			case SK_DOUBLE: f->it_double = f->it_double + s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		default:
			eif_panic(MTC botched);
		}
		break;

	/*
	 * Power operator.
	 */
	case BC_POWER:
#ifdef DEBUG
		dprintf(2)("BC_POWER\n");
#endif
		switch (first->type & SK_HEAD) {
			case SK_INT:
				switch (second->type & SK_HEAD) {
				case SK_INT: f->it_double = (double) pow ((double)f->it_long, (double)s->it_long); b;
				case SK_FLOAT: f->it_double = (double) pow ((double)f->it_long, (double)s->it_float); b;
				case SK_DOUBLE: f->it_double = (double) pow ((double)f->it_long, (double)s->it_double); b;
				default: eif_panic(MTC botched);
				}
				first->type = SK_DOUBLE;
				break;
			case SK_FLOAT:
				switch (second->type & SK_HEAD) {
				case SK_INT: f->it_double = (double) pow ((double)f->it_float, (double)s->it_long); b;
				case SK_FLOAT: f->it_double = (double) pow ((double)f->it_float, (double)s->it_float); b;
				case SK_DOUBLE: f->it_double = (double) pow ((double)f->it_float, (double)s->it_double); b;
				default: eif_panic(MTC botched);
				}
				first->type = SK_DOUBLE;
				break;
			case SK_DOUBLE:
				switch (second->type & SK_HEAD) {
				case SK_INT: f->it_double = (double) pow ((double)f->it_double, (double)s->it_long); b;
				case SK_FLOAT: f->it_double = (double) pow ((double)f->it_double, (double)s->it_float); b;
				case SK_DOUBLE: f->it_double = (double) pow ((double)f->it_double, (double)s->it_double); b;
				default: eif_panic(MTC botched);
				}
				first->type = SK_DOUBLE;
				break;
		default:
			eif_panic(MTC botched);
		}
		break;

	/*
	 * Multiplication operator.
	 */
	case BC_STAR:
		switch(first->type & SK_HEAD) {
		case SK_INT:
			first->type = second->type;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_long = f->it_long * s->it_long; b;
			case SK_FLOAT: f->it_float = (float) f->it_long * s->it_float; b;
			case SK_DOUBLE: f->it_double = (double) f->it_long * s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			first->type = second->type == SK_DOUBLE ? SK_DOUBLE : SK_FLOAT;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_float = f->it_float * (float) s->it_long; b;
			case SK_FLOAT: f->it_float = f->it_float * s->it_float; b;
			case SK_DOUBLE: f->it_double = (double) f->it_float * s->it_double;b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			first->type = SK_DOUBLE;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_double = f->it_double * (double) s->it_long; b;
			case SK_FLOAT: f->it_double = f->it_double * (double) s->it_float; b;
			case SK_DOUBLE: f->it_double = f->it_double * s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		default:
			eif_panic(MTC botched);
		}
		break;

	/*
	 * Real division operator.
	 */
	case BC_SLASH:
#ifdef DEBUG
		dprintf(2)("BC_SLASH\n");
#endif
		switch(first->type & SK_HEAD) {

		case SK_INT:
			first->type = second->type;
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_double = (double) f->it_long / s->it_long;	
						f->type = SK_DOUBLE; b;
			case SK_FLOAT: f->it_float = (float) f->it_long / s->it_float; b;
			case SK_DOUBLE: f->it_double = (double) f->it_long / s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_FLOAT:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_float = f->it_float / (float) s->it_long; b;
			case SK_FLOAT: f->it_float = f->it_float / s->it_float; b;
			case SK_DOUBLE: f->it_double = (double) f->it_float / s->it_double;
							f->type = SK_DOUBLE; b;
			default: eif_panic(MTC botched);
			}
			break;
		case SK_DOUBLE:
			switch (second->type & SK_HEAD) {
			case SK_INT: f->it_double = f->it_double / (double) s->it_long; b;
			case SK_FLOAT: f->it_double = f->it_double / (double) s->it_float; b;
			case SK_DOUBLE: f->it_double = f->it_double / s->it_double; b;
			default: eif_panic(MTC botched);
			}
			break;
		default:
			eif_panic(MTC botched);
		}
		break;

	/*
	 * Integer division operator.
	 */
	case BC_DIV:	/* Integer division op */
#ifdef DEBUG
		dprintf(2)("BC_DIV\n");
#endif
		switch(first->type & SK_HEAD) {
		case SK_INT: first->it_long = first->it_long / second->it_long; break;
		default: eif_panic(MTC botched);
		}
		break;
	default:
		eif_panic(MTC "invalid diadic opcode");
		/* NOTREACHED */
	}

#undef b
#undef s
#undef f
}


/*
 * Function calling routines
 */

rt_private int icall(EIF_CONTEXT int fid, int stype, int is_extern, int ptype)
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

	EIF_GET_CONTEXT
	uint32 body;					/* Value of selected body ID */
	unsigned long stagval = tagval;	/* Save tag value */
	char *old_IC;					/* IC back-up */
	int result = 0;					/* A priori, no need for sync_registers */
	uint32 pid;						/* Pattern id of the frozen feature */
	int32 rout_id;
	uint16 body_index;	
	

	rout_id = Routids(stype)[fid];

	if (ptype == -1)
	{
		CBodyIdx(body_index,rout_id,Dtype(otop()->it_ref));
	}
	else
	{
		CBodyIdx(body_index,rout_id,RTUD(ptype));
	}
	body = dispatch[body_index];	/* Body id of the eiffel routine */
	old_IC = IC;				/* IC back up */
	if (body < zeroc) {			/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body);
		(pattern[pid].toc)(egc_frozen[body], is_extern); /* Call pattern */
		if (tagval != stagval)		/* Interpreted function called */
			result = 1;				/* Resynchronize registers */
	} else 
#ifndef DLE
	{
	
		/*IC = melt[body];					/* Melted byte code */
		/*interpret(INTERP_CMPD, 0);		/* Interpret (tagval not set) */

		/* The proper way to start the interpretation of a melted
		 * feature is to call `xinterp' in order to initialize the
		 * calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to 
		 * resynchronize the registers anyway. --ericb
		 */
		xinterp(MTC melt[body]);
	
		result = 1;							/* Compulsory synchronisation */
	}
#else
	if (body < dle_level) {
			/* Static melted routine */
		xinterp(MTC melt[body]);
		result = 1;							/* Compulsory synchronisation */
	} else if (body < dle_zeroc) {
			/* Dynamic frozen routine */
		pid = (uint32) DLEFPatId(body);
		(pattern[pid].toc)(dle_frozen[body], is_extern); /* Call pattern */
		if (tagval != stagval)		/* Interpreted function called */
			result = 1;				/* Resynchronize registers */
	} else {
			/* Dynamic melted routine */
		xinterp(MTC dle_melt[body]);
		result = 1;							/* Compulsory synchronisation */
	}
#endif
	IC = old_IC;					/* Restore IC back-up */
	return result;

	EIF_END_GET_CONTEXT
}

rt_private int ipcall(EIF_CONTEXT int32 origin, int32 offset, int is_extern, int ptype)
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

	EIF_GET_CONTEXT
	uint32 body;					/* Value of selected body ID */
	unsigned long stagval = tagval;	/* Save tag value */
	char *old_IC;					/* IC back-up */
	int result = 0;					/* A priori, no need for sync_registers */
	uint32 pid;						/* Pattern id of the frozen feature */
	int16 body_index;

	if (ptype == -1)
	{
		body_index = desc_tab[origin][Dtype(otop()->it_ref)][offset].info;
	}
	else
	{
		body_index = desc_tab[origin][RTUD(ptype)][offset].info;
	}

	body = dispatch[body_index];	/* Body id of the eiffel routine */
	old_IC = IC;				/* IC back up */
	if (body < zeroc) {			/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body);
		(pattern[pid].toc)(egc_frozen[body], is_extern); /* Call pattern */
		if (tagval != stagval)		/* Interpreted function called */
			result = 1;				/* Resynchronize registers */
	} else 
#ifndef DLE
	{
	
		/*IC = melt[body];					/* Melted byte code */
		/*interpret(INTERP_CMPD, 0);		/* Interpret (tagval not set) */

		/* The proper way to start the interpretation of a melted
		 * feature is to call `xinterp' in order to initialize the
		 * calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to 
		 * resynchronize the registers anyway. --ericb
		 */
		xinterp(MTC melt[body]);
	
		result = 1;							/* Compulsory synchronisation */
	}
#else
	if (body < dle_level) {
			/* Static melted routine */
		xinterp(MTC melt[body]);
		result = 1;							/* Compulsory synchronisation */
	} else if (body < dle_zeroc) {
			/* Dynamic frozen routine */
		pid = (uint32) DLEFPatId(body);
		(pattern[pid].toc)(dle_frozen[body], is_extern); /* Call pattern */
		if (tagval != stagval)		/* Interpreted function called */
			result = 1;				/* Resynchronize registers */
	} else {
			/* Dynamic melted routine */
		xinterp(MTC dle_melt[body]);
		result = 1;							/* Compulsory synchronisation */
	}
#endif
	IC = old_IC;					/* Restore IC back-up */
	return result;

	EIF_END_GET_CONTEXT
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

	char *current;							/* Current object */
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
	case SK_INT: last->it_long = *(long *) (current + offset); break;
	case SK_FLOAT: last->it_float = *(float *) (current + offset); break;
	case SK_DOUBLE: last->it_double = *(double *) (current + offset); break;
	case SK_BIT: last->it_bit = (current + offset); break;
	case SK_POINTER: last->it_ptr = *(char **) (current + offset); break;
	case SK_REF: last->it_ref = *(char **) (current + offset); break;
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

	char *current;							/* Current object */
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
	case SK_INT: last->it_long = *(long *) (current + offset); break;
	case SK_FLOAT: last->it_float = *(float *) (current + offset); break;
	case SK_DOUBLE: last->it_double = *(double *) (current + offset); break;
	case SK_BIT: last->it_bit = (current + offset); break;
	case SK_POINTER: last->it_ptr = *(char **) (current + offset); break;
	case SK_REF: last->it_ref = *(char **) (current + offset); break;
	case SK_EXP: last->it_ref = (current + offset); break;
	default:
		eif_panic(MTC "unknown attribute type");
		/* NOTREACHED */
	}
}

rt_private void assign(EIF_CONTEXT long int fid, int stype, uint32 type)
		 				/* Feature ID */
		  				/* Static type (entity where feature is applied) */
						/* Attribute meta-type */
{
	/* Assign the value on top of the stack to the attribute described by its
	 * name (fid) and the static type where it is declared (stype). The value
	 * is then popped off from the stack.
	 */
	
	EIF_GET_CONTEXT
	long offset;					/* Offset of the attribute */
	struct item *last;				/* Value on top of the stack */
	/* struct ac_info *info;*/ /* Attribute access information */ /* %%ss removed */
	char *ref;

	/* Attribute access information evaluation */
	offset = RTWA(stype, fid, icur_dtype);

	last = opop();					/* Value to be assigned */

#define l last
#define b break
#define i icurrent

	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR: *(i->it_ref + offset) = l->it_char; b;
	case SK_INT:
		switch (last->type) {
		case SK_INT: *(long *)(i->it_ref + offset) = l->it_long; b;
		case SK_FLOAT: *(long *) (i->it_ref + offset) = (long) l->it_float; b;
		case SK_DOUBLE: *(long *) (i->it_ref + offset) = (long) l->it_double; b;
		default: eif_panic(MTC unknown_type);
		}
		break;
	case SK_FLOAT:
		switch (last->type) {
		case SK_FLOAT: *(float *) (i->it_ref + offset) = l->it_float; b;
		case SK_DOUBLE: *(float *) (i->it_ref + offset) = (float) l->it_double;b;
		default: eif_panic(MTC unknown_type);
		}
		break;
	case SK_DOUBLE: *(double *) (i->it_ref + offset) = l->it_double; b;
	case SK_POINTER: *(char **) (i->it_ref + offset) = l->it_ptr; b;
	case SK_BIT: b_copy(l->it_bit, i->it_ref + offset); b;
	case SK_REF:
		/* Perform aging tests: if the reference is new and is assigned to an
		 * old object which is not yet remembered, then we need to put it in
		 * the remembered set. This has to be done before doing the actual
		 * assignment, as RTAR may call eremb() which in turn may call the GC.
		 */
		ref = icurrent->it_ref;
		RTAR(last->it_ref, ref);
		*(char **) (ref + offset) = last->it_ref;
		break;
	default: eif_panic(MTC unknown_type);
	}


#undef i
#undef b
#undef l

	EIF_END_GET_CONTEXT
}

rt_private void passign(EIF_CONTEXT int32 origin, int32 f_offset, uint32 type)
			 			/* Origin class ID of the attribute.*/
			   			/* offset of the feature in the origin class */
						/* Attribute meta-type */
{
	/* Assign the value on top of the stack to the attribute described by its
	 * origin class `origin' and with offset `offset' in that class. The value
	 * is then popped off from the stack.
	 */
	
	EIF_GET_CONTEXT
	long offset;					/* Offset of the attribute */
	struct item *last;				/* Value on top of the stack */
	/* struct ac_info *info;*/ /* Attribute access information */ /* %%ss removed */
	char *ref;

	/* Attribute access information evaluation */
	offset = RTWPA(origin, f_offset, icur_dtype);

	last = opop();					/* Value to be assigned */

#define l last
#define b break
#define i icurrent

	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR: *(i->it_ref + offset) = l->it_char; b;
	case SK_INT:
		switch (last->type) {
		case SK_INT: *(long *)(i->it_ref + offset) = l->it_long; b;
		case SK_FLOAT: *(long *) (i->it_ref + offset) = (long) l->it_float; b;
		case SK_DOUBLE: *(long *) (i->it_ref + offset) = (long) l->it_double; b;
		default: eif_panic(MTC unknown_type);
		}
		break;
	case SK_FLOAT:
		switch (last->type) {
		case SK_FLOAT: *(float *) (i->it_ref + offset) = l->it_float; b;
		case SK_DOUBLE: *(float *) (i->it_ref + offset) = (float) l->it_double;b;
		default: eif_panic(MTC unknown_type);
		}
		break;
	case SK_DOUBLE: *(double *) (i->it_ref + offset) = l->it_double; b;
	case SK_POINTER: *(char **) (i->it_ref + offset) = l->it_ptr; b;
	case SK_BIT: b_copy(l->it_bit, i->it_ref + offset); b;
	case SK_REF:
		/* Perform aging tests: if the reference is new and is assigned to an
		 * old object which is not yet remembered, then we need to put it in
		 * the remembered set. This has to be done before doing the actual
		 * assignment, as RTAR may call eremb() which in turn may call the GC.
		 */
		ref = icurrent->it_ref;
		RTAR(last->it_ref, ref);
		*(char **) (ref + offset) = last->it_ref;
		break;
	default: eif_panic(MTC unknown_type);
	}


#undef i
#undef b
#undef l

	EIF_END_GET_CONTEXT
}

void call_disp(EIF_CONTEXT uint32 dtype, char *object)
{
	/* Save the interpreter counter and restore it after the dispose
	 * routine for `object' with dynamic type `dtype'.
	 */
	EIF_GET_CONTEXT
	char *OLD_IC;
	OLD_IC = IC;
	(wdisp (dtype))(object);
	IC = OLD_IC;

	EIF_END_GET_CONTEXT
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
		last->it_ptr = (char *) RTWPPR(stype, fid);
	else
		last->it_ptr = (char *) RTWPP(stype, fid);
}


/*
 * Get constants from byte code in an hopefully portable (slow) way--RAM.
 */

rt_private double get_double(EIF_CONTEXT_NOARG)
{
	/* Get double stored at IC in byte code array. The value has been stored
	 * correctly by the exchange driver between the workbench and the process.
	 * The following should be highly portable--RAM.
	 */
	EIF_GET_CONTEXT
	union {
		char xtract[sizeof(double)];
		double value;
	} xdouble;
	register1 char *p = (char *) &xdouble;
	register2 int i;

	for (i = 0; i < sizeof(double); i++)
		*p++ = *IC++;

	return *(double *) &xdouble;	/* Correctly aligned by union */

	EIF_END_GET_CONTEXT
}

rt_private float get_float(EIF_CONTEXT_NOARG)
{
	/* Get float stored at IC in byte code array. The value has been stored
	 * correctly by the exchange driver between the workbench and the process.
	 * The following should be highly portable--RAM.
	 */
	EIF_GET_CONTEXT
	union {
		char xtract[sizeof(float)];
		float value;
	} xfloat;
	register1 char *p = (char *) &xfloat;
	register2 int i;

	for (i = 0; i < sizeof(float); i++)
		*p++ = *IC++;
	
	return *(float *) &xfloat;		/* Correctly aligned by union */

	EIF_END_GET_CONTEXT
}

rt_private long get_long(EIF_CONTEXT_NOARG)
{
	/* Get long int stored at IC in byte code array. The value has been stored
	 * correctly by the exchange driver between the workbench and the process.
	 * The following should be highly portable--RAM.
	 */
	EIF_GET_CONTEXT
	union {
		char xtract[sizeof(long)];
		long value;
	} xlong;
	register1 char *p = (char *) &xlong;
	register2 int i;

	for (i = 0; i < sizeof(long); i++)
		*p++ = *IC++;
	
	return *(long *) &xlong;		/* Correctly aligned by union */

	EIF_END_GET_CONTEXT
}

rt_private short get_short(EIF_CONTEXT_NOARG)
{
	/* Get short int stored at IC in byte code array. The value has been stored
	 * correctly by the exchange driver between the workbench and the process.
	 * The following should be highly portable--RAM.
	 */
	EIF_GET_CONTEXT
	union {
		char xtract[sizeof(short)];
		short value;
	} xshort;
	register1 char *p = (char *) &xshort;
	register2 int i;

	for (i = 0; i < sizeof(short); i++)
		*p++ = *IC++;
	
	return *(short *) &xshort;		/* Correctly aligned by union */

	EIF_END_GET_CONTEXT
}

rt_private uint32 get_uint32(EIF_CONTEXT_NOARG)
{
	/* Get uint32 stored at IC in byte code array. The value has been stored
	 * correctly by the exchange driver between the workbench and the process.
	 * The following should be highly portable--RAM.
	 */
	EIF_GET_CONTEXT
	union {
		char xtract[sizeof(uint32)];
		uint32 value;
	} xuint32;
	register1 char *p = (char *) &xuint32;
	register2 int i;

	for (i = 0; i < sizeof(uint32); i++)
		*p++ = *IC++;

	return *(uint32 *) &xuint32;	  /* Correctly aligned by union */

	EIF_END_GET_CONTEXT
}

rt_private fnptr get_fnptr(EIF_CONTEXT_NOARG)
{
	/* Get a fnptr stored at IC in byte code array. The value has been stored
	 * correctly by the exchange driver between the workbench and the process.
	 * The following should be highly portable--RAM.
	 */
	EIF_GET_CONTEXT
	union {
		char xtract[sizeof(fnptr)];
		fnptr value;
	} xfnptr;
	register1 char *p = (char *) &xfnptr;
	register2 int i;

	for (i = 0; i < sizeof(fnptr); i++)
		*p++ = *IC++;
	
	return *(fnptr *) &xfnptr;		/* Correctly aligned by union */

	EIF_END_GET_CONTEXT
}

rt_private char *get_address(EIF_CONTEXT_NOARG)
{
	/* Get an address stored at IC in byte code array. The value has been stored
	 * correctly by the exchange driver between the workbench and the process.
	 * The following should be highly portable--RAM.
	 */
	EIF_GET_CONTEXT
	union {
		char xtract[sizeof(char *)];
		char *value;
	} xaddress;
	register1 char *p = (char *) &xaddress;
	register2 int i;

	for (i = 0; i < sizeof(char *); i++)
		*p++ = *IC++;
	
	return *(char **) &xaddress;	/* Correctly aligned by union */

	EIF_END_GET_CONTEXT
}

rt_private short get_compound_id(EIF_CONTEXT char *Current, short dtype)
{
	/* Get array of short ints and convert it to a compound id. */
	EIF_GET_CONTEXT
	int16   gen_types [MAX_CID_SIZE+1], *gp, last;
	int     cnt, pos;

	gp  = gen_types;
	cnt = 0;

	do
	{
		*(gp++) = last = (int16) get_short();
		++cnt;

		/* Check for anchors */

		switch (last)
		{
			case -11: /* like argument */
						pos = (int) get_short();
						*(gp++) = (int16) RTCA(arg(pos)->it_ref, -10);
						++cnt;
						break;
			case -12: /* like Current */
						*(gp++) = (int16) (icur_dftype);
						++cnt;
						break;
			case -13: /* like feature - see BC_PCLIKE */
						{
							short stype;
							int32 origin, ooffset;

							stype = get_short();			/* Get static type of caller */
							origin = get_long();			/* Get the origin class id */
							ooffset = get_long();			/* Get the offset in origin */
							*(gp++) = (int16) RTWPCT(stype, origin, ooffset, icurrent->it_ref);
							++cnt;
						}
						break;
			case -14: /* like feature - see BC_CLIKE */
						{
							short code;
							long  offset;

							code = get_short();		/* Get the static type first */
							offset = get_long();	/* Get the feature id of the anchor */
							*(gp++) = RTWCT(code, offset, icurrent->it_ref);
							++cnt;
						}
						break;
			default:
						break;
		}

		if (cnt >= MAX_CID_SIZE)
			eif_panic(MTC "Too many generic paramters in compound type");

	} while (last != -1);

	/* If not generic then return dtype */

	if (cnt <= 2)
		return dtype;
	
	return (short) RTCID((int16 *)0,Current, (int16) dtype, gen_types);

	EIF_END_GET_CONTEXT
}

/*
 * Write constants to byte code in an hopefully portable (slow) way--RAM.
 */

rt_private void write_long(char *where, long int value)
{
	/* Write 'value' in possibly mis-aligned address 'where' */

	union {
		char xtract[sizeof(long)];
		long value;
	} xlong;
	register1 char *p = (char *) &xlong;
	register2 int i;

	xlong.value = value;

	for (i = 0; i < sizeof(long); i++)
		*where++ = *p++;
}

rt_private void write_float(char *where, float value)
{
	/* Write 'value' in possibly mis-aligned address 'where' */

	union {
		char xtract[sizeof(float)];
		float value;
	} xfloat;
	register1 char *p = (char *) &xfloat;
	register2 int i;

	xfloat.value = value;

	for (i = 0; i < sizeof(float); i++)
		*where++ = *p++;
}

rt_private void write_double(char *where, double value)
{
	/* Write 'value' in possibly mis-aligned address 'where' */

	union {
		char xtract[sizeof(double)];
		double value;
	} xdouble;
	register1 char *p = (char *) &xdouble;
	register2 int i;

	xdouble.value = value;

	for (i = 0; i < sizeof(double); i++)
		*where++ = *p++;
}

rt_private void write_fnptr(char *where, fnptr value)
{
	/* Write 'value' in possibly mis-aligned address 'where' */

	union {
		char xtract[sizeof(fnptr)];
		fnptr value;
	} xfnptr;
	register1 char *p = (char *) &xfnptr;
	register2 int i;

	xfnptr.value = value;

	for (i = 0; i < sizeof(fnptr); i++)
		*where++ = *p++;
}

rt_private void write_address(char *where, char *value)
{
	/* Write 'value' in possibly mis-aligned address 'where' */

	union {
		char xtract[sizeof(char *)];
		char *value;
	} xaddress;
	register1 char *p = (char *) &xaddress;
	register2 int i;

	xaddress.value = value;

	for (i = 0; i < sizeof(char *); i++)
		*where++ = *p++;
}


/*
 * Calling protocol
 */

rt_private void init_var(struct item *ptr, long int type, char *current_ref)
{
	/* Initializes variable 'ptr' to be of type 'type' */
	short dtype;

	ptr->type = type;					/* Set to correct type */

	switch (type & SK_HEAD) {
	case SK_BOOL:
	case SK_CHAR:		ptr->it_char = (char) 0; break;
	case SK_INT:		ptr->it_long = (long) 0; break;
	case SK_FLOAT:		ptr->it_float = (float) 0; break;
	case SK_DOUBLE:		ptr->it_double = (double) 0; break;
	case SK_BIT:		ptr->it_ref = (char *)0; break;
	case SK_EXP:		dtype = get_short ();
						dtype = get_compound_id(MTC current_ref, (short) dtype);
						ptr->type = (type & EO_UPPER) | ((uint32) dtype);
						ptr->it_ref = (char *) 0;
						break;
	case SK_REF:		ptr->it_ref = (char *) 0; break;
	case SK_POINTER:	ptr->it_ptr = (char *) 0; break;
	case SK_VOID:		break;
	default:			eif_panic(MTC unknown_type);
	}
}

rt_private void init_registers(EIF_CONTEXT_NOARG)
{
	/* Upon entry in a new feature, given that locnum and argnum are set,
	 * initialize the register array, poping the registers from the stack,
	 * setting all the locals to zero, the value of current, etc...
	 * It's part of the calling protocol to find in the byte code the
	 * informations about the type of each variable. They are retrieved here.
	 */

	EIF_GET_CONTEXT
	register1 int n;				/* # of locals/arguments to be fetched */
	register2 struct item **reg;	/* Pointer in register array */
	register3 struct item *last;	/* Initialization of stack frame */
	struct opstack op_context;		/* To save stack's context */
	char *current;					/* Saved value of current */

	allocate_registers(MTC);			/* Make sure array is big enough */

	current = opop()->it_ref;		/* Save value of current */

	/* Upon entry in the routine, all the arguments were pushed in reverse
	 * order, followed by the value of Current. In order to initialize the
	 * interpreter's registers, we need to walk backwards through the stack,
	 * after having saved the stack context.
	 */

#ifdef USE_STRUCT_COPY
	op_context = op_stack;			/* Save stack's context */
#else
	bcopy(&op_stack, &op_context, sizeof(struct opstack));
#endif

	reg = iregs + SPECIAL_REG + locnum + argnum - 1; /* Start of arguments */
	for (n = 0; n < argnum; n++, reg--)		/* Pushed in reverse order */
		*reg = opop();						/* Get its address */

#ifdef USE_STRUCT_COPY
	op_stack = op_context;			/* Restore stack's context */
#else
	bcopy(&op_context, &op_stack, sizeof(struct opstack));
#endif

	/* Now loop and fetch the local variables type directly from the byte
	 * code. Put them on the stack and record the address of each of them in
	 * the register's array. All variables are initialized to zero.
	 */

	reg = iregs + SPECIAL_REG;				/* Start of locals */
	for (n = 0; n < locnum; n++, reg++) {	/* Pushed in order */
		last = iget();
		init_var(last, get_long(), current);			/* Initialize to zero */
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
	last->type = SK_INT;			/* By default, avoid GC traversal */

	ilocnum = last= iget();			/* Push # of locals */
	last->type = SK_INT;			/* Initializes record */
	last->it_long = locnum;			/* Got this from byte code */

	iargnum = last = iget();		/* Push # of arguments */
	last->type = SK_INT;			/* Initializes record */
	last->it_long = argnum;			/* Got this from byte code */

	EIF_END_GET_CONTEXT
}

rt_private void allocate_registers(EIF_CONTEXT_NOARG)
{
	/* Automagically increase/decrease the size of the register array. If its
	 * size is too small, then of course we try to extend it. However, it it's
	 * too big (bigger than REGISTER_SIZE) and the number of times it has been
	 * so big (without real need) is greater than BIGGER_LIMIT, then its size
	 * is reduced to REGISTER_SIZE.
	 * Assumes locnum and argnum are already set. Raises a critical out of
	 * memory exception is register array cannot be created.
	 */

	EIF_GET_CONTEXT
	static int bigger = 0;			/* Records # of time array is bigger */
	register1 int size;				/* Size of iregs array */
	register2 struct item **new;	/* New location for array extension */

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
	EIF_END_GET_CONTEXT
}

rt_shared void sync_registers(EIF_CONTEXT struct stochunk *stack_cur, struct item *stack_top)
						   		/* Saved current chunk of op stack */
					   			/* Saved top of op stack */
{
	/* Whenever an interpreted function is called, the register array is
	 * reset to match registers for the new function. When we regain control
	 * in the original function, we have to re-synchronize the array.
	 * This is rather a slow routine, because it makes lots ot otop() and
	 * opop() calls--RAM.
	 */

	EIF_GET_CONTEXT
	register1 int n;				/* Loop index */
	register2 struct item **reg;	/* Address in register's array */
	struct opstack op_context;		/* To save stack's context */
	
#ifdef USE_STRUCT_COPY
	op_context = op_stack;			/* Save stack's context */
#else
	bcopy(&op_stack, &op_context, sizeof(struct opstack));
#endif

	/* Restore the context the stack was in just after we had initialized the
	 * registers upon routine entrance (calling protocol).
	 */
	op_stack.st_cur = stack_cur;			/* Restore stack context */
	op_stack.st_top = stack_top;			/* Saved top */
	op_stack.st_end = stack_cur->sk_end;	/* End of current chunk */

	/* The stack is now in the state it had right after the initial settings.
	 * Start by filling in the special registers (appear in reverse order).
	 */
	for (n = 0, reg = iregs + SPECIAL_REG - 1; n < SPECIAL_REG; n++, reg--)
		*reg = opop();

	locnum = ilocnum->it_long;		/* # of local variables */
	argnum = iargnum->it_long;		/* # of arguments */
	allocate_registers(MTC);			/* `iregs' could have been reduced */

	/* Local variables also appear in reverse order */
	for (n = 0, reg = iregs+locnum+SPECIAL_REG-1; n < locnum; n++, reg--)
		*reg = opop();

	/* Finally, arguments appear in reverse order */
	for (n = 0, reg = iregs+locnum+SPECIAL_REG+argnum-1; n < argnum; n++, reg--)
		*reg = opop();

#ifdef USE_STRUCT_COPY
	op_stack = op_context;			/* Restore stack's context */
#else
	bcopy(&op_context, &op_stack, sizeof(struct opstack));
#endif

	/* Finally, we must not forget the debugging hooks. Running this routine
	 * certainly means we have called another interpreted feature and the
	 * debugging cached information have been disturbed.
	 */
	
	dsync();						/* Resynchronize cached status */

	EIF_END_GET_CONTEXT
}

rt_private void pop_registers(EIF_CONTEXT_NOARG)
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

	EIF_GET_CONTEXT
	register1 int nb_items;			/* Number of registers to be popped off */
	struct item *result;			/* To save the result */
	struct item saved_result;		/* Save value pointed to by iresult */

	nb_items = opop()->it_long;		/* This is the nummber of arguments */
	nb_items += otop()->it_long;	/* Add the number of locals */
	nb_items += SPECIAL_REG - 1;	/* Add Current, Result and ilocnum */

	/* Using npop() may truncate the unused chunks at the tail of the stack,
	 * which may free the chunk where results is stored if there where a lot
	 * of local variables, for instance. This means we must save the possible
	 * register value before popping items.
	 */
	bcopy(iresult, &saved_result, ITEM_SZ);

	npop(nb_items);			/* Remove items and eventually shrink stack */

	if (saved_result.type != SK_VOID) {	/* If Result is needed */
		result = iget();				/* Get a new result record */
		bcopy(&saved_result, result, ITEM_SZ);
	}

	EIF_END_GET_CONTEXT
}

/*
 * Operational stack handling.
 */

rt_private struct item *stack_allocate(EIF_CONTEXT register int size)
				   					/* Initial size */
{
	/* The operational stack is created, with size 'size'.
	 * Return the arena value (bottom of stack).
	 */

	EIF_GET_CONTEXT
	register2 struct item *arena;		/* Address for the arena */
	register3 struct stochunk *chunk;	/* Address of the chunk */

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
	EIF_END_GET_CONTEXT
}

/* Stack handling routine. The following code has been cut/paste from the one
 * found in garcol.c and local.c as of this day. Hence the similarities and the
 * possible differences. What changes basically is that instead of storing
 * (char *) elements, we now store (struct item) ones.
 */

rt_public struct item *opush(EIF_CONTEXT register struct item *val)
{
	/* Push value 'val' on top of the operational stack. If it fails, raise
	 * an "Out of memory" exception. If 'val' is a null pointer, simply
	 * get a new cell at the top of the stack.
	 */
	EIF_GET_CONTEXT
	register1 struct item *top = op_stack.st_top;	/* Top of stack */

	if (top == (struct item *) 0)	{			/* No stack yet? */
		top = stack_allocate(STACK_CHUNK);		/* Create one */
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
			if (-1 == stack_extend(STACK_CHUNK))
				enomem(MTC_NOARG);
			top = op_stack.st_top;					/* New top */
		} else {
			register2 struct stochunk *current;		/* New current chunk */

			/* Update the new stack context (main structure) */
			current = op_stack.st_cur = op_stack.st_cur->sk_next;
			top = op_stack.st_top = current->sk_arena;
			op_stack.st_end = current->sk_end;
		}
		SIGRESUME;				/* Restore signal handling */
	}

	op_stack.st_top = top + 1;			/* Points to next free location */
	if (val != (struct item *) 0)		/* If value was provided */
		bcopy(val, top, ITEM_SZ);		/* Push it on the stack */

	return top;				/* Address of allocated item */
	EIF_END_GET_CONTEXT
}

rt_private int stack_extend(EIF_CONTEXT register int size)
				   					/* Size of new chunk to be added */
{
	/* The operational stack is extended and the stack structure is updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */
	EIF_GET_CONTEXT
	register2 struct item *arena;		/* Address for the arena */
	register3 struct stochunk *chunk;	/* Address of the chunk */

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
	EIF_END_GET_CONTEXT
}

rt_public struct item *opop(EIF_CONTEXT_NOARG)
{
	/* Removes one item from the operational stack and return a pointer to
	 * the removed item, which also happens to be the first free location.
	 */
	EIF_GET_CONTEXT
	register1 struct item *top = op_stack.st_top;	/* Top of the stack */
	register2 struct stochunk *s;			/* To walk through stack chunks */
	register3 struct item *arena;			/* Base address of current chunk */

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
	EIF_END_GET_CONTEXT
}

rt_private void npop(EIF_CONTEXT register int nb_items)
{
	/* Removes 'nb_items' from the operational stack. Occasionaly, we also
	 * try to truncate the unused chunks from the tail of the stack. We do
	 * not do that in opop() because that would create an overhead...
	 */
	EIF_GET_CONTEXT
	register2 struct item *top;			/* Current top of operational stack */
	register3 struct stochunk *s;		/* To walk through stack chunks */
	register4 struct item *arena;		/* Base address of current chunk */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. That would indeed make popping very efficient.
	 */
	
	arena = op_stack.st_cur->sk_arena;
	top = op_stack.st_top;
	top -= nb_items;				/* Hopefully, we remain in current chunk */
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
	for (s = op_stack.st_cur; nb_items > 0; /* empty */) {
		arena = s->sk_arena;
		nb_items -= top - arena;
		if (nb_items <= 0) {			/* Have we gone too far? */
			top = arena - nb_items;		/* Yes, reset top correctly */
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
	EIF_END_GET_CONTEXT
}

rt_public struct item *otop(EIF_CONTEXT_NOARG)
{
	/* Returns a pointer to the top of the stack or a NULL pointer if
	 * stack is empty. I assume a value has already been pushed (i.e. the
	 * stack has been created).
	 */
	
	EIF_GET_CONTEXT
	register1 struct item *last_item;		/* Address of last item stored */
	register2 struct stochunk *prev;		/* Previous chunk in stack */

	last_item = op_stack.st_top - 1;
	if (last_item >= op_stack.st_cur->sk_arena)
		return last_item;
	
	/* It seems the current top of the stack (i.e. the next free location)
	 * is at the left edge of a chunk. Look for previous chunk then...
	 */
	prev = op_stack.st_cur->sk_prev;

#ifdef MAY_PANIC
	if (prev == (struct stochunk *) 0)
		eif_panic("operational stack is empty");
#endif
	
	return prev->sk_end - 1;			/* Last item of previous chunk */
	EIF_END_GET_CONTEXT
}

rt_private struct item *oitem(EIF_CONTEXT uint32 n)
{
	/* Returns a pointer to the item at position `n' down the stack or a NULL pointer if
	 * stack is empty. I assume a value has already been pushed (i.e. the
	 * stack has been created).
	 */
	
	EIF_GET_CONTEXT
	register1 struct item *last_item;		/* Address of last item stored */
	register2 struct stochunk *prev;		/* Previous chunk in stack */

	last_item = op_stack.st_top - 1 -n;
	if (last_item >= op_stack.st_cur->sk_arena)
		return last_item;

	/* It seems the item is at the left edge of a chunk. Look for previous chunk then...
	 */
	prev = op_stack.st_cur->sk_prev;

#ifdef MAY_PANIC
	if (prev == (struct stochunk *) 0)
		eif_panic("operational stack is empty");
#endif

	return prev->sk_end - 1 - (n - (op_stack.st_cur->sk_arena - last_item));
	EIF_END_GET_CONTEXT
}

rt_private void stack_truncate(EIF_CONTEXT_NOARG)
{
	/* Free unused chunks in the stack. If the current chunk has at least
	 * MIN_FREE locations, then we may free all the chunks starting with the
	 * next one. Otherwise, we skip the next chunk and free the remainder.
	 */

	EIF_GET_CONTEXT
	register2 struct item *top;		/* The current top of the stack */
	struct stochunk *next;			/* Address of next chunk */

	/* We know the program is running, because this function is only called
	 * via npop(), and npop() cannot be called by the debugger--RAM.
	 */

	top = op_stack.st_top;					/* The first free location */
	if (op_stack.st_end - top > MIN_FREE) {	/* Enough locations left */
		op_stack.st_tl = op_stack.st_cur;	/* Last chunk from now on */
		wipe_out(op_stack.st_cur->sk_next);	/* Free starting at next chunk */
	} else {								/* Current chunk is nearly full */
		next = op_stack.st_cur->sk_next;	/* We are followed by 'next' */
		if (next != (struct stochunk *) 0) {/* There is indeed a next chunk */
			op_stack.st_tl = next;			/* New tail chunk */
			wipe_out(next->sk_next);		/* Skip it, wipe out remainder */
		}
	}
	EIF_END_GET_CONTEXT
}

rt_private void wipe_out(register struct stochunk *chunk)
									/* First chunk to be freed */
{
	/* Free all the chunks after 'chunk' */

	register2 struct stochunk *next;	/* Address of next chunk */

	if (chunk == (struct stochunk *) 0)	/* No chunk */
		return;							/* Nothing to be done */

	chunk->sk_prev->sk_next = (struct stochunk *) 0;	/* Previous is last */

	for (
		next = chunk->sk_next;
		chunk != (struct stochunk *) 0;
		chunk = next, next = chunk ? chunk->sk_next : chunk
	)
		xfree((char *) chunk);
}

/*
 * For debugger: getting values of locals, arguments, Result and Current.
 */

/* VARARGS1 */
rt_public struct item *ivalue(EIF_CONTEXT int code, int num)
		 		/* Request code */
				/* Additional info for local and arguments */
{
	/* Extract information from the interpreter's registers. For local and
	 * arguments, a range checking is performmed and a null pointer returned
	 * if the information requested is invalid (e.g. when asking for local #4
	 * when there are only 2 of them). Requests for locals and arguments follow
	 * the usual C convention, i.e. start at 0.
	 * To avoid endless tests, there is a convention: if the routine has n
	 * locals, then n+1 is the result of the routine, if it exists.
	 */

	EIF_GET_CONTEXT

	switch (code) {
	case IV_LOCAL:						/* Nth local */
		if (num > ilocnum->it_long)
			return (struct item *) 0;			/* Out of range */
		else if (num == ilocnum->it_long) {		/* Off by one */
			if (iresult->type != SK_VOID)		/* If there is a result */
				return iresult;					/* Then return it */
			else
				return (struct item *) 0;		/* Else signal out of range */
		}
		return loc(num + 1);					/* Locals from 1 to ilocnum */
	case IV_ARG:						/* Nth argument */
		if (num >= iargnum->it_long)
			return (struct item *) 0;	/* Out of range */
		return arg(num + 1);			/* Arguments from 1 to iargnum */
	case IV_CURRENT:					/* Current */
		return icurrent;
	case IV_RESULT:						/* Result */
		return iresult;
	default:
		eif_panic(MTC "illegal value request");
	}

	/* NOTREACHED */
	EIF_END_GET_CONTEXT
}

#ifdef DEBUG
rt_private void dump_stack(void)
{
	/* Dumps the contents of the operational stack */

	register1 struct item *last;	/* For looping over subsidiary roots */
	register2 int roots;			/* Number of roots in each chunk */
	register3 struct stochunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */
	int i;

	/* There is no need to check for the existence of the operational stack:
	 * we know it has already been created.
	 */

	for (s = op_stack.st_hd; s && !done; s = s->sk_next) {
		last = s->sk_arena;						/* Start of stack */
		if (s != op_stack.st_cur)				/* Before current pos? */
			roots = s->sk_end - last;			/* The whole chunk */
		else {
			roots = op_stack.st_top - last;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

		printf("dump_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		for (i = 0; i < roots; i++, last++) {
			switch (last->type & SK_HEAD) {
			case SK_EXP:
				printf("	%d: expanded 0x%lx DT = %d\n", i,
					last->it_ref, Dtype(last->it_ref));
				break;
			case SK_REF:
				if (last->it_ref == (char *) 0)
					printf("	%d: 0x%lx\n", i, last->it_ref);
				else
					printf("	%d: 0x%lx DT = %d\n", i,
						last->it_ref, Dtype(last->it_ref));
				break;
			case SK_BOOL:
				printf("	%d: bool %s\n", i,
					last->it_char ? "true" : "false");
				break;
			case SK_CHAR:
				printf("	%d: char %d\n", i, last->it_char);
				break;
			case SK_INT:
				printf("	%d: int %ld\n", i, last->it_long);
				break;
			case SK_FLOAT:
				printf("	%d: float %f\n", i, last->it_float);
				break;
			case SK_DOUBLE:
				printf("	%d: double %lf\n", i, last->it_double);
				break;
			case SK_BIT:
				printf("	%d: BITS\n", i);
				break;
			case SK_POINTER:
				printf("	%d: pointer 0x%lx\n", i, last->it_ref);
				break;
			case SK_VOID:
				printf("	%d: void\n", i);
				break;
			default:
				printf("	%d: UNKNOWN TYPE 0x%lx\n", i, last->type);
			}
		}
	}
}

static void xiprint(struct item *last)
{
	/* Print a stack item */

	switch (last->type & SK_HEAD) {
	case SK_BOOL:
		dprintf(1)("BOOLEAN %s\n", (last->it_char ? "True" : "False"));
		break;
	case SK_CHAR:
		dprintf(1)("CHARACTER %c\n", last->it_char);
		break;
	case SK_INT:
		dprintf(1)("INTEGER %ld\n", last->it_long);
		break;
	case SK_FLOAT:	
		dprintf(1)("REAL %lf\n", last->it_float);
		break;
	case SK_DOUBLE:
		dprintf(1)("DOUBLE %lf\n", last->it_double);
		break;
	case SK_REF:
		{
			dprintf(1)("Reference: ");
			if (last->it_ref == (char *) 0) {
				dprintf(1)("Void\n");
			} else {
				dprintf(1)("%s\n", System(Dtype(last->it_ref)).cn_generator);
			}
		}
		break;
	}
}

static void xidebug(void)
{
	/* Print Current and arguments */

	int i;

	dprintf(1)("Current = ");
	xiprint(icurrent);
	for (i=1; i <= argnum; i++) {
		dprintf(1)("\targ #%d = ", i);
		xiprint(arg(i));
	}
	for (i=1; i <= locnum; i++) {
		dprintf(1)("\tloc #%d = ", i);
		xiprint(loc(i));
	}
}

static void xistack(int n)
{
	/* Print the `n' items on the top of the stack */

	struct opstack op_context;		/* To save stack's context */
	int i;

#ifdef USE_STRUCT_COPY
	op_context = op_stack;			/* Save stack's context */
#else
	bcopy(&op_stack, &op_context, sizeof(struct opstack));
#endif

	for (i=0 ; i<n ; i++) {
		dprintf(1)("top - %d : ", i);
		xiprint(opop());
	}

#ifdef USE_STRUCT_COPY
	op_stack = op_context;			/* Restore stack's context */
#else
	bcopy(&op_context, &op_stack, sizeof(struct opstack));
#endif
}

#endif

/*
 * Testing routines.
 */

#ifdef DEBUG
/*
 * Byte-code dumping routines.
 */

rt_public void idump(FILE *fd, char *start)
{
	/* Dumps an ASCII representation (disassembling) of byte code starting at
	 * IC and ending at BC_NULL. The dump is made in the file fd.
	 */
	char *old_IC = IC;
	long rout_id;
	register1 int code;
	register3 long offset;
	register4 char *string;
	uint32 body_id;
	int has_rescue = 0;
	int i;
	int is_once;

	IC = start;

	is_once = 0;

	if (*IC++)  /* Check once flag */
	{
		is_once = 1;

		IC += sizeof (long);    /* Skip flag and reserved space */
	}
		/*
	switch (code = *IC++) {		/* Read current byte-code and advance IC */

	/*
	 * Start of debuggable byte code.
	 */
	case BC_DEBUGABLE:
		offset = get_long();
		fprintf(fd, "0x%lX %s%d\n", IC - 1 - sizeof(long), "BC_DEBUGABLE #",
			offset);
		/* Fall through */

	/*
	 * Start of routine byte code.
	 */
	case BC_START:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_START");
		rout_id = get_long();
		fprintf(fd, "0x%lX rout_id = %ld\n", IC - sizeof(long), rout_id);
		offset = get_long();			/* Get the result type */
		fprintf(fd, "0x%lX %s 0x%lx\n", IC - sizeof(long), "RESULT type", offset);
		code = get_short();				/* Get the argument number */
		fprintf(fd, "0x%lX %s %d\n", IC - sizeof(short), "ARGS", code);

		if (is_once) {				/* If it is a once */
			body_id = (uint32) get_long();  /* Get the body id */
			fprintf(fd, "0x%lX %s 0x%lx\n", IC - sizeof(long), "Body id", body_id);

		} else
			fprintf(fd, "0x%lX %s\n", IC - 1, "not once");

		code = get_short();		/* Get the local number */
		fprintf(fd, "0x%lX %s %d\n", IC - sizeof(short), "LOCAL", code);
		for(i = 0; i < code; i++) {
			offset = get_long();
			fprintf(fd, "0x%lx loc(%d)->type = 0x%lx\n", IC - sizeof(long),
				i, offset);
		}
		while (*IC++ != BC_NO_CLONE_ARG) {
			if (*(IC - 1) != BC_CLONE_ARG) {
				fprintf(fd, "WARNING: 0x%lX should have been %d, was %d\n",
					IC - 1, BC_CLONE_ARG, (int) *(IC - 1));
				continue;
			}
			code = get_short();
			fprintf(fd, "0x%lX %s%d\n", IC - 1 - sizeof(short),
				"BC_CLONE_ARG #", code);
		}
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_NO_CLONE_ARG");

		if (rout_id != 0) {
			string = IC;
			IC += strlen(string) + 1;	/* Get the feature name */
			fprintf(fd, "0x%lX %s \"%s\"\n", string, "feature", string);
			code = get_short();			/* Dyn. type where feature is written */
			fprintf(fd, "0x%lX %s %d (%s)\n", IC - sizeof(short), "WRITTEN", code, System(code).cn_generator);
		}

		has_rescue = (int) *IC++;
		if (has_rescue) {
			offset = get_long();			/* Compute the rescue offset */
			fprintf(fd, "0x%lX %s 0x%lX\n", IC - 1, "RESCUE", IC + offset);
		} else
			fprintf(fd, "0x%lX %s\n", IC - 1, "no rescue");

		break;
	default:
		eif_panic(botched);
	}
	
	iinternal_dump(fd, IC);				/* Compound dump */
	if (has_rescue)
		iinternal_dump(fd, IC);			/* Rescue dump */

	IC = old_IC;
}
	
rt_private void iinternal_dump(FILE *fd, char *start)
{
	register1 int code;				/* Current intepreted byte code */
	register2 struct item *last;	/* Last pushed value */
	register3 long offset;			/* Offset for jumps and al */
	register4 char *string;			/* Strings for assertions tag */
	int type;						/* Stores type informations, usually */
	int i;
	double d;
	float f;

	IC = start;
	for (;;) {					/* Indentation is wrong on purpose--RAM */
	switch (code = *IC++) {		/* Read current byte-code and advance IC */

	/*
	 * Start of precondition check
 	 */
	case BC_PRECOND:
		fprintf(fd, "0x%lX %s, offset: %d\n", IC - 1, "BC_PRECOND", get_long());
		break;

	/*
	 * Start of postcondition check.
	 */
	case BC_POSTCOND:
		fprintf(fd, "0x%lX %s, offset: %d\n", IC - 1, "BC_POSTCOND", get_long());
		break;

	/*
	 * End of rescue compound
 	 */
	case BC_END_RESCUE:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_END_RECUE");
		return;

	/*
	 * Deferred compound mark.
	 */
	case BC_DEFERRED:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_DEFERRED");
		break;

	/*
	 * Rescue compound mark
	 */
	case BC_RESCUE:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_RESCUE");
		break;

	/*
	 * Assignment to result.
	 */
	case BC_RASSIGN:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_RASSIGN");
		break;

	/*
	 * Assignment to an expanded result
	 */
	case BC_REXP_ASSIGN:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_REXP_ASSIGN");
		break;

	/*
	 * Assignment to local variable.
	 */
	case BC_LASSIGN:
		code = get_short();		/* Get the local number (from 1 to locnum) */
		fprintf(fd, "0x%lX %s #%d\n", 
			IC - sizeof(short) - 1, "BC_LASSIGN", code);
		break;

	/*
	 * Assignment to a local expanded variable
	 */
	case BC_LEXP_ASSIGN:
		code = get_short();		/* Get the local number (from 1 to locnum) */
		fprintf(fd, "0x%lX %s #%d\n", IC - sizeof(short) - 1,
			"BC_LEXP_ASSIGN", code);
		break;

	/*
	 * Assignment to an attribute.
	 */
	case BC_ASSIGN:
	{ 								/* No new indent level--RAM */
		uint32 type;

		offset = get_long();		/* Get the feature id */
		code = get_short();			/* Get the static type */
		type = get_uint32();		/* Get attribute meta-type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d, meta-type=0x%lx\n",
			IC - sizeof(short) - sizeof(long) -sizeof(uint32) - 1,
			"BC_ASSIGN", offset, code, type);
	}
		break;

	/*
	 * Assignment to a precompiled attribute.
	 */
	case BC_PASSIGN:
	{ 								/* No new indent level--RAM */
		int32 origin, ooffset;
		uint32 type;

		origin = get_long();		/* Get the origin class id */
		ooffset = get_long();		/* Get the offset in origin */
		type = get_uint32();		/* Get attribute meta-type */
		fprintf(fd, "0x%lX %s origin=%ld, offset=%ld, meta-type=0x%lx\n",
			IC - sizeof(long) - sizeof(long) -sizeof(uint32) - 1,
			"BC_PASSIGN", origin, ooffset, type);
	}
		break;

	/*
	 * Assignment to an expanded attribute
	 */
	case BC_EXP_ASSIGN:
		offset = get_long();		/* Get the feature id */
		code = get_short();			/* Get the static type */
		type = get_short();			/* Get attribute meta-type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d\n",
			IC - sizeof(short) - sizeof(long) - sizeof(uint32) - 1,
			"BC_EXP_ASSIGN", offset, code);
		break;

	/*
	 * Assignment to a precompiled expanded attribute
	 */
	case BC_PEXP_ASSIGN:
		{
			int32 origin, ooffset;

			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			type = get_short();			/* Get attribute meta-type */
			fprintf(fd, "0x%lX %s origin=%ld, offset=%d\n",
				IC - sizeof(long) - sizeof(long) - sizeof(uint32) - 1,
				"BC_PEXP_ASSIGN", origin, ooffset);
			break;
		}

	/*
	 * Assignment to a NONE entity
	 */
	case BC_NONE_ASSIGN:
		fprintf(fd, "0x%lX BC_NONE_ASSIGN\n", IC - 1);
		break;

	/*
	 * Reverese assignment to Result.
	 */
	case BC_RREVERSE:
		type = get_short();			/* Get the reverse type */

/* GENERIC CONFORMANCE */
		while (get_short() != -1)
			;

		fprintf(fd, "0x%lX %s rt=%d\n", IC - sizeof(short) - 1,
			"BC_RREVERSE", type);
		break;

	/*
	 * Reverse assignment to a local variable.
	 */
	case BC_LREVERSE:
		code = get_short();			/* Get local number */
		type = get_short();			/* Get the reverse type */
/* GENERIC CONFORMANCE */
		while (get_short() != -1)
			;
		fprintf(fd, "0x%lX %s #%d, rt=%d\n", IC - 2 * sizeof(short) - 1,
			"BC_LREVERSE", code, type);
		break;
	
	/*
	 * Reverse assignment to an attribute.
	 */
	case BC_REVERSE:
		{
			uint32 meta;
			offset = get_long();		/* Get the feature id */
			code = get_short();			/* Get the static type */
			meta = get_uint32();		/* Get the attribute meta-type */
			type = get_short();			/* Get the reverse type */
/* GENERIC CONFORMANCE */
			while (get_short() != -1)
				;
			fprintf(fd, "0x%lX %s fid=%d, st=%d, rt=%d\n",
				IC - 2 * sizeof(short) - sizeof(long) - 1,
				"BC_REVERSE", offset, code, type);
		}
		break;

	/*
	 * Reverse assignment to a precompiled attribute.
	 */
	case BC_PREVERSE:
		{
			int32 origin, ooffset;
			uint32 meta;

			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			meta = get_uint32();		/* Get the attribute meta-type */
			type = get_short();			/* Get the reverse type */
/* GENERIC CONFORMANCE */
			while (get_short() != -1)
				;
			fprintf(fd, "0x%lX %s origin=%ld, offset=%ld, rt=%d\n",
				IC - 2 * sizeof(long) - sizeof(long) - 1,
				"BC_PREVERSE", origin, ooffset, type);
		}
		break;

	/*
	 * Clone of a reference
	 */
	case BC_CLONE:
		fprintf(fd,"0x%lX BC_CLONE\n", IC - 1);
		break;

	/*
	 * Exception "Void assigned to expanded"
	 */
	case BC_EXP_EXCEP:
		fprintf(fd, "0x%lX BC_EXP_EXCEP\n", IC - 1);
		break;

	/*
	 * Void reference
	 */
	case BC_VOID:
		fprintf(fd, "0x%lX BC_VOID\n", IC - 1);
		break;

	/*
	 * Check instruction.
	 */
	case BC_CHECK:
		offset = get_long();	/* Jump offset in assertion is not checked */
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_CHECK", IC + offset);
		break;

	/*
	 * Retry instruction
	 */
	case BC_RETRY:
		offset = get_long();	/* Retry offset */
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_RETRY", IC + offset);
		break;

	/*
	 * An Eiffel loop construct.
	 */
	case BC_LOOP:
		offset = get_long();	/* Jump offset if assertion is not checked */
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_LOOP", IC + offset);
		break;

	/*
	 * Assertion checking.
	 */
	case BC_ASSERT:
		{
			char *tag;
			char *start = IC - 1;

			switch (*IC++) {
			case BC_PRE: 	string = "EX_PRE"; break;
			case BC_PST:	string = "EX_POST"; break;
			case BC_CHK:	string = "EX_CHECK"; break;
			case BC_LINV:	string = "EX_LINV"; break;
			case BC_LVAR:	string = "EX_VAR"; break;
			case BC_INV:	string = "EX_CINV"; break;
			default:		string = "UNKNOWN"; break;
			}
			switch (*IC++) {				
			case BC_TAG:				/* Assertion tag */
				tag = IC;
				IC += strlen(IC) + 1;
				break;
			case BC_NOTAG:				/* No assertion tag */
				tag = "";
				break;
			case BC_NOT_REC:			/* Do nothing */
				tag = "TAG NOT RECORDED";
				break;
			default:
				tag = "UNKNOWN";
				break;
			}
			fprintf(fd, "0x%lX %s %s, \"%s\"\n", start,
				"BC_ASSERT", string, tag);
		}
		break;

	/*
	 * End of precondition in first block.
	 */
	case BC_END_FST_PRE:
		fprintf(fd, "0x%lX %s Offset = %d\n", IC - 1, "BC_END_FST_PRE", get_long());
		break;

	/*
	 * End of precondition.
	 */
	case BC_END_PRE:
		fprintf(fd, "0x%lX %s Offset=%d\n", IC - 1, "BC_END_PRE", get_long());
		break;

	/*
	 * Raise precondition violation 
	 */
	case BC_RAISE_PREC:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_RAISE_PREC");
		break;

	/*
	 * Go to the body of the routine. 
	 */
	case BC_GOTO_BODY:
		fprintf(fd, "0x%lX %s, offset: %d\n", IC - 1, "BC_GOTO_BODY", get_long());
		break;

	/*
	 * End of assertion.
	 */
	case BC_END_ASSERT:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_END_ASSERT");
		break;

	/*
	 * End of loop variant.
	 */
	case BC_END_VARIANT:
		code = get_short();
		fprintf(fd, "0x%lX %s %d\n", IC - 1, "BC_END_VARIANT", code);
		break;

	/*
	 * Initialization of the last variant recording variable.
	 */
	case BC_INIT_VARIANT:
		code = get_short();
		fprintf(fd, "0x%lX %s %d\n", IC - sizeof(long) - 1,
			"BC_INIT_VARIANT", code);
		break;

	/*
	 * Debug statement.
	 */
	case BC_DEBUG:
		offset = get_long();	/* Number of keys */
		fprintf(fd, "0x%lX %s %d\n", IC - sizeof(long) - 1,
			"BC_DEBUG", offset);
		if (offset > 0L) {
			int i;
			for (i = 0; i < offset; i++) {
				string = IC;						/* Get a debug key */
				IC += strlen(IC) + 1;
				fprintf(fd, "0x%lX DEBUG \"%s\"\n", string, string);
			}
		}
		offset = get_long();	/* Get the jump value */
		fprintf(fd, "0x%lX JUMP not debug 0x%lX\n", IC - sizeof(long),
			IC + offset);
		break;

	/*
	 * Invariant checking after creation
	 */
	case BC_CREAT_INV:
#ifdef DEBUG
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_CREAT_INV");
#endif
		break;

	/*
	 * Creation instruction.
	 */
	case BC_CREATE:
		switch (*IC++) {
		case BC_CTYPE:				/* Hardcoded creation type */
			type = get_short();
/* GENERIC CONFORMANCE */
			while (get_short() != -1)
				;

			fprintf(fd, "0x%lX BC_CREATE dt=%d\n", IC - sizeof(short) - 2,
				type);
			break;
		case BC_CARG:				/* Like argument creation type */
			type = get_short();		/* Default creation type if void arg.  */
/* GENERIC CONFORMANCE */
			while (get_short() != -1)
				;
			code = get_short();		/* Argument position */
			fprintf(fd, "0x%lX BC_CREATE dt=%d, arg=%d\n",
				IC - 2 * sizeof(short) - 2,
				type, code);
			break;
		case BC_CLIKE:				/* Like feature creation type */
			code = get_short();
			offset = get_long();	/* Get the routine id of the anchor */
			fprintf(fd, "0x%lX BC_CREATE fid=%d\n", 
				IC - sizeof(short) - sizeof(long) - 2, offset);
			break;
		case BC_PCLIKE:				/* Like (precomp) feature creation type */
			{
			int32 origin, ooffset;

			origin = get_long();			/* Get the origin class id */
			ooffset = get_long();			/* Get the offset in origin */
			fprintf(fd, "0x%lX BC_CREATE origin =%ld, offset = %ld\n", 
				IC - sizeof(long) - sizeof(long) - 2, origin, ooffset);
			break;
			}
		case BC_CCUR:				/* Like Current creation type */
			fprintf(fd, "0x%lX BC_CREATE current\n", IC - 2);
			break;
		default:
			fprintf(fd, "0x%lX UNKNOWN\n", IC - 2);
		}	
		break;

	/*
	 * Once case of multi-branch instruction (when part).
	 */
	case BC_RANGE:
		offset = get_long();		/* Get the jump value */
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_RANGE", IC + offset);
		break;
	
	/*
	 * End of multi-branch instruction.
	 */
	case BC_INSPECT:
		fprintf(fd, "0x%lX BC_INSPECT\n", IC - 1);
		break;

	/*
	 * Unmatched inspect value.
	 */
	case BC_INSPECT_EXCEP:
		fprintf(fd, "0x%lX BC_INSPECT_EXCEP\n", IC - 1);
		break;

	/*
	 * Call on a simple type.
	 */
	case BC_METAMORPHOSE:
		fprintf(fd, "0x%lX %s\n", IC - 1,
			"BC_METAMORPHOSE");
		break;

	/* 
	 * Creation of a manifest array
	 */
	case BC_ARRAY:
		{
			short stype, dtype, feat_id;
			long nbr_of_items;
			short is_tuple;

			stype = get_short();		/* Get the static type*/
			dtype = get_short();		/* Get the static type*/

/*GENERIC CONFORMANCE */
			while (get_short () != -1)
				;

			feat_id = get_short();		/* Get the feature id*/
			nbr_of_items = get_long();	/* Get the nbr of items in array*/
			is_tuple = get_short(); /* Is it actually a TUPLE?*/
			fprintf(fd, "0x%lX %s, st=%d dt=%d fid=%d nbr=%d\n",
				 	IC - (2*sizeof(short)) - sizeof(long) - 1, 
					"BC_ARRAY", stype, dtype, feat_id, nbr_of_items);
		}
		break;

	/* 
	 * Creation of a manifest array (when ARRAY is precompiled)
	 */
	case BC_PARRAY:
		{
			int32 origin, ooffset;
			short dtype;
			long nbr_of_items;
			short is_tuple;

			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			dtype = get_short();		/* Get the dynamic type*/

/*GENERIC CONFORMANCE */
			while (get_short () != -1)
				;
			nbr_of_items = get_long();	/* Get the nbr of items in array*/
			is_tuple = get_short(); /* Is it actually a TUPLE?*/
			fprintf(fd, "0x%lX %s, origin=%ld dt=%d offset=%ld nbr=%d\n",
				 	IC - (sizeof(short)) - (3*sizeof(long)) - 1, 
					"BC_PARRAY", origin, dtype, ooffset, nbr_of_items);
		}
		break;

	/* 
	 * Retrieve Old expression from local register
	 */
	case BC_RETRIEVE_OLD:
		fprintf(fd, "0x%lX %s local #: %d\n", IC - 1, "BC_RETRIEVE_OLD", get_short());
		break;
	
	/* 
	 * Save Old expression into local register
	 */
	case BC_OLD:
		fprintf(fd, "0x%lX %s local #: %d\n", IC - 1, "BC_OLD", get_short());
		break;

	/*
	 * Beginning of old evaluation
	 */
	case BC_START_EVAL_OLD:
		fprintf(fd, "0x%lX %s offset: %d\n", IC - 1, "BC_START_EVAL_OLD", get_long());
		break;
		
	/*
	 * End of old evaluation
	 */
	case BC_END_EVAL_OLD:
		fprintf(fd, "0x%lX %s\n", IC - 1, "BC_END_EVAL_OLD");
		break;
	
	/* 
	 * Add strip fid 
	 */
	case BC_ADD_STRIP:
		string = IC;
		IC += strlen(IC) + 1;
		fprintf(fd, "0x%lX %s \"%s\"\n", string - 1, "BC_ADD_STRIP", string);
		break;
	
	/* 
	 * End strip 
	 */
	case BC_END_STRIP:
		{
			short s_type, d_type;
			long nbr;
			s_type = get_short();
			d_type = get_short();
			nbr = get_long();
			fprintf(fd, "0x%lX %s, nbr of items=%d, stype=%d, dtype=%d\n", 
				IC - sizeof(long) - (2*sizeof(short)) - 1, 
				"BC_END_STRIP", nbr, s_type, d_type);
			break;
		}
	
	/*
	 * Calling an external function.
	 */
	case BC_EXTERN:
		offset = get_long();				/* Get the feature id */
		code = get_short();					/* Get the static type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d\n",
			IC - sizeof(short) - sizeof(long) - 1,
			"BC_EXTERN", offset, code);
		break;

	/*
	 * Calling an Eiffel feature.
	 */
	case BC_FEATURE:
		offset = get_long();				/* Get the feature id */
		code = get_short();					/* Get the static type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d\n",
			IC - sizeof(short) - sizeof(long) - 1,
			"BC_FEATURE", offset, code);
		break;

	/*
	 * Calling a precompiled external function.
	 */
	case BC_PEXTERN:
		{
			int32 origin, offset;

			origin = get_long();			/* Get the origin class id */
			offset = get_long();			/* Get the offset in the origin */
			fprintf(fd, "0x%lX %s origin=%ld, offset=%ld\n",
				IC - sizeof(long) - sizeof(long) - 1,
				"BC_PEXTERN", origin, offset);
			break;
		}

	/*
	 * Calling a precompiled Eiffel feature.
	 */
	case BC_PFEATURE:
		{
			int32 origin, offset;

			origin = get_long();			/* Get the origin class id */
			offset = get_long();			/* Get the offset in the origin */
			fprintf(fd, "0x%lX %s origin=%ld, offset=%ld\n",
				IC - sizeof(long) - sizeof(long) - 1,
				"BC_PFEATURE", origin, offset);
			break;
		}

	/*
	 * Calling an external in a nested expression (invariant check needed).
	 */
	case BC_EXTERN_INV:
		string = IC;				/* Get the feature name */
		IC += strlen(IC) + 1;
		offset = get_long();			/* Get the feature id */
		code = get_short();				/* Get the static type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d, \"%s\"\n", string - 1,
			"BC_EXTERN_INV", offset, code, string);
		break;

	/*
	 * Calling an Eiffel feature in a nested expression (invariant check).
	 */
	case BC_FEATURE_INV:
		string = IC;				/* Get the feature name */
		IC += strlen(IC) + 1;
		offset = get_long();			/* Get the feature id */
		code = get_short();				/* Get the static type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d, \"%s\"\n", string - 1,
			"BC_FEATURE_INV", offset, code, string);
		break;

	/*
	 * Calling a precompiled external in a nested expression (invariant check needed).
	 */
	case BC_PEXTERN_INV:
		{
			int32 origin, offset;

			string = IC;				/* Get the feature name */
			IC += strlen(IC) + 1;
			origin = get_long();			/* Get the origin class id */
			offset = get_long();			/* Get the offset in the origin */
			fprintf(fd, "0x%lX %s origin=%ld, offset=%ld, \"%s\"\n", string - 1,
				"BC_PEXTERN_INV", origin, offset, string);
			break;
		}
	/*
	 * Calling a precompiled Eiffel feature in a nested expression
	 * (invariant check).
	 */
	case BC_PFEATURE_INV:
		{
			int32 origin, offset;

			string = IC;				/* Get the feature name */
			IC += strlen(IC) + 1;
			origin = get_long();			/* Get the origin class id */
			offset = get_long();			/* Get the offset in the origin */
			fprintf(fd, "0x%lX %s origin=%ld, offset=%ld, \"%s\"\n", string - 1,
				"BC_PFEATURE_INV", origin, offset, string);
			break;
		}

	/*
	 * Access to an attribute.
	 */
	case BC_ATTRIBUTE:
	{
		uint32 type;

		offset = get_long();				/* Get feature id */
		code = get_short();					/* Get static type */
		type = get_uint32();				/* Get attribute meta-type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d, meta-type=0x%lx\n",
			IC - sizeof(short) - sizeof(long) - sizeof(uint32) - 1,
			"BC_ATTRIBUTE", offset, code, type);
		break;
	}

	/*
	 * Access to a precompiled attribute.
	 */
	case BC_PATTRIBUTE:
	{
		int32 origin, ooffset;
		uint32 type;

		origin = get_long();		/* Get the origin class id */
		ooffset = get_long();		/* Get the offset in origin */
		type = get_uint32();				/* Get attribute meta-type */
		fprintf(fd, "0x%lX %s origin=%ld, offset=%ld, meta-type=0x%lx\n",
			IC - sizeof(long) - sizeof(long) - sizeof(uint32) - 1,
			"BC_PATTRIBUTE", origin, ooffset, type);
		break;
	}

	/*
	 * Accessing an attribute in a nested expression (need invariant check).
	 */
	case BC_ATTRIBUTE_INV:
		string = IC;						/* Get the attribute name */
		IC += strlen(IC) + 1;			
		offset = get_long();				/* Get feature id */
		code = get_short();					/* Get static type */
		type = get_uint32();				/* Get attribute meta-type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d, \"%s\"\n", 
			string - sizeof(long) - sizeof(short) - sizeof(uint32) - 1,
			"BC_ATTRIBUTE_INV", offset, code, string);
		break;
			
	/*
	 * Accessing a precompiled attribute in a nested expression
	 * (need invariant check).
	 */
	case BC_PATTRIBUTE_INV:
		{
			int32 origin, ooffset;

			string = IC;						/* Get the attribute name */
			IC += strlen(IC) + 1;			
			origin = get_long();		/* Get the origin class id */
			ooffset = get_long();		/* Get the offset in origin */
			type = get_uint32();				/* Get attribute meta-type */
			fprintf(fd, "0x%lX %s origin=%ld, offset=%ld, \"%s\"\n", 
				string - sizeof(long) - sizeof(long) - sizeof(uint32) - 1,
				"BC_PATTRIBUTE_INV", origin, ooffset, string);
			break;
		}
			
	/*
	 * Rotate the operational stack.
	 */
	case BC_ROTATE:
		code = get_short();
		fprintf(fd, "0x%lX BC_ROTATE %d\n",
			IC - sizeof(short) - 1, code);
		break;
	
	/*
	 * Hector protection of an address
	 */
	case BC_PROTECT:
		fprintf(fd, "0x%lX BC_PROTECT\n", IC - 1);
		break;

	/* 
	 * Hector address release
	 */
	case BC_RELEASE:
		code = get_short();
		fprintf(fd, "0x%lX BC_RELEASE %d\n", IC - sizeof(short) - 1, code);
		break;

	/*
	 * Access to Current.
	 */
	case BC_CURRENT:
		fprintf(fd, "0x%lX BC_CURRENT\n", IC - 1);
		break;
	
	/*
	 * Character constant.
	 */
	case BC_CHAR:
		fprintf(fd, "0x%lX BC_CHAR '%c'\n", IC - 1, *IC);
		IC++;
		break;

	/*
	 * Boolean constant.
	 */
	case BC_BOOL:
		fprintf(fd, "0x%lX BC_BOOL %s\n", IC - 1, *IC ? "true" : "false");
		IC++;
		break;

	/*
	 * Integer constant.
	 */
	case BC_INT:
		offset = get_long();
		fprintf(fd, "0x%lX BC_INT %ld\n", IC - sizeof(long) - 1, offset);
		break;

	/*
	 * Real constant.
	 */
	case BC_FLOAT:
		d = get_double();
		fprintf(fd, "0x%lX BC_FLOAT %f\n", IC - sizeof(double) - 1, (float) d);
		break;

	/*
	 * Double constant.
	 */
	case BC_DOUBLE:
		d = get_double();
		fprintf(fd, "0x%lX BC_DOUBLE %f\n", IC - sizeof(double) - 1, d);
		break;

	/*
	 * Access to Result.
	 */
	case BC_RESULT:
		fprintf(fd, "0x%lX BC_RESULT\n", IC - 1);
		break;
		
	/*
	 * Access to a local variable.
	 */
	case BC_LOCAL:
		code = get_short();				/* Get number (from 1 to locnum) */
		fprintf(fd, "0x%lX %s #%d\n", IC - sizeof(short) - 1,
			"BC_LOCAL", code);
		break;

	/*
	 * Access to an argument.
	 */
	case BC_ARG:
		code = get_short();				/* Get number (from 1 to argnum) */
		fprintf(fd, "0x%lX %s #%d\n", IC - sizeof(short) - 1,
			"BC_ARG", code);
		break;

	/*
	 * And then operator (left value).
	 */
	case BC_AND_THEN:
		offset = get_long();
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_AND_THEN", IC + offset);
		break;

	/*
	 * Or else operator (left value).
	 */
	case BC_OR_ELSE:
		offset = get_long();
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_OR_ELSE", IC + offset);
		break;

	/*
	 * Monadic operators.
	 */
	case BC_UPLUS:			/* Unary plus */
		fprintf(fd, "0x%lX BC_UPLUS\n", IC - 1);
		break;
	case BC_UMINUS:			/* Unary minus */
		fprintf(fd, "0x%lX BC_UMINUS\n", IC - 1);
		break;
	case BC_NOT:			/* Unary negation */
		fprintf(fd, "0x%lX BC_NOT\n", IC - 1);
		break;

	/*
	 * Diadic operators.
	 */
	case BC_LT:				/* Lesser than op */
		fprintf(fd, "0x%lX BC_LT\n", IC - 1);
		break;
	case BC_GT:				/* Greater than op */
		fprintf(fd, "0x%lX BC_GT\n", IC - 1);
		break;
	case BC_MINUS:			/* Minus op */
		fprintf(fd, "0x%lX BC_MINUS\n", IC - 1);
		break;
	case BC_XOR:			/* Xor op */
		fprintf(fd, "0x%lX BC_XOR\n", IC - 1);
		break;
	case BC_GE:				/* Greater or equal op */
		fprintf(fd, "0x%lX BC_GE\n", IC - 1);
		break;
	case BC_EQ:				/* Equality */
		fprintf(fd, "0x%lX BC_EQ\n", IC - 1);
		break;
	case BC_NE:				/* Not equal op */
		fprintf(fd, "0x%lX BC_NE\n", IC - 1);
		break;
	case BC_STAR:			/* Multiplication op */
		fprintf(fd, "0x%lX BC_STAR\n", IC - 1);
		break;
	case BC_POWER:			/* Power op */
		fprintf(fd, "0x%lX BC_POWER\n", IC - 1);
		break;
	case BC_LE:				/* Less or equal op */
		fprintf(fd, "0x%lX BC_LE\n", IC - 1);
		break;
	case BC_DIV:			/* Div op */
		fprintf(fd, "0x%lX BC_DIV\n", IC - 1);
		break;
	case BC_AND:			/* Logical conjuntion op */
		fprintf(fd, "0x%lX BC_AND\n", IC - 1);
		break;
	case BC_SLASH:			/* Real division op */
		fprintf(fd, "0x%lX BC_SLASH\n", IC - 1);
		break;
	case BC_MOD:			/* Integer remainder division op */
		fprintf(fd, "0x%lX BC_MOD\n", IC - 1);
		break;
	case BC_PLUS:			/* Addition op */
		fprintf(fd, "0x%lX BC_PLUS\n", IC - 1);
		break;
	case BC_OR:				/* Logocal disjunction op */
		fprintf(fd, "0x%lX BC_OR\n", IC - 1);
		break;

	/*
	 * Expanded equality
 	 */
	case BC_BIT_STD_EQUAL:
		fprintf(fd, "0x%lX BC_BIT_STD_EQUAL\n", IC - 1);
		break;

	/*
	/*
	 * Expanded equality
 	 */
	case BC_STANDARD_EQUAL:
		fprintf(fd, "0x%lX BC_STANDARD_EQUAL\n", IC - 1);
		break;

	/*
	 * True comparison
	 */
	case BC_TRUE_COMPAR:
		fprintf(fd, "0x%lx BC_TRUE_COMPAR\n", IC - 1);
		break;

	/*
	 * False comparison
	 */
	case BC_FALSE_COMPAR:
		fprintf(fd, "0x%lX BC_FALSE_COMPAR\n", IC - 1);
		break;

	/*
	 * Address operator.
	 */
	case BC_ADDR:
		offset = get_long();			/* Get the feature id */
		code = get_short();				/* Get the static type */
		fprintf(fd, "0x%lX %s fid=%d, st=%d\n",
			IC - sizeof(short) - sizeof(long) - 1,
			"BC_ADDR", offset, code);
		break;

	/*
	 * Reserved space (for object address)
	 */
	case BC_RESERVE:
		fprintf(fd, "0x%lX BC_RESERVE\n", IC - 1);
		break;

	/*
	 * Object address operator.
	 */
	case BC_OBJECT_ADDR:
		{
		uint32 nb_uint32 = get_uint32();
		fprintf(fd, "0x%lX BC_OBJECT_ADDR offset=%d\n", IC - sizeof(uint32) - 1, nb_uint32);
		}
		break;

	/*
	 * Object expression address operator.
	 */
	case BC_OBJECT_EXPR_ADDR:
		{
		uint32 ptr_pos, value_pos;
		ptr_pos = get_uint32();
		value_pos = get_uint32();
		fprintf(fd, "0x%lX BC_OBJECT_EXPR_ADDR ptr:%d value: %d\n",
					IC - 2 * sizeof(uint32) - 1, ptr_pos, value_pos);
		}
		break;

	/*
	 * Pop.
	 */
	case BC_POP:
		{
		uint32 nb_uint32 = get_uint32();
		fprintf(fd, "0x%lX BC_POP %d\n", IC - sizeof(uint32) - 1, nb_uint32);
		}
		break;

	/*
	 * Manifest string.
	 */
	case BC_STRING:
		string = IC;
		IC += strlen(IC) + 1;
		fprintf(fd, "0x%lX BC_STRING \"%s\"\n", string - 1, string);
		break;

	/*
	 * Manifest bit
	 */
	case BC_BIT:
		{
			char *str;
			int nb_uint32;

			nb_uint32 = get_uint32() + 1;          /* Read bit count */
			/*str = b_out(IC) - bug here*/
			fprintf(fd, "BIT %d\n", nb_uint32 - 1);
			/*xfree(str);*/
			IC += nb_uint32*sizeof(uint32);
		}
		break;
			
	/*
	 * Jump if top of stack is false (value is poped).
	 */
	case BC_JMP_F:				/* Jump if false */
		offset = get_long();	/* Get jump offset */
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_JMP_F", IC + offset);
		break;

	/*
	 * Jump if top of stack is true (value is poped).
	 */
	case BC_JMP_T:				/* Jump if false */
		offset = get_long();	/* Get jump offset */
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_JMP_T", IC + offset);
		break;

	/*
	 * Unconditional jump.
	 */
	case BC_JMP:
		offset = get_long();
		fprintf(fd, "0x%lX %s 0x%lX\n", IC - sizeof(long) - 1,
			"BC_JMP", IC + offset);
		break;

	/*
	 * Next debugging instruction.
	 */
	case BC_NEXT:
		fprintf(fd, "0x%lX BC_NEXT\n", IC - 1);
		break;

	/*
	 * Active breakpoint.
	 */
	case BC_BREAK:
		fprintf(fd, "0x%lX BC_BREAK\n", IC - 1);
		break;

	/*
	 * End of current Eiffel routine.
	 */
	case BC_NULL:
		fprintf(fd, "0x%lX BC_NULL\n", IC - 1);
		return;

	/*
	 * End of current Eiffel invariant.
	 */
	case BC_INV_NULL:
		fprintf(fd, "0x%lX BC_INV_NULL\n", IC - 1);
		return;

	/*
	 * Cast operator
	 */

	case BC_CAST_LONG:
		fprintf(fd, "0x%lX BC_CAST_LONG\n", IC - 1);
		break;

	case BC_CAST_FLOAT:
		fprintf(fd, "0x%lX BC_CAST_FLOAT\n", IC - 1);
		break;

	case BC_CAST_DOUBLE:
		fprintf(fd, "0x%lX BC_CAST_DOUBLE\n", IC - 1);
		break;

	case BC_REF_TO_PTR:
		fprintf(fd, "0x%lX BC_REF_TO_PTR\n", IC - 1);
		break;

#ifdef CONCURRENT_EIFFEL
	/* The following instructions started with BC_SEP are used by
	 * Concurrent Eiffel.
	*/

	/* the current has called a separate feature in checking its
	 * pre-condition.
	*/
	case BC_SEP_SET:
		fprintf(fd, "0x%lX BC_SEP_SET\n", IC - 1);
		break;
	
	/* clear the flag indicating whether the current separate feature
	 * has called a separate feature call in its pre-condition 
	 * checking.
	*/
	case BC_SEP_UNSET:
		fprintf(fd, "0x%lX BC_SEP_UNSET\n", IC - 1);
		break;

	/* reserve separate parameters of the current feature which are
	 * used in at least one separate feature call.
	*/
	case BC_SEP_RESERVE: 
		{
			short nb_of_sep_paras;
			short tmp_tyc;
			nb_of_sep_paras = get_short();
			fprintf(fd, "0x%lX BC_SEP_RESERVE %d separate parameters\n", IC - sizeof(short) - 1, nb_of_sep_paras);
			fprintf(fd, "	");
			for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; tmp_tyc++) {
				fprintf(fd, "  %d", get_short() + 1);
			}
			fprintf(fd, "\n");
		}	
		break;

	/* free separate parameters of the current feature which are
	 * used in at least one  separate feature call.
	*/
	case BC_SEP_FREE: 
		{
			short nb_of_sep_paras;
			short tmp_tyc;
			nb_of_sep_paras = get_short();
			fprintf(fd, "0x%lX BC_SEP_FREE with %d parameters\n", IC - sizeof(short) - 1, nb_of_sep_paras);
			fprintf(fd, "	");
			for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; tmp_tyc++) {
				fprintf(fd, "  %d", get_short() + 1);
			}
			fprintf(fd, "\n");
		}	
		break;

	/* change the local object stored in the top of the operation stack into 
	 * a separate object 
	*/
	case BC_SEP_TO_SEP:
		fprintf(fd, "0x%lX BC_SEP_TO_SEP\n", IC - 1);
		break;

	/* to perform a separate external feature call */
	case BC_SEP_EXTERN:
	case BC_SEP_PEXTERN:
	/* to perform a separate feature call */
	case BC_SEP_FEATURE:
	case BC_SEP_PFEATURE:
		{
			short nb_of_paras;
			short tyc_tmp;
			uint32 ret_type;
			char need_ack;
			char *feature_name;
			char *class_name;
			char tyc_command = *(IC-1);

			int32 origin;

			fprintf(fd, "0x%lX ", IC - 1);

			nb_of_paras = get_short();	/* number of parameters */
			class_name = IC;			/* get the class name   */
			IC += strlen(IC) + 1;
			feature_name = IC;			/* get the feature name */
			IC += strlen(IC) + 1;
			ret_type = get_uint32();	/* Get the feature's return type */
			need_ack = *IC++;			/* if the proc needs acknowledgement */

			if (tyc_command == BC_SEP_FEATURE || tyc_command == BC_SEP_EXTERN) {
				offset = get_long(); 		/* Get the feature id */		
				code = get_short();   		/* Get the static type */
			} else if (tyc_command == BC_SEP_PFEATURE || tyc_command == BC_SEP_PEXTERN) {
				origin = get_long();		/* Get the origin class id */
				offset = get_long(); 		/* Get the offset in origin */
			}

			if (tyc_command == BC_SEP_FEATURE || tyc_command == BC_SEP_EXTERN) {
				if (tyc_command == BC_SEP_FEATURE)
					fprintf(fd, " BC_SEP_FEATURE paras#=%d, class=%s, feat=%s, ret_type=%d, need_ack=%d\n	offset=%ld, code=%ld\n", nb_of_paras, class_name, feature_name, ret_type & SK_HEAD, need_ack, offset, code);
				else 
					fprintf(fd, " BC_SEP_EXTERN paras#=%d, class=%s, feat=%s, ret_type=%d, need_ack=%d\n	offset=%ld, code=%ld\n", nb_of_paras, class_name, feature_name, ret_type & SK_HEAD, need_ack, offset, code);
			} else if (tyc_command == BC_SEP_PFEATURE || tyc_command == BC_SEP_PEXTERN) {
				if (tyc_command == BC_SEP_PFEATURE)
					fprintf(fd, " BC_SEP_PFEATURE paras#=%d, class=%s, feat=%s, ret_type=%d, need_ack=%d\n	origin=%ld, offset=%ld\n", nb_of_paras, class_name, feature_name, ret_type & SK_HEAD, need_ack, origin, offset);
				else
					fprintf(fd, " BC_SEP_PEXTERN paras#=%d, class=%s, feat=%s, ret_type=%d, need_ack=%d\n	origin=%ld, offset=%ld\n", nb_of_paras, class_name, feature_name, ret_type & SK_HEAD, need_ack, origin, offset);
			}
		}	
		break;


	/* to perform a separate external feature call */
	case BC_SEP_EXTERN_INV:
	case BC_SEP_PEXTERN_INV:
	/* to perform a separate feature call */
	case BC_SEP_FEATURE_INV:
	case BC_SEP_PFEATURE_INV:
		{
			short nb_of_paras;
			short tyc_tmp;
			uint32 ret_type;
			char need_ack;
			char *feature_name;
			char *class_name;
			char tyc_command = *(IC-1);

			int32 origin;

			fprintf(fd, "0x%lX ", IC - 1);

			nb_of_paras = get_short();	/* number of parameters */
			class_name = IC;			/* get the class name   */
			IC += strlen(IC) + 1;
			feature_name = IC;			/* get the feature name */
			IC += strlen(IC) + 1;
			ret_type = get_uint32();	/* Get the feature's return type */
			need_ack = *IC++;			/* if the proc needs acknowledgement */

			if (tyc_command == BC_SEP_FEATURE_INV || tyc_command == BC_SEP_EXTERN_INV) {
				offset = get_long(); 		/* Get the feature id */		
				code = get_short();   		/* Get the static type */
			} else if (tyc_command == BC_SEP_PFEATURE_INV|| tyc_command == BC_SEP_PEXTERN_INV) {
				origin = get_long();		/* Get the origin class id */
				offset = get_long(); 		/* Get the offset in origin */
			}

			if (tyc_command == BC_SEP_FEATURE_INV || tyc_command == BC_SEP_EXTERN_INV) {
				if (tyc_command == BC_SEP_FEATURE_INV)
					fprintf(fd, " BC_SEP_FEATURE_INV paras#=%d, class=%s, feat=%s, ret_type=0x%lx, need_ack=%d\n	offset=%ld, code=%ld\n", nb_of_paras, class_name, feature_name, ret_type, need_ack, offset, code);
				else
					fprintf(fd, " BC_SEP_EXTERN_INV paras#=%d, class=%s, feat=%s, ret_type=0x%lx, need_ack=%d\n	offset=%ld, code=%ld\n", nb_of_paras, class_name, feature_name, ret_type, need_ack, offset, code);
			} else if (tyc_command == BC_SEP_PFEATURE_INV || tyc_command == BC_SEP_PEXTERN_INV) {
				if (tyc_command == BC_SEP_PFEATURE_INV)
					fprintf(fd, " BC_SEP_PFEATURE_INV paras#=%d, class=%s, feat=%s, ret_type=0x%lx, need_ack=%d\n	origin=%ld, offset=%ld\n", nb_of_paras, class_name, feature_name, ret_type, need_ack, origin, offset);
				else
					fprintf(fd, " BC_SEP_PEXTERN_INV paras#=%d, class=%s, feat=%s, ret_type=0x%lx, need_ack=%d\n	origin=%ld, offset=%ld\n", nb_of_paras, class_name, feature_name, ret_type, need_ack, origin, offset);
			}
		}	
		break;

	/* to perform a separate attribute call */
	case BC_SEP_ATTRIBUTE_INV:
	case BC_SEP_PATTRIBUTE_INV:
		{
			uint32 ret_type;
			char *feature_name;
			char *class_name;
			char tyc_command = *(IC-1);

			int32 origin, ooffset;

			fprintf(fd, "0x%lX ", IC - 1);

			class_name = IC;			/* get the class name   */
			IC += strlen(IC) + 1;
			feature_name = IC;			/* get the feature name */
			IC += strlen(IC) + 1;

			if (tyc_command == BC_SEP_ATTRIBUTE_INV) {
				offset = get_long();  			/* Get feature id */ 
				code = get_short();        		/* Get static type */
			} else if (tyc_command == BC_SEP_PATTRIBUTE_INV) {
				origin = get_long();   			/* Get the origin class id */
				ooffset = get_long();			/* Get the offset in origin */
			}
			ret_type = get_uint32();		/* Get attribute meta-type */
			
			if (tyc_command == BC_SEP_ATTRIBUTE_INV) {
				fprintf(fd, " BC_SEP_ATTRIBUTE_INV  class=%s, feat=%s, ret_type=0x%lx\n	offset=%ld, code=%ld\n", class_name, feature_name, ret_type, offset, code);
			} else if (tyc_command == BC_SEP_PATTRIBUTE_INV) {
				fprintf(fd, " BC_SEP_PATTRIBUTE_INV class=%s, feat=%s, ret_type=0x%lx\n	origin=%ld, offset=%ld\n", class_name, feature_name, ret_type, origin, offset);
			}
		}	
		break;

	/*
	 * process the failure of precondition checking with separate feature call(s)
	 */
	case BC_SEP_RAISE_PREC:
		fprintf(fd, "0x%lX ", IC - 1);
		{
			short nb_of_sep_paras;
			short sep_para_index[constant_max_number_of_sep_paras];
			short tmp_tyc;
			char reserve_cmd = *IC++;
			fprintf(fd, "BC_SEP_RAISE_PREC\n");
			nb_of_sep_paras = get_short();
			if (reserve_cmd != BC_SEP_RESERVE) {
				fprintf(fd, "expect BC_SEP_RESERVE\n");
			}
			else {
				fprintf(fd, "	BC_SEP_RESERVE with %d parameters\n	<", nb_of_sep_paras);
			}
			for (tmp_tyc=0; tmp_tyc < nb_of_sep_paras; tmp_tyc++) {
				sep_para_index[tmp_tyc] = get_short() + 1;
				fprintf(fd, " %d ", sep_para_index[tmp_tyc]);
			}
			offset = get_long(); 		/* get the offset to the point to recheck
										 * the pre-condition.
										*/
			fprintf(fd, " > offset=%d\n", offset);
		}
		break;

	/* create separate object */
	case BC_SEP_CREATE:
		{
			char *class_name, *feature_name;
			class_name = IC;
			IC += strlen(IC) + 1;
			feature_name = IC;
			IC += strlen(IC) + 1;
			fprintf(fd, "0x%lX BC_SEP_CREATE on %s with procedure <%s>\n", IC-1, class_name, feature_name);
			break;
		}

	/* finishing creating separate object */
	case BC_SEP_CREATE_END:
		fprintf(fd, "0x%lX BC_SEP_CREATE_END\n", IC - 1);
		break;
#endif


	default:
		fprintf(fd, "0x%lX UNKNOWN (opcode = %d)\n", IC - 1, code);
	}
	}							/* Remember: indentation was wrong--RAM */
	/* NOTREACHED */
}
#endif

