/*

 #    #    ##     ####   #####    ####    ####           #    #
 ##  ##   #  #   #    #  #    #  #    #  #               #    #
 # ## #  #    #  #       #    #  #    #   ####           ######
 #    #  ######  #       #####   #    #       #   ###    #    #
 #    #  #    #  #    #  #   #   #    #  #    #   ###    #    #
 #    #  #    #   ####   #    #   ####    ####    ###    #    #

	Macros used by C code at run time.
*/

#ifndef _eif_macros_h_
#define _eif_macros_h_

#include "eif_portable.h"
#include "eif_equal.h"
#include "eif_globals.h"
#include "eif_project.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_local.h"
#include "eif_copy.h"
#include "eif_plug.h"				/* For struct bit declaration */
#include "eif_hector.h"
#include "eif_size.h"
#include "eif_gen_conf.h"
#include "eif_rout_obj.h"
#if !defined CUSTOM || defined NEED_OPTION_H
#include "eif_option.h"
#endif
#include "eif_bits.h"

#ifdef WORKBENCH
#include "eif_wbench.h"
#include "eif_option.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif


/* On a BSD system, we should use _setjmp and _longjmp if they are available,
 * so that no system call is made to preserve the signal mask flag. It should
 * be taken care of by the signal handler routine.
 */
#ifdef USE_BSDJMP
#define setjmp _setjmp
#define longjmp _longjmp
#endif



/* Convenience macros:
 * EIF_TRUE representation of True in Eiffel (shouldn't be used in tests, always compare to False)
 * EIF_FALSE representation of False in Eiffel
 * EIF_TEST boolean test on an expression
 */
#define EIF_TRUE		(EIF_BOOLEAN) '\01'
#define EIF_FALSE		(EIF_BOOLEAN) '\0'
#define EIF_TEST(x)		((EIF_BOOLEAN)((x) ? EIF_TRUE : EIF_FALSE))
#define EIF_VOLATILE


/* Function pointer call to make sure all arguments are correctly pushed onto stack.
 * FUNCTION_CAST is for standard C calls.
 * FUNCTION_CAST_TYPE is for non-standard C calls.
 */
#define FUNCTION_CAST(r_type, arg_types)					(r_type (*) arg_types)
#define FUNCTION_CAST_TYPE(r_type, call_type, arg_types)	(r_type (call_type *) arg_types)



/* Macro used for allocation:
 *  RTLN(x) allocates a new object of type 'x'
 *  RTLNR(x,y,a,o,c) allocates a new routine object of type 'x' and
 *  initializes it with the routine pointer 'y', the true routine pointer 'z',
 *  argument tuple 'a', open map 'o' and closed map 'c'
 *  RTLB(x) allocated a new bit object of size 'x'
 *  RTUD keep dynamic type  for refreezing
 *  RTLX(x) allocates an expanded object (with possible in invocation
 *		of the creation routine) of type `x'
 *  RTXB(x,y) copies bit `x' to `y'
 *  RTMB(x,y) creates bit of length y bits from string value x
 *  RTEB(x,y) are bits `x' and `y' equal?
 */
#define RTLN(x)				emalloc(x)
#define RTLNR(x,y,z,a,o,c)	rout_obj_create((x),(y),(z),(a),(o),(c))
#define RTLB(x)				bmalloc(x)
#define RTMB(x,y)			makebit(x,y)
#define RTXB(x,y)			b_copy(x,y)
#define RTEB(x,y)			b_equal(x,y)
#ifdef WORKBENCH
RT_LNK int fcount;
#define RTUD(x)				((x)>=fcount?(x):egc_fdtypes[x])  /* Updated dynamic type */
#define RTLX(x)				cr_exp(x)
#else
#define RTUD(x)				(x) /* For convenience */
#endif



/* Macro used for object cloning:
 *  RTCL(x) clones 'x' and return a pointer to the cloned object
 *  RTCB(x) clones bit `x'
 */
#define RTCL(x)		rtclone(x)
#define RTCB(x)		b_clone(x)



/* Macro used for object creation to get the proper creation type:
 *  RTCA(x,y) returns the dynamic type of 'x' if not void, otherwise 'y'
 */
