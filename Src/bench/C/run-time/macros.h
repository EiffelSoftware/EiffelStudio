/*

 #    #    ##     ####   #####    ####    ####           #    #
 ##  ##   #  #   #    #  #    #  #    #  #               #    #
 # ## #  #    #  #       #    #  #    #   ####           ######
 #    #  ######  #       #####   #    #       #   ###    #    #
 #    #  #    #  #    #  #   #   #    #  #    #   ###    #    #
 #    #  #    #   ####   #    #   ####    ####    ###    #    #

	Macros used by C code at run time.
*/

#ifndef _macros_h_
#define _macros_h_

#include "config.h"
#include "malloc.h"
#include "garcol.h"
#include "except.h"
#include "local.h"
#include "copy.h"
#include "plug.h"				/* For struct bit declaration */
#include "hector.h"
#include "size.h"
#include "option.h"

extern int in_assertion;

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

#define EIF_TRUE (EIF_BOOLEAN) '\01'
#define EIF_FALSE (EIF_BOOLEAN) '\0'
#define EIF_TEST(x) ((EIF_BOOLEAN)((x)?EIF_TRUE:EIF_FALSE))

/* Macro used for initialization of GC profiling:
 *  RTGC calls initialization of GC profiling
 */
#define RTGC	gc_prf();

/* Macro used for allocation:
 *  RTLN(x) allocates a new object of type 'x'
 *  RTLB(x) allocated a new bit object of size 'x'
 *  RTUD keep dynamic type  for refreezing
 *  RTCB(x) clones bit `x'
 *  RTLX(x) allocates an expanded object (with possible in invocation
 *		of the creation routine) of type `x'
 *  RTXB(x,y) copies bit `x' to `y'
 *  RTMB(x,y) creates bit of length y bits from string value x
 *  RTEB(x,y) are bits `x' and `y' equal?
 */
#define RTLN(x) emalloc(x)
#define RTLB(x)	bmalloc(x)
#define RTMB(x,y) makebit(x,y)
#define RTCB(x) b_clone(x)
#define RTXB(x,y) b_copy(x,y)
#define RTEB(x,y) b_equal(x,y)
#ifdef WORKBENCH
extern int fcount;
#define RTUD(x) ((x)>=fcount?(x):fdtypes[x])  /* Updated dynamic type */
#define RTLX(x)   cr_exp(x)
#endif

/* Macro used for object cloning:
 *  RTCL(x) clones 'x' and return a pointer to the cloned object
 */
#define RTCL(x) rtclone(x)

/* Macro used for object creation to get the proper creation type:
 *  RTCA(x,y) returns the dynamic type of 'x' if not void, otherwise 'y'
 */
#define RTCA(x,y) ((x) == (char *) 0 ? (y) : Dtype(x))

/* Macros used for assignments:
 *  RTAG(x) is true if 'x' is an old object not remembered
 *  RTAN(x) is true if 'x' is a new object (i.e. not old)
 *  RTAM(x) memorizes 'x'
 *  RTAX(x,y) remembers 'y' if 'x' is new and 'y' is old not remembered yet
 *  RTAR(x,y) remembers 'y' if it is old and not remembered and 'x' is new
 *  RTAS(x,y) is the same as RTAR but for special objects and with no GC call
 */
#define RTAG(x) ((HEADER(x)->ov_flags & (EO_OLD | EO_REM)) == EO_OLD)
#define RTAN(x) (!(HEADER(x)->ov_flags & EO_OLD))
#define RTAM(x) eremb(x)
#define RTAX(x,y) (RTAG(y)?(RTAN(x)?RTAM((y)),(x):(x)):(x))
#define RTAR(x,y) if ((x) != (char *) 0 && RTAN(x) && RTAG(y)) RTAM(y)
#define RTAS(x,y) if ((x) != (char *) 0 && RTAN(x) && RTAG(y)) erembq(y)

/* Macros used by reverse assignments:
 *  RTRC(x,y) is true if type 'y' conforms to type 'x'
 *  RTRA(x,y) calls RTRC(x, Dtype(y)) if 'y' is not void
 *  RTRV(x,y) returns 'y' if it conforms to type 'x', void otherwise
 *  RTRM(x,y) memorizes 'x' if not void and 'y' is old with 'x' new
 */