#define RTCA(x,y) ((x) == (EIF_REFERENCE) 0 ? (y) : Dftype(x))



/* Macros used for assignments:
 *  RTAG(x) is true if 'x' is an old object not remembered
 *  RTAO(x) is true if 'x' is an old object.
 *  RTAE(x) is true if 'x' is full of references .
 *  RTAN(x) is true if 'x' is a new object (i.e. not old)
 *  RTAM(x) memorizes 'x'
 *  RTAX(x,y) remembers 'y' if 'x' is new and 'y' is old not remembered yet
 *  RTAR(x,y) remembers 'y' if it is old and not remembered and 'x' is new
 *  RTAS(x,y) is the same as RTAR but for special objects and with no GC call
 *  RTAS_OPT(x,i, y) is the same as RTAS with passing the index.
 */
#ifdef ISE_GC
#define RTAO(x)		(HEADER(x)->ov_flags & EO_OLD)
#define RTAE(x)		(HEADER(x)->ov_flags & EO_REF)
#define RTAG(x)		((HEADER(x)->ov_flags & (EO_OLD | EO_REM)) == EO_OLD)
#define RTAN(x)		(!(HEADER(x)->ov_flags & EO_OLD))
#define RTAM(x)		eremb(x)
#define RTAX(x,y)	(RTAG(y)?(RTAN(x)?RTAM((y)),(x):(x)):(x))
#define RTAR(x,y) \
	if (((x) != (EIF_REFERENCE) 0) && (RTAN(x))) { \
		if (HEADER(y)->ov_flags & EO_EXP) { \
		   register EIF_REFERENCE z = (EIF_REFERENCE) y - (HEADER (y)->ov_size & B_SIZE); \
			if (RTAG(z)) RTAM(z); \
		} else if (RTAG(y)) RTAM(y); \
	}
#define RTAS(x,y) \
	if ((x) != (EIF_REFERENCE) 0 && RTAN(x)) { \
		if (HEADER(y)->ov_flags & EO_EXP) { \
			register EIF_REFERENCE z = (EIF_REFERENCE) y - (HEADER(y)->ov_size & B_SIZE); \
			if (RTAG(z)) erembq((z)); \
		} else if (RTAG(y)) erembq((y)); \
	}

#ifdef EIF_REM_SET_OPTIMIZATION
#define RTAS_OPT(x,i,y) \
	if ((x) != (EIF_REFERENCE) 0 && RTAN(x)) { \
		if (HEADER(y)->ov_flags & EO_EXP) { \
			register EIF_REFERENCE z = (EIF_REFERENCE) y - (HEADER(y)->ov_size & B_SIZE); \
			if (RTAG(z)) erembq((z)); \
		} else if (RTAO(y)) { \
			if (RTAE(y)) \
				special_erembq((y), (i)); \
			else \
				erembq((y)); \
		} \
	} 
#else	/* EIF_REM_SET_OPTIMIZATION */
#define RTAS_OPT(x,i,y) RTAS (x,y)
#endif	/* EIF_REM_SET_OPTIMIZATION */

#else /* ISE_GC */
#define RTAM(x)		(x)
#define RTAX(x,y)	(x)
#define RTAR(x,y)
#define RTAS(x,y)
#define RTAS_OPT(x,i,y)
#endif /* ISE_GC */



/* Macros used by reverse assignments:
 *  RTRC(x,y) is true if type 'y' conforms to type 'x'
 *  RTRA(x,y) calls RTRC(x, Dftype(y)) if 'y' is not void
 *  RTRV(x,y) returns 'y' if it conforms to type 'x', void otherwise
 *  RTRM(x,y) memorizes 'x' if not void and 'y' is old with 'x' new
 */
#define RTRC(x,y)		eif_gen_conf ((int16) (y), (int16) (x))
#define RTRA(x,y)		((y) == (EIF_REFERENCE) 0 ? 0 : RTRC((x),Dftype(y)))
#define RTRV(x,y)		(RTRA((x),(y)) ? (y) : (EIF_REFERENCE) 0)
#define RTRM(x,y)		((x) == (EIF_REFERENCE) 0 ? 0 : RTAX(x,y))