#define RTRC(x,y) econfm(x,y)
#define RTRA(x,y) ((y) == (char *) 0 ? 0 : RTRC((x),Dtype(y)))
#define RTRV(x,y) (RTRA((x),(y)) ? (y) : (char *) 0)
#define RTRM(x,y) ((x) == (char *) 0 ? 0 : RTAX(x,y))

/* Macros used for array optimization
 *	RTADTYPE(x) defines the variable for the dynamic type of `x'
 *	RTADOFFSETS(x) defines the variables for the offsets of area and lower of `x'
 *	RTAD(x) defines the variables for array optimization on `x'
 *	RTAITYPE(x,y) initializes the variable for Dtype on `x', `y'
 *	RTAI(cast,x,y) initializes the variables for array optimization on `x', `y'
 *	RTAF(x, y) unfreeze `y' if frozen at this level
 *	RTAA(cast,x,i) gets the value at position `i' from `x' of type `cast'
 *	RTAP(cast,x,val,i) puts `val' at position `i' from `x' of type `cast'
 *	RTAUA(cast,x,y,i) gets the value at position `i' from `x' of type `cast' (unsafe version)
 *	RTAUP(cast,x,y,val,i) puts `val' at position `i' from `x' of type `cast' (unsafe version)
 */

#define RTADTYPE(x) int CAT2(x,_dtype) = 0

#define RTADOFFSETS(x) long CAT2(x,_area_offset) = 0; long CAT2(x,_lower_offset) = 0

#define RTAD(x) char CAT2(x,_freeze) = 0; char* CAT2(x,_area); char* CAT2(x,_area_minus_lower)

#define RTAITYPE(x,y) CAT2(x,_dtype) = Dtype(y)

#define RTAIOFFSETS(x,y) \
	if (y) { \
		RTAITYPE(x,y); \
		CAT2(x,_area_offset) = (eif_area_table) [CAT2(x,_dtype)]; \
		CAT2(x,_lower_offset) = (eif_lower_table) [CAT2(x,_dtype)]; \
	}

#define RTAUA(cast,x,y,i) \
	*(cast*)(*(char**)(y+CAT2(x,_area_offset))+(i-*(long*)(y+CAT2(x,_lower_offset)))*sizeof(cast))

#define RTAUP(cast,x,y,val,i) CAT2(RTAUP_,cast)(cast,x,y,val,i)

#define RTAUP_EIF_INTEGER(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_CHARACTER(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_REAL(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_DOUBLE(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_POINTER(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)
#define RTAUP_EIF_BOOLEAN(cast,x,y,val,i) RTAUP_BASIC(cast,x,y,val,i)

#define RTAUP_EIF_REFERENCE(cast,x,y,val,i) \
	{ \
	register char *ptr_current = (*(char**)(y+CAT2(x,_area_offset))); \
	RTAS (val, ptr_current); \
	*(EIF_REFERENCE*)(ptr_current+(i-*(long*)(y+CAT2(x,_lower_offset)))*sizeof(EIF_REFERENCE)) = val; \
	}

#define RTAUP_BASIC(cast,x,y,val,i) \
	*(cast*)(*(char**)(y+CAT2(x,_area_offset))+(i-*(long*)(y+CAT2(x,_lower_offset)))*sizeof(cast)) = val