/* Macros used for local variable management:
 *  RTLI(x) makes room on the stack for 'x' addresses
 *  RTLE restore the previous stack context
 *  RTLD declares the variable used by RTLI/RTLE
 *  RTLR(x,y) register `y' on the stack at position `x'
 *  RTLRC(x) clear stack at position `x'
 *  RTXI(x) makes room on the stack for 'x' addresses when feature has rescue
 *  RTXE restores the current chunk, in case an exception was raised
 *  RTXL saves the current local chunk in case exception is raised
 *  RTLXE restores the current local variables chunk, in case an exception was raised
 *  RTLXL saves the current local variables chunk in case exception is raised
 *  RTLXD declares the current local variables chunk in case exception is raised
 */

#ifdef ISE_GC
#define RTLI(x) \
	{ \
		if (l + (x) <= loc_set.st_end) \
			loc_set.st_top += (x); \
		else { \
			ol = l; \
			l = eget(x); \
		} \
	}
#define RTLE \
	{ \
		if (ol == (EIF_REFERENCE *) 0) \
			loc_set.st_top = l; \
		else { \
			eback(ol); \
		} \
	}
#define RTLD \
	EIF_REFERENCE *l = loc_set.st_top; \
	EIF_REFERENCE *ol = (EIF_REFERENCE *) 0

#define RTLR(x,y) l[(x)] = (EIF_REFERENCE) &y
#define RTLRC(x)  l[(x)] = (EIF_REFERENCE) 0;

#define RTXI(x) \
	{ \
		if (l + (x) <= loc_set.st_end) \
			loc_set.st_top += (x); \
		else \
			l = eget(x); \
	}
#define RTXE \
	loc_set.st_cur = lc; \
	if (lc) loc_set.st_end = lc->sk_end; \
	loc_set.st_top = lt
#define RTXL \
	EIF_REFERENCE * volatile l = loc_set.st_top; \
	EIF_REFERENCE * volatile lt = loc_set.st_top; \
	struct stchunk * volatile lc = loc_set.st_cur
#define RTLXD \
	struct item * EIF_VOLATILE lv
#define RTLXL \
	lv = cop_stack.st_top
#define RTLXE \
	while (cop_stack.st_top != lv) { \
		RTLO(1); \
	}

#else /* ISE_GC */
#define RTLI(x) 
#define RTLE
#define RTLD
#define RTLR(x,y)
#define RTXI(x)
#define RTXE 
#define RTXL
#endif /* ISE_GC */



/* Macro used to record once functions:
 *  RTOC calls onceset to record the address of Result (static variable)
 */
#ifdef ISE_GC
#define RTOC(x)			onceset();
#define RTOC_NEW(x)		new_onceset((EIF_REFERENCE) &x);
#define RTOC_GLOBAL(x)	globalonceset((EIF_REFERENCE) &x);
#else
#define RTOC(x)
#define RTOC_NEW(x)
#define RTOC_GLOBAL(x)
#endif /* ISE_GC */
#define RTOVP(n,c,a)	if (!(CAT2(n,_done))) c a
#define RTOVF(n,c,a)	(CAT2(n,_done) ? CAT2(n,_result) : c a)
		

/* Macro used for object information:
 * Dtype:		Dynamic type of object. The name is not RTDT for historical reasons.
 * Dftype:		Full dynamic type of object - for generic conformance
 * Deif_bif:	Dynamic (base) type (mapped through `eif_cid_map'
 * Mapped_flags:Header flags with type mapped through `eif_cid_map'
 * RTCDT:		Compute `dtype' of Current
 * RTCDD:		Declare `dtype' for later computation of Dtype of Current.
 */

#define Dtype(x) 		(eif_cid_map[(HEADER(x)->ov_flags & EO_TYPE)])
#define Dftype(x) 		(HEADER(x)->ov_flags & EO_TYPE)
#define Deif_bid(x)		(eif_cid_map[(x) & EO_TYPE])
#define Mapped_flags(x) (((x) & EO_UPPER) | ((uint32) eif_cid_map [(x) & EO_TYPE]))
#define RTCDT			int EIF_VOLATILE dtype = Dtype(Current)
#define RTCDD			int EIF_VOLATILE dtype



/* Macros for assertion checking:
 *  RTCT(t,x) next assertion has tag 't' and is of type 'x'
 *  RTCS(x) new stack frame of type 'x'
 *  RTCK signals successful end of last assertion check
 *  RTJB goto body 
 *  RTCF signals failure during last assertion check
 *  RTTE tests assertion 
 *	RTIT(t,x) next invariant assertion has tag 't' and is of type 'x'
 *	RTIS(x) new stack invariant frame of type 'x'
 *  RTVR(x,y) check if call of feature 'y' on 'x' is done on a void reference
 */
#define RTCT(t,x) exasrt(MTC t, x)
#define RTCS(x) exasrt(MTC (EIF_REFERENCE) 0, x)
#define RTCK in_assertion = 0; expop(&eif_stack);
#define RTCF in_assertion = 0; eviol();
#define RTIT(t,x) exinv(MTC t, x)
#define RTIS(x) exinv(MTC (EIF_REFERENCE) 0, x)
#define RTTE(x,y) if (!(x)) goto y 
#define RTJB goto body
#ifdef WORKBENCH
#define RTVR(x,y) if ((x) == (EIF_REFERENCE) 0) eraise(y, EN_VOID)
#endif



/* Macros for exception handling:
 *  RTEX declares the exception vector variable for current routine
 *  RTED declares the setjmp buffer
 *  RTES issues the setjmp call for remote control transfer via longjmp
 *  RTEJ sets the exception handling mechanism (must appear only once)
 *  RTEA(x,y,z) signal entry in routine 'x', origin 'y', object ID 'z'
 *  RTEV signals entry in routine (simply gets an execution vector)
 *  RTET(t,x) raises an exception tagged 't' whose code is 'x'
 *  RTEC(x) raises an exception whose code is 'x'
 *  RTEE exits the routine by removing the execution vector from stack
 *  RTER retries the routine
 *  RTEU enters in rescue clause
 *  RTEF ends the rescue clause
 *  RTXD declares the variables used to save the run-time stacks context
 *  RTXSC resynchronizes the run-time stacks in a pseudo rescue clause in C
 *  RTXS(x) resynchronizes the run-time stacks in a rescue clause
 *  RTEOK ends a routine with a rescue clause by cleaning the trace stack
 *  RTSO stops the tracing as well as the profiling
 */
#define RTED		jmp_buf exenv
#define RTES		if (setjmp(exenv)) goto rescue
#define RTEA(x,y,z)	exvect = new_exset(MTC x, y, z, 0, 0, 0)
#define RTEV		exvect = exft()
#define RTET(t,x)	eraise(t,x)
#define RTEC(x)		RTET((EIF_REFERENCE) 0,x)
#define RTSO		check_options_stop()

#ifdef WORKBENCH
#define RTEX		struct ex_vect * EIF_VOLATILE exvect; uint32 EIF_VOLATILE db_cstack
#define RTEAA(x,y,z,i,j,b) exvect = new_exset(x, y, z,i,j,b); db_cstack = ++d_data.db_callstack_depth;
#define RTEE		RTSO; d_data.db_callstack_depth = --db_cstack; expop(&eif_stack)
#define RTEOK		RTSO; d_data.db_callstack_depth = --db_cstack; exok()

#define RTEJ		current_call_level = trace_call_level; \
					if (prof_stack) saved_prof_top = prof_stack->st_top; \
					start: exvect->ex_jbuf = &exenv; RTES

#define RTEU d_data.db_callstack_depth = db_cstack; exresc(MTC exvect);
#else
#define RTEX		struct ex_vect * EIF_VOLATILE exvect
#define RTEAA(x,y,z,i,j,b) exvect = new_exset(x, y, z, 0, 0, 0)
#define RTEE		expop(&eif_stack)
#define RTEOK		exok()
#define RTEJ		start: exvect->ex_jbuf = &exenv; RTES
#define RTEU		exresc(MTC exvect)
#endif

#define RTER		in_assertion = 0; \
					exvect = exret(exvect); goto start
#define RTEF		exfail()
#define RTXS(x)		RTXSC; RTXI(x)
#define RTXSC		RTXE; RTHS; RTLS
#define RTXD		RTXL; RTXH; RTXLS
	