#define RTAI(cast,x,y) \
	if (y) { \
		RTAITYPE(x,y); \
		if (CAT2(x,_area) = *(char**) ((y)+ (eif_area_table) [CAT2(x,_dtype)])) { \
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
		if (CAT2(x,_area) = *(char**) ((y)+CAT2(x,_area_offset))) { \
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
		RTAS (val, CAT2(x,_area)); \
		*(cast*)(CAT2(x,_area_minus_lower)+(i)*sizeof(cast)) = val; \
		}

#define RTAP_BASIC(cast,x,val,i) \
	*(cast*)(CAT2(x,_area_minus_lower)+(i)*sizeof(cast)) = val;

/* Macros used for local variable management:
 *  RTLI(x) makes room on the stack for 'x' addresses
 *  RTLE restore the previous stack context
 *  RTLD declares the variable used by RTLI/RTLE
 *  RTXI(x) makes room on the stack for 'x' addresses when feature has rescue
 *  RTXE restores the current chunk, in case an exception was raised
 *  RTXL saves the current local chunk in case exception is raised
 */
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
		if (ol == (char **) 0) \
			loc_set.st_top = l; \
		else { \
			eback(ol); \
		} \
	}
#define RTLD \
	char **l = loc_set.st_top; \
	char **ol = (char **) 0
#define RTXI(x) \
	{ \
		if (l + (x) <= loc_set.st_end) \
			loc_set.st_top += (x); \
		else \
			l = eget(x); \
	}
#define RTXE \
	loc_set.st_cur = lc; \
	loc_set.st_end = lc->sk_end; \
	loc_set.st_top = lt
#define RTXL \
	char **l = loc_set.st_top; \
	char **lt = loc_set.st_top; \
	struct stchunk *lc = loc_set.st_cur

/* Macro used to record once functions:
 *  RTOC calls onceset to record the address of Result (static variable)
 */
#define RTOC 		onceset(&Result)

/* Dynamic type of object. The name is not RTDT for historical reasons. */
#define Dtype(x) (HEADER(x)->ov_flags & EO_TYPE)

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
#define RTCT(t,x) exasrt(t, x)
#define RTCS(x) exasrt((char *) 0, x)
#define RTCK in_assertion = 0; expop(&eif_stack);
#define RTCF in_assertion = 0; eviol();
#define RTIT(t,x) exinv(t, x)
#define RTIS(x) exinv((char *) 0, x)
#define RTTE(x,y) if (!(x)) goto y 
#define RTJB goto body
#ifdef WORKBENCH
#define RTVR(x,y) if ((x) == (char *) 0) eraise(y, EN_VOID)
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
 *  RTXS(x) resynchronizes the run-time stacks in a rescue clause
 *  RTOK ends a routine with a rescue clause by cleaning the trace stack
 *  RTSO stops the tracing as well as the profiling
 */
#define RTEX struct ex_vect *exvect
#define RTED jmp_buf exenv
#define RTES if (setjmp(exenv)) goto rescue
#define RTEJ current_call_level = trace_call_level; \
	old_p_stk = prof_stack; \
	prof_stack_init(); \
	start: exvect->ex_jbuf = (char *) exenv; RTES
#define RTEA(x,y,z) exvect = exset(x, y, z)
#define RTEV exvect = exft()
#define RTET(t,x) eraise(t,x)
#define RTEC(x) RTET((char *) 0,x)
#define RTSO check_options_stop()
#ifdef WORKBENCH
#define RTEE RTSO; expop(&eif_stack)
#else
#define RTEE expop(&eif_stack)
#endif
#define RTER trace_call_level = current_call_level; \
	prof_stack_rewind(); \
	prof_stack_free(); prof_stack = old_p_stk; \
	in_assertion = 0; \
	exvect = exret(exvect); goto start
#define RTEU exresc(exvect)
#define RTEF exfail()
#define RTXS(x) RTXE; RTHS; RTXI(x)
#define RTXD RTXL; RTXH
#define RTOK exok()

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
	char **ht = hec_stack.st_top; \
	struct stchunk *hc = hec_stack.st_cur
#define RTHS \
	hec_stack.st_cur = hc; \
	hec_stack.st_end = hc->sk_end; \
	hec_stack.st_top = ht

/* Other macros used to handle specific needs:
 *  RTMS(s) creates an Eiffel string from a C manifest string s.
 *  RTST(c,d,i,n) creates an Eiffel ARRAY[ANY] (for strip).
 *  RTXA(x,y) copies 'x' into expanded 'y' with exception if 'x' is void.
 *  RTEQ(x,y) returns true if 'x' = 'y'
 *  RTIE(x) returns true if 'x' is an expanded object
 *  RTOF(x) returns the offset of expanded 'x' within enclosing object
 *  RTEO(x) returns the address of the enclosing object for expanded 'x'
 */
#define	RTMS(s) makestr(s,strlen(s))
#define	RTST(c,d,i,n) striparr(c,d,i,n);
#define RTXA(x,y) xcopy(x, y)
#define RTEQ(x,y) xequal(x, y)
#define RTIE(x) ((x) != (char *) 0 ? HEADER(x)->ov_flags & EO_EXP : 0)
#define RTOF(x) (HEADER(x)->ov_size & B_SIZE)
#define RTEO(x) ((x) - RTOF(x))

/* Macros for invariant check.
 *  RTSN saves global variable 'nstcall' within C stack
 *  RTIV(x,y) checks invariant before call on object 'x' if good flags 'y'
 *  RTVI(x,y) checks invariant after call on object 'x' if good flags 'y'
 *  RTCI(x) checks invariant after creation call on object 'x'
 */
#define RTSN int is_nested = nstcall
#ifdef WORKBENCH
#define RTIV(x,y) if (is_nested && ((y) & CK_INVARIANT)) chkinv(x,0)
#define RTVI(x,y) if (is_nested && ((y) & CK_INVARIANT)) chkinv(x,1)
#define RTCI(x) chkcinv(x)
#else
#define RTIV(x) if (~in_assertion & is_nested) chkinv(x,0)
#define RTVI(x) if (~in_assertion & is_nested) chkinv(x,1)
#define RTCI(x) if (~in_assertion) chkinv(x,1)
#endif

/* Macros for basic conversions
 * RTID(x) is the identity macro
 */

#define RTID(x) (x)

/*
 * Macros for workbench
 */

#ifdef WORKBENCH
#include "wbench.h"
#include "option.h"

/* Macros to cache assertion level in generated C routine.
 *  RTDA declares integer used to save the assertion level
 *  RTSA(x) saves assertion level for dynamic type 'x'
 *  RTAL is the access to the saved assertion level variable
 */
#define RTDA struct eif_opt opt; int current_call_level;\
	struct profile_stack *old_p_stk
#define RTSA(x) opt = eoption[x]; check_options(opt, x)
#define RTAL (~in_assertion & opt.assert_level)

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
 *  RTWPP(x,y) returns the feature address ($ operator)
 *  RTWO(x) stores in a list the body id of the just called once routine
 */
#define RTWF(x,y,z) wfeat(x,y,z)
#define RTWPF(x,y,z) wpfeat(x,y,z)
#define RTVF(x,y,z,t) wfeat_inv(x,y,z,t)
#define RTVPF(x,y,z,t) wpfeat_inv(x,y,z,t)
#define RTWA(x,y,z) wattr(x,y,z)
#define RTWPA(x,y,z) wpattr(x,y,z)
#define RTVA(x,y,z,t) wattr_inv(x,y,z,t)
#define RTVPA(x,y,z,t) wpattr_inv(x,y,z,t)
#define RTWT(x,y,z) wtype(x,y,z)
#define RTWPT(x,y,z) wptype(x,y,z)
#define RTWPP(x,y) ((eif_address_table[x])[y])
#define RTWO(x) onceadd(x)

#define WDBG(x,y)	is_debug(x,y)				/* Debug option */
#define WASC(x)		eoption[x].assert_level		/* Assertion level */

#define WASL(x,y,z)	waslist(x,y,z)			/* Assertion list evaluation */
#define WASF(x)		wasfree(x)				/* Free assertion list */

#define RTDS(x)		dispatch(x)			/* Body id of body index (x) */
#define RTFZ(x)		frozen(x)			/* C frozen pointer of body id (x) */
#define RTMT(x)		melt(x)				/* Byte code of body id (x) */

#endif

#ifndef WORKBENCH
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
#define RTTR(x,y,z)	start_trace(x,y,z)		/* Print message "entering..." */
#define RTXT(x,y,z)	stop_trace(x,y,z)		/* Print message "leaving..." */
#define RTPR(x,y,z)	start_profile(x,y,z)	/* Start measurement of feature */
#define RTXP		stop_profile()			/* Stop measurement of feature */
#define RTLT		int current_call_level; struct profile_stack *old_p_stk		/* Declare C-local variable */
#endif

#endif