/* new debug */
#ifdef WORKBENCH
#define RTLU(x,y)	insert_local_var (x, y)
#define RTLO(n)		clean_local_vars (n)
#define RTHOOK(n)	dstop (exvect, n)
#define RTNHOOK(n)	dstop_nested (exvect, n)
#else
#define RTLU(x,y)
#define RTLO(n)	
#define RTHOOK(n)
#define RTNHOOK(n)
#endif



/* Accessing of bits in a bit field is done via macros.
 * Bits are stored from left to right. If the size of an int is I (in bits),
 * then bit "n" is in the n/I th int at the position n%I.
 *  RTBI(b,n) accesses bit 'n' in the bit field 'b'
 *  RTBS(b,n) sets bit 'n' to 1 in the bit field 'b'
 *  RTBR(b,n) resets bit 'n' to 0 in the bit field 'b'
 */
#define RTBI(b,n) \
	(((struct bit *) (b))->b_value[(n)/BITLONG] & (1<<((n)%BITLONG)))
#define RTBS(b,n) \
	(((struct bit *) (b))->b_value[(n)/BITLONG] |= (1<<((n)%BITLONG)))
#define RTBR(b,n) \
	(((struct bit *) (b))->b_value[(n)/BITLONG] &= ~(1<<((n)%BITLONG)))



/* Hector protection for external calls:
 *  RTHP(x) protects 'x' returns Hector indirection pointer
 *  RTHF(x) removes 'x' topmost entries from Hector stack
 *  RTXH saves hector's stack context in case an exception occurs
 *  RTHS resynchronizes the hector stack by restoring saved context
 */
#define RTHP(x) hrecord(x)
#define RTHF(x) epop(&hec_stack, x)
#define RTXH \
	EIF_REFERENCE * volatile ht = hec_stack.st_top; \
	struct stchunk * volatile hc = hec_stack.st_cur
#define RTHS \
	hec_stack.st_cur = hc; \
	if (hc) hec_stack.st_end = hc->sk_end; \
	hec_stack.st_top = ht

/* Loc stack protection:
 * RTXLS saves loc_stack context in case an exception occurs
 * RTLS resynchronizes the loc_stack by restoring saved context
 */
#ifdef ISE_GC
#define RTXLS \
	EIF_REFERENCE * volatile lst = loc_stack.st_top; \
	struct stchunk * volatile lsc = loc_stack.st_cur
#define RTLS \
	loc_stack.st_cur = lsc; \
	if (lsc) loc_stack.st_end = lsc->sk_end; \
	loc_stack.st_top = lst
#else
#define RTXLS
#define RTLS
#endif /* ISE_GC */



/* Other macros used to handle specific needs:
 *  RTMS(s) creates an Eiffel string from a C manifest string s.
 *  RTMS_EX(s,c) creates an Eiffel string from a C manifest string s with length c.
 *  RTPOF(p,o) returns the C pointer of the address p + o where p represents a C pointer.
 *  RTST(c,d,i,n) creates an Eiffel ARRAY[ANY] (for strip).
 *  RTXA(x,y) copies 'x' into expanded 'y' with exception if 'x' is void.
 *  RTEQ(x,y) returns true if 'x' = 'y'
 *  RTIE(x) returns true if 'x' is an expanded object
 *  RTOF(x) returns the offset of expanded 'x' within enclosing object
 *  RTEO(x) returns the address of the enclosing object for expanded 'x'
 */
#define	RTMS(s)			makestr(s,strlen(s))
#define	RTMS_EX(s,c)	makestr(s,c)
#define RTPOF(p,o)		(EIF_POINTER)((EIF_POINTER *)(((char *)(p))+(o)))
#define	RTST(c,d,i,n)	striparr(c,d,i,n);
#define RTXA(x,y)		xcopy(x, y)
#define RTEQ(x,y)		xequal(x, y)
#define RTIE(x)			((x) != (EIF_REFERENCE) 0 ? HEADER(x)->ov_flags & EO_EXP : 0)
#define RTOF(x)			(HEADER(x)->ov_size & B_SIZE)
#define RTEO(x)			((x) - RTOF(x))



/* Macros for invariant check.
 *  RTSN saves global variable 'nstcall' within C stack
 *  RTIV(x,y) checks invariant before call on object 'x' if good flags 'y'
 *  RTVI(x,y) checks invariant after call on object 'x' if good flags 'y'
 *  RTCI(x) checks invariant after creation call on object 'x'
 */
#define RTSN int EIF_VOLATILE is_nested = nstcall
#ifdef WORKBENCH
#define RTIV(x,y)		if (is_nested && ((y) & CK_INVARIANT)) chkinv(MTC x,0)
#define RTVI(x,y)		if (is_nested && ((y) & CK_INVARIANT)) chkinv(MTC x,1)
#define RTCI(x)			chkcinv(MTC x)
#else
#define RTIV(x)			if (~in_assertion & is_nested) chkinv(MTC x,0)
#define RTVI(x)			if (~in_assertion & is_nested) chkinv(MTC x,1)
#define RTCI(x)			if (~in_assertion) chkinv(MTC x,1)
#endif



/* Generic conformance
 *  RTCID(tp,x,y,z) converts a type array into a single id
 *  RTFCID(ct,x,y,z) fetches the creation type of a generic feature in final mode
*/

#define RTCID(tp,x,y,z)		eif_compound_id((tp),(x),(y),(z))
#define RTFCID(ct,x,y,z)	eif_final_id((ct),(x),(y),(z))
#define RTGPTID(st,x,y)		eif_gen_param_id ((st),(x),(y))



/*
 * Macros for workbench
 */

#ifdef WORKBENCH

/* Macros to cache assertion level in generated C routine.
 *  RTDA declares integer used to save the assertion level
 *  RTSA(x) saves assertion level for dynamic type 'x'
 *  RTAL is the access to the saved assertion level variable
 */
#define RTDA		struct eif_opt * EIF_VOLATILE opt
#define RTSA(x)		opt = eoption + x; check_options(opt, x)
#define RTAL		(~in_assertion & opt->assert_level)



/* Macros used for feature call and various accesses to objects.
 *  RTWF(x,y,z) is a feature call
 *  RTWPF(x,y,z) is a precompiled feature call
 *  RTVF(x,y,z,t) is a nested feature call (dot expression)
 *  RTVPF(x,y,z,t) is a nested precompiled feature call (dot expression)
 *  RTWA(x,y,z) is the access to an attribute
 *  RTWPA(x,y,z) is the access to a precompiled attribute
 *  RTVA(x,y,z,t) is a nested access to an attribute (dot expression)
 *  RTVPA(x,y,z,t) is a nested access to a precompiled attribute (dot expr)
 *  RTWT(x,y,z) fetches the creation type
 *  RTWPT(x,y,z) fetches the creation type of a precompiled feature
 *  RTWCT(x,y,z) fetches the creation type of a generic features
 *  RTWPCT(st,x,y,z) fetches the creation type of a precompiled generic feature
 *  RTWPP(x,y) returns the feature address ($ operator)
 *  RTWO(x) stores in a list the body id of the just called once routine
 */
#define RTWF(x,y,z)			wfeat(x,y,z)
#define RTWPF(x,y,z)		wpfeat(x,y,z)
#define RTVF(x,y,z,t)		wfeat_inv(x,y,z,t)
#define RTVPF(x,y,z,t)		wpfeat_inv(x,y,z,t)
#define RTWA(x,y,z)			wattr(x,y,z)
#define RTWPA(x,y,z)		wpattr(x,y,z)
#define RTVA(x,y,z,t)		wattr_inv(x,y,z,t)
#define RTVPA(x,y,z,t)		wpattr_inv(x,y,z,t)
#define RTWT(x,y,z)			wtype(x,y,z)
#define RTWPT(x,y,z)		wptype(x,y,z)
#define RTWCT(x,y,z)		wtype_gen(x,y,z)
#define RTWPCT(st,x,y,z)	wptype_gen(st,x,y,z)
#define RTWPP(x,y)			((egc_address_table[x])[2*(y)])
#define RTWPPR(x,y)			((egc_address_table[x])[2*(y)+1])
#define RTWO(x)				onceadd(x)

#define WDBG(x,y)			is_debug(x,y)				/* Debug option */
#define WASC(x)				eoption[x].assert_level		/* Assertion level */

#define WASL(x,y,z)			waslist(x,y,z)		/* Assertion list evaluation */
#define WASF(x)				wasfree(x)			/* Free assertion list */

#define RTDS(x)				dispatch(x)			/* Body id of body index (x) */
#define RTFZ(x)				egc_frozen(x)		/* C frozen pointer of body id (x) */
#define RTMT(x)				melt(x)				/* Byte code of body id (x) */

#define RTDT \
		int EIF_VOLATILE current_call_level; \
		char ** EIF_VOLATILE saved_prof_top    /* Declare saved trace and profile */
#else
/* In final mode, an Eiffel call to a deferred feature without any actual
 * implementation could be generated anyway because of the statical dead code
 * removal process; so we need a funciton pointer trigeering an exception
 */
#define RTNR rt_norout



/* In final mode, we have two macros for E-TRACE called RTTR (start trace) and RTXT (stop trace).
 * We have also two macros for E-PROFILE in final mode, called RTPR (start profile) and RTXP (stop profile).
 * All macros need to have 'x' = featurename, 'y' = origin, 'z' = dtype, except RTXP.
 *
 * Plus, we need to declare 'current_call_level' whenever a finalized feature has a rescue-clause.
 * This is done by RTLT
 *
 */
#define RTTR(x,y,z)	start_trace(x,y,z)					/* Print message "entering..." */
#define RTXT(x,y,z)	stop_trace(x,y,z)					/* Print message "leaving..." */
#define RTPR(x,y,z)	start_profile(x,y,z)				/* Start measurement of feature */
#define RTXP		stop_profile()						/* Stop measurement of feature */
#define RTLT		int EIF_VOLATILE current_call_level	/* Declare local trave variable */
#define RTLP		char ** EIF_VOLATILE saved_prof_top	/* Declare local profiler variable */
#define RTPI		saved_prof_top = prof_stack->st_top	/* Create local profile stack
														 * during rescue clause
														 */
#define RTTI		current_call_level = trace_call_level	/* Save the tracer call level */
#endif



/* Macros needed for profile stack and trace clean up */

#ifdef WORKBENCH
#define RTPS		if (prof_stack) prof_stack_rewind(saved_prof_top)		/* Clean up profiler stack */
#else
#define RTPS		prof_stack_rewind(saved_prof_top)		/* Clean up profiler stack */
#endif
#define RTTS		trace_call_level = current_call_level	/* Clean up trace levels */



/* Macros used for array optimization
 *	RTADTYPE(x) defines the variable for the dynamic type of `x'
 *	RTADOFFSETS(x) defines the variables for the offsets of area and lower of `x'
 *	RTAD(x) defines the variables for array optimization on `x'
 *	RTAITYPE(x,y) initializes the variable for Dftype on `x', `y'
 *	RTAI(cast,x,y) initializes the variables for array optimization on `x', `y'
 *	RTAF(x, y) unfreeze `y' if frozen at this level
 *	RTAA(cast,x,i) gets the value at position `i' from `x' of type `cast'
 *	RTAP(cast,x,val,i) puts `val' at position `i' from `x' of type `cast'
 *	RTAUA(cast,x,y,i) gets the value at position `i' from `x' of type `cast' (unsafe version)
 *	RTAUP(cast,x,y,val,i) puts `val' at position `i' from `x' of type `cast' (unsafe version)
 */

#define RTADTYPE(x) int EIF_VOLATILE CAT2(x,_dtype) = 0

#define RTADOFFSETS(x) \
		long EIF_VOLATILE CAT2(x,_area_offset) = 0; \
		long EIF_VOLATILE CAT2(x,_lower_offset) = 0

#define RTAD(x) \
		char EIF_VOLATILE CAT2(x,_freeze) = 0; \
		char* EIF_VOLATILE CAT2(x,_area); \
		char* EIF_VOLATILE CAT2(x,_area_minus_lower)

#define RTAITYPE(x,y) CAT2(x,_dtype) = Dtype(y)

#define RTAIOFFSETS(x,y) \
	if (y) { \
		RTAITYPE(x,y); \
		CAT2(x,_area_offset) = (eif_area_table) [CAT2(x,_dtype)]; \
		CAT2(x,_lower_offset) = (eif_lower_table) [CAT2(x,_dtype)]; \
	}

#define RTAUA(cast,x,y,i) \
	*(cast*)(*(EIF_REFERENCE *)(y+CAT2(x,_area_offset))+(i-*(long*)(y+CAT2(x,_lower_offset)))*sizeof(cast))

#define RTAUP(cast,x,y,val,i) CAT2(RTAUP_,cast)(cast,x,y,val,i)

#define RTAUP_EIF_INTEGER(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_CHARACTER(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_REAL(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_DOUBLE(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_POINTER(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_BOOLEAN(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)

#define RTAUP_EIF_REFERENCE(cast,x,y,val,i) \
	{ \
	EIF_REFERENCE EIF_VOLATILE ptr_current = (*(EIF_REFERENCE *)(y+CAT2(x,_area_offset))); \
	long EIF_VOLATILE i = i-*(long*)(y+CAT2(x,_lower_offset)); \
	*((EIF_REFERENCE *)ptr_current + i) = val; \
	RTAS_OPT(val, i, ptr_current); \
	}

#define RTAUP_BASIC(cast,x,y,val,i) \
	*(cast*)(*(EIF_REFERENCE *)(y+CAT2(x,_area_offset))+(i-*(long*)(y+CAT2(x,_lower_offset)))*sizeof(cast)) = val

#define RTAI(cast,x,y) \
	if (y) { \
		RTAITYPE(x,y); \
		if (CAT2(x,_area) = *(EIF_REFERENCE *) ((y)+ (eif_area_table) [CAT2(x,_dtype)])) { \
			if (!(HEADER(CAT2(x,_area))->ov_size & B_C)) { \
				CAT2(x,_freeze) = 1; \
				HEADER(CAT2(x,_area))->ov_size |= B_C; \
				} \
			CAT2(x,_area_minus_lower) = CAT2(x,_area)-(*(long*) ((y)+ (eif_lower_table) [CAT2(x,_dtype)]))*sizeof(cast); \
			} \
	}

#define RTAIOFF(cast,x,y) \
	if (y) { \
		RTAITYPE(x,y); \
		if (CAT2(x,_area) = *(EIF_REFERENCE *) ((y)+CAT2(x,_area_offset))) { \
			if (!(HEADER(CAT2(x,_area))->ov_size & B_C)) { \
				CAT2(x,_freeze) = 1; \
				HEADER(CAT2(x,_area))->ov_size |= B_C; \
				} \
			CAT2(x,_area_minus_lower) = CAT2(x,_area)-(*(long*) ((y)+CAT2(x,_lower_offset)))*sizeof(cast); \
			} \
	}

#define RTAF(x, y) \
	if (CAT2(x,_freeze)!=0) { \
		HEADER(CAT2(x,_area))->ov_size &= ~B_C; \
		}

#define RTAA(cast,x,i) \
	*(cast*)(CAT2(x,_area_minus_lower)+(i)*sizeof(cast))

#define RTAP(cast,x,val,i) CAT2(RTAP_,cast)(cast,x,val,i)

#define RTAP_EIF_INTEGER(cast,x,val,i) RTAP_BASIC(cast,x,val,i)
#define RTAP_EIF_CHARACTER(cast,x,val,i) RTAP_BASIC(cast,x,val,i)
#define RTAP_EIF_REAL(cast,x,val,i) RTAP_BASIC(cast,x,val,i)
#define RTAP_EIF_DOUBLE(cast,x,val,i) RTAP_BASIC(cast,x,val,i)
#define RTAP_EIF_POINTER(cast,x,val,i) RTAP_BASIC(cast,x,val,i)
#define RTAP_EIF_BOOLEAN(cast,x,val,i) RTAP_BASIC(cast,x,val,i)

#define RTAP_EIF_REFERENCE(cast,x,val,i) \
		{ \
		*((cast*)CAT2(x,_area_minus_lower) + i) = val; \
		RTAS_OPT (val, i, CAT2(x,_area)); \
		}

#define RTAP_BASIC(cast,x,val,i) \
	*(cast*)(CAT2(x,_area_minus_lower)+(i)*sizeof(cast)) = val;


#ifdef __cplusplus
}
#endif

#endif
