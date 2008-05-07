/*
	description: "Macros used by C code at run time."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
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

#ifndef _eif_macros_h_
#define _eif_macros_h_

#include "eif_portable.h"
#include "eif_equal.h"
#include "eif_globals.h"
#include "eif_project.h"
#include "eif_malloc.h"
#include "eif_lmalloc.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_local.h"
#include "eif_copy.h"
#include "eif_plug.h"				/* For struct bit declaration */
#include "eif_hector.h"
#include "eif_size.h"
#include "eif_gen_conf.h"
#include "eif_rout_obj.h"
#include "eif_option.h"
#include "eif_bits.h"

#ifdef WORKBENCH
#include "eif_wbench.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK void * eif_pointer_identity (void *);

/* On a BSD system, we should use _setjmp and _longjmp if they are available,
 * so that no system call is made to preserve the signal mask flag. It should
 * be taken care of by the signal handler routine.
 */
#ifdef USE_BSDJMP
#ifndef setjmp
#define setjmp _setjmp
#endif
#ifndef longjmp
#define longjmp _longjmp
#endif
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

#ifdef WORKBENCH
#define EIF_IS_WORKBENCH EIF_TRUE
#else
#define EIF_IS_WORKBENCH EIF_FALSE
#endif

/* Function pointer call to make sure all arguments are correctly pushed onto stack.
 * FUNCTION_CAST is for standard C calls.
 * FUNCTION_CAST_TYPE is for non-standard C calls.
 */
#define FUNCTION_CAST(r_type, arg_types)					(r_type (*) arg_types)
#define FUNCTION_CAST_TYPE(r_type, call_type, arg_types)	(r_type (call_type *) arg_types)


/*
 * Macro for GC synchronization
 */
#if defined(ISE_GC) && defined(EIF_THREADS)
RT_LNK int volatile eif_is_gc_collecting;
RT_LNK void eif_synchronize_for_gc(void);
RT_LNK int eif_is_in_eiffel_code(void);
RT_LNK void eif_enter_eiffel_code(void);
RT_LNK void eif_exit_eiffel_code(void);
#define RTGC	if (eif_is_gc_collecting) eif_synchronize_for_gc()
#define EIF_ENTER_EIFFEL	eif_enter_eiffel_code()
#define EIF_EXIT_EIFFEL		eif_exit_eiffel_code()
#define	EIF_ENTER_C			EIF_EXIT_EIFFEL
#define	EIF_EXIT_C			EIF_ENTER_EIFFEL
#define	EIF_IS_IN_EIFFEL_CODE		eif_is_in_eiffel_code()
#else
#define RTGC
#define EIF_ENTER_EIFFEL
#define EIF_EXIT_EIFFEL
#define EIF_ENTER_C
#define EIF_EXIT_C
#define	EIF_IS_IN_EIFFEL_CODE		1
#endif

/* Function pointer call from C to Eiffel which makes sure that all arguments are correctly
 * pushed onto stack. It takes care of the synchronization needed in a multithreaded application.
 * EIFFEL_CALL will call Eiffel procedures `proc_ptr' with `arg_values' using prototype given by
 *   `arg_types'.
 * EIFFEL_FUNCTION_CALL will call Eiffel functions `fn_ptr' with `arg_values' using prototype give
 *   by `r_type' and `arg_types'.
 */
#if defined(ISE_GC) && defined(EIF_THREADS)
#define EIFFEL_CALL(arg_types, proc_ptr, arg_values) \
	{ \
	EIF_ENTER_EIFFEL; \
	(FUNCTION_CAST(void, arg_types) proc_ptr) arg_values; \
	RTGC; \
	EIF_EXIT_EIFFEL; \
	}
#define EIFFEL_FUNCTION_CALL(r_type, arg_types, target, fn_ptr, arg_values) \
	{\
	EIF_ENTER_EIFFEL; \
	target = (FUNCTION_CAST(r_type, arg_types) fn_ptr) arg_values; \
	RTGC; \
	EIF_EXIT_EIFFEL; \
	}
#else
#define EIFFEL_CALL(arg_types, proc_ptr, arg_values) \
	(FUNCTION_CAST(void, arg_types) proc_ptr) arg_values

#define EIFFEL_FUNCTION_CALL(r_type, arg_types, target, fn_ptr, arg_values) \
	target = (FUNCTION_CAST(r_type, arg_types) fn_ptr) arg_values
#endif


/* Macro used for allocation:
 *  RTLN(x) allocates a new object of dftype 'x'
 *  RTLNS(x,y,z) allocates a new routine object of dftype 'x', dtype 'y' and size 'z'
 *  RTLNT(x) allocates a new tuple object of dftype 'x'
 *  RTLNT(x) allocates a new tuple object of dftype 'x', with 'n' elements and is_atomic 'a'
 *  RTLNSMART(x) allocates a new object of dftype 'x'
 *  RTLNR(x,y,a,o,c) allocates a new routine object of type 'x' and
 *  RTLNC(x) creates a new non-initialized instance of 'x'.
 *  RTLNSP(t,n,e,b) allocates a new special array
 *  initializes it with the routine pointer 'y', the true routine pointer 'z',
 *  argument tuple 'a', open map 'o' and closed map 'c'
 *  RTLB(x) allocated a new bit object of size 'x'
 *  RTUD keep dynamic type  for refreezing
 *  RTLX(x) allocates an expanded object (with possible in invocation
 *		of the creation routine) of type `x'
 *  RTXB(x,y) copies bit `x' to `y'
 *  RTMB(x,y) creates bit of length y bits from string value x
 *  RTEB(x,y) are bits `x' and `y' equal?
 *  RTBU(x) box a basic value stored in EIF_TYPED_VALUE and return EIF_REFERENCE
 */
#define RTLN(x)				emalloc(x)
#define RTLNS(x,y,z)		emalloc_size(x,y,z)
#define RTLNT(x)			tuple_malloc(x)
#define RTLNTS(x,n,a)		tuple_malloc_specific(x,n,a)
#define RTLNSMART(x)		smart_emalloc(x)
#define RTLNR2(a,b,c,d,e,f,g,h,i,j,k,l,m) rout_obj_create2((a),(b),(c),(d),(e),(f),(g),(h),(i),(j),(k),(l),(m))
#define RTLNRW(a,b,c,d,e,f,g,h,i,j,k,l,m) rout_obj_create_wb((a),(b),(c),(d),(e),(f),(g),(h),(i),(j),(k),(l),(m))
#define RTLNRF(a,b,c,d,e,f,g) rout_obj_create_fl((a),(b),(c),(d),(e),(f), (g))
#define RTLNC(x)			eclone(x)
#define RTLNSP2(t,f,n,e,b)	special_malloc(f,t,n,e,b)
#define RTLNSP(t,f,n,e,b)	special_malloc(t | f,n,e,b)
#define RTLB(x)				bmalloc(x)
#define RTMB(x,y)			makebit(x,y)
#define RTXB(x,y)			b_copy(x,y)
#define RTEB(x,y)			b_equal(x,y)
#define RTLX(x)				cr_exp(x)
#define RTBU(x)				eif_box(x)
#ifdef WORKBENCH
#define RTLXI(x)			init_exp(x)
#else
#define RTLXI(x)	\
	{ \
		void *(*cp)(EIF_REFERENCE) = (void *(*) (EIF_REFERENCE)) egc_exp_create [Dtype(x)]; \
		if (cp) cp(x); \
	}
#endif
#ifdef WORKBENCH
RT_LNK EIF_TYPE_INDEX fcount;
#define RTUD(x)				((x)>=fcount?(x):egc_fdtypes[x])  /* Updated dynamic type */
#else
#define RTUD(x)				(x) /* For convenience */
#endif



/* Macro used for object cloning:
 *  RTCL(x) clones 'x' and return a pointer to the cloned object
 *  RTCB(x) clones bit `x'
 *  RTRCL(x) same as RTCL, but uses a user-defined version of `copy'
 *  RTCCL(c) same as RTRCL, but first checks if `x' is expanded
 */
#define RTCL(x)		rtclone(x)
#define RTCB(x)		b_clone(x)
#define RTCCL(x)	((x && eif_is_expanded(HEADER(x)->ov_flags))? RTRCL(x): (x))
#ifdef WORKBENCH
#	define RTRCL(x)	((egc_twin(x)).it_r)
#else
#	define RTRCL(x)	egc_twin(x)
#endif


/* Macro used for object creation to get the proper creation type:
 *  RTCA(x,y) returns the dynamic type of 'x' if not void, otherwise 'y'
 */
#define RTCA(x,y) ((x) == (EIF_REFERENCE) 0 ? (y) : Dftype(x))



/* Macros used for assignments:
 *  RTAG(x) is true if 'x' is an old object not remembered
 *  RTAN(x) is true if 'x' is a new object (i.e. not old)
 *  RTAM(x) memorizes 'x'
 *  RTAR(parent,source) remembers 'parent' if it is old and not remembered and 'source' is new
 */
#ifdef ISE_GC
#define RTAG(x)		((HEADER(x)->ov_flags & (EO_OLD | EO_REM)) == EO_OLD)
#define RTAN(x)		(!(HEADER(x)->ov_flags & EO_OLD))
#define RTAM(x)		eremb(x)
#define RTAR(parent,source) check_gc_tracking(parent,source)
#else
#define RTAG(x) EIF_FALSE
#define RTAN(x) EIF_FALSE
#define RTAM(x)		(x)
#define RTAR(parent,source)
#endif



/* Macros used by reverse assignments:
 *  RTRC(x,y)       is true if type 'y' conforms to type 'x'
 *  RTRA(x,y)       calls RTRC(x, Dftype(y)) if 'y' is not void
 *  RTRB(x,y,z,t)   assigns value of basic type 't' of 'y' to 'z' if 'y' conforms to type 'x'
 *  RTRE(x,y,z)     copies 'y' to 'z' if 'y' conforms to type 'x'
 *  RTRV(x,y)       returns 'y' if it conforms to type 'x', void otherwise
 *  RTOB(t,x,y,z,v) assigns value of basic type 't' of 'y' to 'z' if 'y' conforms to type 'x' and sets boolean value to `v' accordingly
 *  RTOE(x,y,z,v)   copies 'y' to 'z' if 'y' conforms to type 'x' and sets boolean value to `v' accordingly
 */
#define RTRC(x,y)		eif_gen_conf ((y), (x))
#define RTRA(x,y)		((y) == (EIF_REFERENCE) 0 ? 0 : RTRC((x),Dftype(y)))
#define RTRB(x,y,z,t)		{ if (RTRA((x),(y))) { z = t (y); } }
#define RTRE(x,y,z)		{ if (RTRA((x),(y))) { RTXA ((y), z); } }
#define RTRV(x,y)		(RTRA((x),(y)) ? (y) : (EIF_REFERENCE) 0)
#define RTOB(t,x,y,z,v)		{ if (RTRA((x),(y))) { z = t (y); v = EIF_TRUE; } else { v = EIF_FALSE; } }
#define RTOE(x,y,z,v)		{ if (RTRA((x),(y))) { RTXA ((y), z); v = EIF_TRUE; } else { v = EIF_FALSE; } }



/* Macros used for local variable management:
 *  RTLI(x) makes room on the stack for 'x' addresses
 *  RTLE restore the previous stack context
 *  RTLD declares the variable used by RTLI/RTLE
 *  RTLR(x,y) register `y' on the stack at position `x'
 *  RTLRC(x) clear stack at position `x'
 *  RTXI(x) makes room on the stack for 'x' addresses when feature has rescue
 *  RTXE restores the current chunk, in case an exception was raised
 *  RTXL saves the current local chunk in case exception is raised
 *  RTYL same as RTXL except that RTXI cannot be applied
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
#define RTYL \
	EIF_REFERENCE * volatile lt = loc_set.st_top; \
	struct stchunk * volatile lc = loc_set.st_cur
#define RTXL \
	EIF_REFERENCE * volatile l = loc_set.st_top; \
	RTYL
#define RTLXD \
	EIF_TYPED_ADDRESS * EIF_VOLATILE lv
#define RTLXL \
	lv = cop_stack.st_top
#define RTLXE \
	while (cop_stack.st_top != lv) { \
		RTLO(1); \
	}

#else
#define RTLI(x) 
#define RTLE
#define RTLD	\
	EIF_REFERENCE ol
#define RTLR(x,y)
#define RTXI(x)
#define RTXE 
#define RTYL  EIF_REFERENCE lt
#define RTXL  EIF_REFERENCE l
#define RTLXD
#define RTLXL
#define RTLXE
#endif



/* Macro used to record once functions:
 *  RTOC calls onceset to record the address of Result (static variable)
 */
#define RTOC(x)			onceset()
#define RTOC_NEW(x)		new_onceset((EIF_REFERENCE) &x);
#define RTOC_GLOBAL(x)	globalonceset((EIF_REFERENCE) &x);

/* Macros for optimized access to once feature:
 * RTO_CP - access to once procedure
 * RTO_CF - access to once function
 */
#define RTO_CP(succeeded,c,a)		if (succeeded) { (void) a; } else { c a; }
#define RTO_CF(succeeded,result,c,a)	((succeeded)? ((void) a, result) : c a)

/* Service macros for once routines:
 * RTO_TRY - try to excute routine body
 * RTO_EXCEPT - start processing exception
 * RTO_END_EXCEPT - stop processing exception
 */

#define RTO_TRY                                                              \
	{                                                                    \
			/* Declare variables for exception handling. */      \
		struct ex_vect * exvecto;                                    \
		jmp_buf exenvo;                                              \
			/* Save stack contexts. */                           \
		RTYD;                                                        \
			/* Record execution vector to catch exception. */    \
		exvecto = extre ();                                          \
		if (!setjmp(exenvo)) {                                       \
				/* Set catch address. */                     \
			exvect->ex_jbuf = &exenvo;                           \
				/* Update routine exception vector. */       \
			exvect = exvecto;

#define RTO_EXCEPT                                                           \
				/* Remove execution vector to restore    */  \
				/* previous exception catch point.       */  \
			exvect = extrl();                                    \
		} else {                                                     \
				/* Exception occurred. */

#define RTO_END_EXCEPT                                                       \
				/* Restore stack contexts. */                \
			RTXSC;                                               \
		}                                                            \
	}

#ifdef WORKBENCH

/* Macros for once routine indexes:
 * RTOIN - name of a variable that keeps index of a once result
 * RTOID - declaration of index into once routine result table
 */
#define RTOIN(name) CAT2(name,_index)

#define RTOID(name) static ONCE_INDEX RTOIN(name);

#else

/* Macros for once routine fields:
 * RTOFN - name of a field for once feature with the given code index
 */

#define RTOFN(code_index,field_name) CAT3(o,code_index,field_name)

#endif /* WORKBENCH */

/* Macros for single-threaded once routines:
 * RTOSR - result field name (for once functions)
 * RTOSHP - declaration of variables for procedure
 * RTOSHF - declaration of variables for function
 * RTOSDP - definition of variables for procedure
 * RTOSDF - definition of variables for function
 * RTOSC - implementation of a constant attribute body
 * RTOSCP - optimized direct call to procedure
 * RTOSCF - optimized direct call to function
 * RTOSP - prologue for a single-threaded once routine
 * RTOSE - epilogue for a single-threaded once routine
 */

#define RTOSR(code_index)                                                    \
	RTOFN(code_index,_result)

#define RTOSHP(code_index)                                                   \
	extern EIF_BOOLEAN RTOFN(code_index,_done);                          \
	extern EIF_OBJECT RTOFN(code_index,_failed);                      \
	extern EIF_BOOLEAN RTOFN(code_index,_succeeded);

#define RTOSHF(type, code_index)                                             \
	RTOSHP(code_index)                                                   \
	extern type RTOSR(code_index);

#define RTOSDP(code_index)                                                   \
	EIF_BOOLEAN RTOFN(code_index,_done) = EIF_FALSE;                     \
	EIF_OBJECT RTOFN(code_index,_failed) = NULL;                         \
	EIF_BOOLEAN RTOFN(code_index,_succeeded) = EIF_FALSE;

#define RTOSDF(type, code_index)                                             \
	RTOSDP(code_index)                                                   \
	type RTOSR(code_index) = (type) 0;

#define RTOSCP(n,c,a)	RTO_CP(RTOFN(n,_succeeded),c,a)
#define RTOSCF(n,c,a)	RTO_CF(RTOFN(n,_succeeded),RTOFN(n,_result),c,a)

#define RTOSP(code_index)                                                    \
		/* Check if evaluation has succeeded. */                     \
		/* If yes, skip any other calculations. */                   \
	if (!RTOFN(code_index,_succeeded)) {                                 \
			/* Check if evaluation is started earlier. */        \
			/* If yes, evaluation is completed.        */        \
		if (!RTOFN(code_index,_done)) {                              \
				/* Evaluation has not been started yet.   */ \
				/* Start it now.                          */ \
			RTOFN(code_index,_done) = EIF_TRUE;                  \
				/* Try to exceute routine body. */           \
			RTO_TRY

#define RTOSE(code_index)                                                    \
				/* Record successful execution result. */    \
			RTOFN(code_index,_succeeded) = EIF_TRUE;             \
				/* Catch exception. */                       \
			RTO_EXCEPT                                           \
				/* Handle exception.                */       \
				/* Record exception for future use. */       \
			RTOFN(code_index,_failed) = eif_protect(RTLA);                  \
			RTO_END_EXCEPT                                       \
		}                                                            \
		if (RTOFN(code_index,_failed)) {                             \
			if (eif_access(RTOFN(code_index,_failed)))							\
				oraise (eif_access(RTOFN(code_index,_failed)));                  \
		}                                                            \
	}

#define RTOSC(code_index, value)                                             \
	if (!RTOFN (code_index,_succeeded)) {                                \
		RTOC_NEW (RTOSR (code_index));                               \
		RTOSR (code_index) = (value);                                \
		RTOFN (code_index,_succeeded) = EIF_TRUE;                    \
	}                                                                    \
	return RTOSR (code_index);

/* Macros for thread-relative once routines:
 * RTOTS - stores index of a once routine into index variable given its code index
 * RTOTDB, RTOUDB - declaration and initialization of variables for once function returning basic type
 * RTOTDR, RTOUDR - declaration and initialization of variables for once function returning reference
 * RTOTDV, RTOUDV - declaration and initialization of variables for once procedure
 * RTOTW - stores in a list the body id of the just called once routine
 * RTOTRB - declaration of a result macro for once function returning basic type
 * RTOTRR - declaration of a result macro for once function returning reference
 * RTOUC - implementation of a constant attribute
 * RTOUCP - optimized direct call to procedure
 * RTOUCB - optimized direct call to function returning basic type
 * RTOUCR - optimized direct call to function returning reference type
 * RTOTP - prologue for a thread-relative once routine
 * RTOTE - epilogue for a thread-relative once routine
 */

#ifdef WORKBENCH

#define RTOTS(code_index, name)                                              \
	RTOIN(name) = once_index (code_index);

#define RTOTDV(name)                                                         \
	MTOT OResult = (MTOT) MTOI(RTOIN(name));

#define RTOTDB(type, name)                                                   \
	RTOTDV(name)                                                         \
	if (!MTOD(OResult)) {                                                \
		MTOP(type, OResult, (type) 0);                               \
	}

#define RTOTDR(name)                                                         \
	RTOTDV(name)                                                         \
	if (!MTOD(OResult)) {                                                \
		MTOP(EIF_REFERENCE, OResult, RTOC(0));                       \
		MTOE(OResult, RTOC(0));										\
	}

#define RTOTW(body_id)

#define RTOTC(name, body_id, v)                                              \
	RTOTDV(name)                                                         \
	EIF_REFERENCE * PResult = MTOR(EIF_REFERENCE,OResult);               \
	EIF_TYPED_VALUE r;                                                   \
	r.type = SK_REF;                                                     \
	if (PResult) {                                                       \
		r.it_r = *PResult;                                           \
		return r;                                                    \
	}                                                                    \
	MTOP(EIF_REFERENCE, OResult, RTOC(0));                               \
	MTOE(OResult, RTOC(0));												\
	MTOM(OResult);                                                       \
	r.it_r = RTOTRR = v;                                                 \
	return r;

#define RTOTOK

#elif defined EIF_THREADS

#define RTOTOK OResult->succeeded = EIF_TRUE;

#define RTOUCP(once_index,c,a)		RTO_CP(MTOI(once_index)->succeeded,c,a)
#define RTOUCB(type,once_index,c,a)	RTO_CF(MTOI(once_index)->succeeded,MTOR(type,MTOI(once_index)),c,a)
#define RTOUCR(once_index,c,a)		RTO_CF(MTOI(once_index)->succeeded,*MTOR(EIF_REFERENCE,MTOI(once_index)),c,a)

#define RTOUDV(once_index)                                                   \
	MTOT OResult = (MTOT) MTOI(once_index);

#define RTOUDB(type, once_index)                                             \
	RTOUDV(once_index)                                                   \
	if (!MTOD(OResult)) {                                                \
		MTOP(type, OResult, (type) 0);                               \
	}

#define RTOUDR(once_index)                                                   \
	RTOUDV(once_index)                                                   \
	if (!MTOD(OResult)) {                                                \
		MTOP(EIF_REFERENCE, OResult, RTOC(0));                       \
		MTOE(OResult, RTOC(0));										\
	}

#define RTOUC(once_index, value)                                             \
	RTOUDV(once_index)                                                   \
	EIF_REFERENCE Result;                                                \
	EIF_REFERENCE * PResult = MTOR(EIF_REFERENCE,OResult);               \
	if (PResult) {                                                       \
		Result = *PResult;                                           \
	}                                                                    \
	else {                                                               \
		PResult = RTOC(0);                                           \
		MTOP(EIF_REFERENCE,OResult,PResult);                         \
		Result = (value);                                            \
		*PResult = Result;                                           \
		MTOM(OResult);                                               \
		RTOTOK                                                       \
	}                                                                    \
	return Result;

#endif /* WORKBENCH */

#define RTOTRB(type) MTOR(type,OResult)
#define RTOTRR (*MTOR(EIF_REFERENCE,OResult))

#define RTOTP                                                                \
		/* Check if evaluation is started earlier. */                \
		/* If yes, evaluation is completed.        */                \
	if (!MTOD(OResult)) {                                                \
			/* Evaluation has not been started yet.   */         \
			/* Start it now.                          */         \
		MTOM(OResult);                                               \
			/* Try to exceute routine body. */                   \
		RTO_TRY

#define RTOTE                                                                \
			/* Record that execution completed successfully */   \
		RTOTOK                                                       \
			/* Catch exception. */                               \
		RTO_EXCEPT                                                   \
			/* Handle exception. */                              \
			/* Record exception for future use. */               \
		MTOE(OResult, RTOC(0));									\
		MTOEV(OResult, RTLA);                                       \
		RTO_END_EXCEPT                                               \
	}																	\
	if (MTOF(OResult)) {                                                 \
		if (*MTOF(OResult))												\
			oraise (*MTOF(OResult));                                      \
	}

#ifdef EIF_THREADS

/* Service macros for process-relative once routines:
 * RTOPL - lock a mutex of a once routine
 * RTOPLT - try to lock a mutex of a once routine
 * RTOPLU - unlock a mutex of a once routine
 * RTOPMBW - write memory barrier when available
 * RTOPW - let thread that started once evaluation to complete
 * RTOPLP - once prologue that is executed with locked mutex
 * RTOPLE - once epilogue that is executed with locked mutex
 * RTOPRE - raise previously recorded exception
 */

#ifdef EIF_HAS_MEMORY_BARRIER
#	define RTOPMBW EIF_MEMORY_WRITE_BARRIER
#else
#	define RTOPMBW
#endif

#define RTOPL(mutex)                                                         \
	EIF_ENTER_C;                                                         \
	eif_thr_mutex_lock (mutex);                                          \
	EIF_EXIT_C;                                                          \
	RTGC

#define RTOPLT(mutex)                                                        \
	eif_thr_mutex_trylock (mutex)

#define RTOPLU(mutex)                                                        \
	eif_thr_mutex_unlock (mutex)

#define RTOPW(mutex, thread_id)                                              \
		/* Once routine evaluation has been started.         */      \
		/* To wait until evaluation is completed,            */      \
		/* it's enough to lock and unlock a mutex,           */      \
		/* then the mutex should be recursive.               */      \
		/* Recursive mutexes are not in POSIX standard,      */      \
		/* so they should be emulated by checking thread id. */      \
		/* Check what thread performs evaluation.            */      \
	if (thread_id != eif_thr_thread_id()) {                              \
			/* Evaluation is performed by a different thread. */ \
			/* Wait until it completes evaluation.            */ \
		RTOPL (mutex);                                               \
		RTOPLU (mutex);                                              \
	}

#define RTOPLP(started, thread_id)                                           \
		/* Check if some thread started evaluation earlier. */       \
		/* If yes, evaluation is completed.                 */       \
	if (!started) {                                                      \
			/* Evaluation has not been started yet.   */         \
			/* Record thread id and start evaluation. */         \
		thread_id = eif_thr_thread_id();                             \
		started = EIF_TRUE;                                          \
			/* Try to exceute routine body. */                   \
		RTO_TRY

#define RTOPLE(completed,failed,thread_id)                                   \
			/* Catch exception. */                               \
		RTO_EXCEPT                                                   \
			/* Handle exception.                */               \
			/* Record exception for future use. */               \
		RTOC_GLOBAL(failed);										\
		failed = RTLA;												\
		RTO_END_EXCEPT                                               \
			/* Clear field that holds locking thread id. */      \
		thread_id = NULL;                                            \
			/* Ensure memory is flushed (if required). */        \
		RTOPMBW;                                                     \
			/* Mark evaluation as completed. */                  \
		completed = EIF_TRUE;                                        \
	}

#define RTOPRE(failed)                                                       \
	if (failed) {                                                        \
		oraise (failed);                                             \
	}

#ifdef EIF_HAS_MEMORY_BARRIER

#	define RTOFP(started, completed, mutex, thread_id)                               \
		EIF_MEMORY_READ_BARRIER;                                                 \
		if (!completed) {                                                        \
				/* Once evaluation is not completed yet.           */    \
				/* Check whether once evaluation has been started. */    \
			if (started) {                                                   \
					/* Evaluation has been started. */               \
					/* Let it to complete.          */               \
				RTOPW(mutex, thread_id);                                 \
			}                                                                \
			else {                                                           \
					/* Current thread has not started evaluation. */ \
					/* It's safe to lock a mutex.                 */ \
				RTOPL (mutex);                                           \
					/* Use thread-safe prologue. */                  \
				RTOPLP (started, thread_id);

#	define RTOFE(completed, failed, mutex, thread_id)                                \
					/* Use thread-safe epilogue. */                  \
				RTOPLE (completed, failed, thread_id);                   \
					/* Unlock mutex. */                              \
				RTOPLU (mutex);                                          \
			}                                                                \
		}                                                                        \
		RTOPRE(failed)

#else /* !defined(EIF_HAS_MEMORY_BARRIER) */

#	define RTOFP(started, completed, mutex, thread_id)                               \
			/* Try to lock a mutex. */                                       \
		if (RTOPLT (mutex)) {                                                    \
				/* Mutex has been locked.                       */       \
				/* Check if once evaluation has been completed. */       \
			if (!completed) {                                                \
					/* Evaluation is not completed. */               \
					/* Use thread-safe prologue.    */               \
				RTOPLP (started, thread_id);

#	define RTOFE(completed, failed, mutex, thread_id)                                \
					/* Use thread-safe epilogue. */                  \
				RTOPLE (completed, failed, thread_id);                     \
			}                                                                \
					/* Unlock mutex. */                              \
			RTOPLU (mutex);                                                  \
		}                                                                        \
		else {                                                                   \
				/* Mutex cannot be locked.      */                       \
				/* Evaluation has been started. */                       \
				/* Let it to complete.          */                       \
			RTOPW (mutex, thread_id);                                        \
		}                                                                        \
		RTOPRE(failed)

#endif /* EIF_HAS_MEMORY_BARRIER */

#ifdef WORKBENCH
/* Main for process-relative once routines in workbench mode:
 * RTOQS - stores index of a once routine into index variable given its code index
 */

#define RTOQS(code_index, name)                                              \
	RTOIN(name) = process_once_index (code_index);

#define RTOQDV(name)                                                         \
	EIF_process_once_value_t * POResult =                                \
		EIF_process_once_values + RTOIN(name);                       \
	MTOT OResult = &(POResult -> value);							\
	MTOE(OResult, &(POResult -> exception));

#define RTOQDB(type, name)                                                   \
	RTOQDV(name)

#define RTOQDR(name)                                                         \
	RTOQDV(name)                                                         \
	MTOP(EIF_REFERENCE, OResult, &(POResult -> reference));				\

#define RTOQRB(type) MTOR(type,OResult)
#define RTOQRR (*MTOR(EIF_REFERENCE,OResult))

#define RTOQP                                                                \
	RTOFP (                                                              \
		POResult -> value.done,                                      \
		POResult -> completed,                                       \
		POResult -> mutex,                                           \
		POResult -> thread_id                                        \
	)

#define RTOQE                                                                \
	RTOFE (                                                              \
		POResult -> completed,                                       \
		*(POResult -> value.exception),                                    \
		POResult -> mutex,                                           \
		POResult -> thread_id                                        \
	)

#else

/* Main macros for process-relative once routines in finalized mode:
 * RTOPH - declaration of variables (that is used to refer to the variables)
 * RTOPD - definition of variables
 * RTOPI - initialization of variables
 * RTOPP - prologue
 * RTOPE - epilogue */

#define RTOPR(code_index)                                                    \
	RTOFN(code_index,_result)

#define RTOPHP(code_index)                                                   \
	extern EIF_BOOLEAN RTOFN(code_index,_started);                       \
	extern EIF_BOOLEAN RTOFN(code_index,_completed);                     \
	extern EIF_REFERENCE RTOFN(code_index,_failed);                      \
	extern EIF_MUTEX_TYPE * RTOFN(code_index,_mutex);                    \
	extern EIF_POINTER RTOFN(code_index,_thread_id);

#define RTOPHF(type, code_index)                                             \
	RTOPHP(code_index)                                                   \
	extern type RTOPR(code_index);

#define RTOPDP(code_index)                                                   \
	volatile EIF_BOOLEAN RTOFN(code_index,_started) = EIF_FALSE;         \
	volatile EIF_BOOLEAN RTOFN(code_index,_completed) = EIF_FALSE;       \
	volatile EIF_REFERENCE RTOFN(code_index,_failed) = NULL;                \
	volatile EIF_MUTEX_TYPE * RTOFN(code_index,_mutex) = NULL;           \
	volatile EIF_POINTER RTOFN(code_index,_thread_id) = NULL;

#define RTOPDF(type, code_index)                                             \
	RTOPDP(code_index)                                                   \
	volatile type RTOPR(code_index) = (type) 0;

#define RTOPI(code_index)                                                    \
	RTOFN(code_index,_mutex) = eif_thr_mutex_create ();

#define RTOPP(code_index)                                                    \
	RTOFP (                                                              \
		RTOFN(code_index,_started),                                  \
		RTOFN(code_index,_completed),                                \
		RTOFN(code_index,_mutex),                                    \
		RTOFN(code_index,_thread_id)                                 \
	)

#define RTOPE(code_index)                                                    \
	RTOFE (                                                              \
		RTOFN(code_index,_completed),                                \
		RTOFN(code_index,_failed),                                   \
		RTOFN(code_index,_mutex),                                    \
		RTOFN(code_index,_thread_id)                                 \
	)

#ifdef EIF_HAS_MEMORY_BARRIER

#define RTOPCP(code_index,c,a)                                               \
	EIF_MEMORY_READ_BARRIER;                                             \
	RTO_CP(                                                              \
		RTOFN(code_index,_completed) && (!RTOFN(code_index,_failed)),  \
		c,                                                           \
		a                                                            \
	)

#define RTOPCF(code_index,c,a)                                               \
	((void) EIF_MEMORY_READ_BARRIER,                                     \
	RTO_CF(                                                              \
		RTOFN(code_index,_completed) && (!RTOFN(code_index,_failed)),  \
		RTOPR(code_index),                                           \
		c,                                                           \
		a                                                            \
	))

#else

#define RTOPCP(code_index,c,a) {c a;}
#define RTOPCF(code_index,c,a) (c a)

#endif /* EIF_HAS_MEMORY_BARRIER */

#endif /* WORKBENCH */

#endif /* EIF_THREADS */


/* Macro used for object information:
 * Dtype:		Dynamic type of object. The name is not RTDT for historical reasons.
 * Dftype:		Full dynamic type of object - for generic conformance
 * RT_DFS(x,y):	Set dynamic type and full dynamic type `y' to overhead `x'.
 * To_dtype:	Convert a Full dynamic type to a dynamic type
 * RTCDT:		Compute `dtype' of Current
 * RTCDD:		Declare `dtype' for later computation of Dtype of Current.
 */

#define Dftype(x) 		(HEADER(x)->ov_dftype)
#define Dtype(x) 		(HEADER(x)->ov_dtype)
#define To_dtype(t) 	(eif_cid_map[t])

#define RT_DFS(x,y)		((x)->ov_dftype = y, (x)->ov_dtype = To_dtype(y))
#define RTCDT			EIF_TYPE_INDEX EIF_VOLATILE dtype = Dtype(Current)
#define RTCDD			EIF_TYPE_INDEX EIF_VOLATILE dtype
#define RTCFDT			EIF_TYPE_INDEX EIF_VOLATILE dftype = Dftype(Current)
#define RTCFDD			EIF_TYPE_INDEX EIF_VOLATILE dftype

/* If call on void target are detected, we use RTCV to perform the check. Unlike the workbench
 * mode, we won't know the message of the call as it would require too much data to be generated. */
#if !defined(WORKBENCH) && !defined(EIF_NO_RTCV)
#define RTCV(x) eif_check_call_on_void_target(x)
#else
#define RTCV(x)	(x)
#endif

/* Detect catcall at runtime for argument 'o' at position 'i' for feature 'f' in dtype 'd'
 * and expected dftype 't'. */
#define RTCC(o,d,f,i,t) eif_check_catcall_at_runtime(o,d,f,i,t)


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
 *  RTED declares the setjmp buffer, saved_assertion and saved_except
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
 *  RTYD same as RTXD except that RTXI cannot be used
 *  RTXSC resynchronizes the run-time stacks in a pseudo rescue clause in C
 *  RTXS(x) resynchronizes the run-time stacks in a rescue clause
 *  RTEOK ends a routine with a rescue clause by cleaning the trace stack
 *  RTSO stops the tracing as well as the profiling
 *	RTLA Last exception from EXCEPTION_MANAGER
 *	RTCO(x) Check if x is NULL, if not raise an OLD_VIOLATION
 *  RTE_T start try block (for body)
 *  RTE_E start except block (for rescue)
 *  RTE_EE end except block
 *	RTE_OT start try block of old expression evaluation
 *	RTE_O end of try block of old expression evaluation
 *	RTE_OE local rescue, recording possible exception for later use
 *	RTE_OTD Declare old stack vector and push it.
 *  RTE_OP Pop old stack vector.
 *  RTDBGE,RTDBGL are declared in eif_debug.h
 */
#define RTED		jmp_buf exenv; int EIF_VOLATILE saved_assertion = in_assertion
#define RTES		if (setjmp(exenv)) goto rescue
#define RTEA(x,y,z)	exvect = new_exset(MTC x, y, z, 0, 0, 0)
#define RTEV		exvect = exft()
#define RTET(t,x)	eraise(t,x)
#define RTEC(x)		RTET((EIF_REFERENCE) 0,x)
#define RTSO		check_options_stop()
#define RTLA		last_exception()
#define RTCO(x)		chk_old(x)

#ifdef WORKBENCH
#define RTEX		struct ex_vect * EIF_VOLATILE exvect; uint32 EIF_VOLATILE db_cstack
#define RTEAA(x,y,z,i,j,b) exvect = new_exset(x, y, z,i,j,b); db_cstack = ++d_data.db_callstack_depth;
#define RTDBGEAA(y,z,b)		RTDBGE(y,b,z,db_cstack);
#define RTDBGLE		RTDBGL(exvect->ex_orig,exvect->ex_bodyid,exvect->ex_id,db_cstack); 

#define RTEE		RTSO; d_data.db_callstack_depth = --db_cstack; expop(&eif_stack)
#define RTEOK		RTSO; d_data.db_callstack_depth = --db_cstack; exok ()

#define RTEJ		current_call_level = trace_call_level; \
					if (prof_stack) saved_prof_top = prof_stack->st_top; \
					start: exvect->ex_jbuf = &exenv; RTES

#define RTEU 		d_data.db_callstack_depth = db_cstack; exresc(MTC exvect);	\
					RTDBGR(exvect->ex_orig,exvect->ex_bodyid,exvect->ex_id,db_cstack);

#define RTE_T \
	current_call_level = trace_call_level; \
	if (prof_stack) saved_prof_top = prof_stack->st_top; \
	saved_except = RTLA; \
	start: exvect->ex_jbuf = &exenv; \
	if (!setjmp(exenv)) {

#else
#define RTEX		struct ex_vect * EIF_VOLATILE exvect
#define RTEAA(x,y,z,i,j,b) exvect = new_exset(x, y, z, 0, 0, 0)
#define RTDBGEAA(y,z,b)
#define RTEE		expop(&eif_stack)
#define RTEOK		exok ()
#define RTEJ		start: exvect->ex_jbuf = &exenv; RTES
#define RTEU		exresc(MTC exvect)

#define RTE_T \
	saved_except = RTLA; \
	start: exvect->ex_jbuf = &exenv; \
	if (!setjmp(exenv)) {

#endif

#define RTER		in_assertion = saved_assertion; \
					exvect = exret(exvect); goto start
#define RTEF		exfail()
#define RTXS(x)		RTXSC; RTXI(x)
#define RTXSC		RTXE; RTHS; RTLS
#define RTXD		RTXL; RTXH; RTXLS
#define RTYD		RTYL; RTXH; RTXLS

#define RTE_E \
	} else { \
		RTEU;
#define RTE_EE \
		RTEF; \
	}			\
	set_last_exception (saved_except);
	

/* new debug */
#ifdef WORKBENCH
#define RTLU(x,y)		insert_local_var (x, (void *) y)
#define RTLO(n)			clean_local_vars (n)
#define RTHOOK(n)		dstop (exvect, n);
#define RTNHOOK(n,m)	dstop_nested (exvect, n, m);
#else
#define RTLU(x,y)
#define RTLO(n)	
#define RTHOOK(n)		exvect->ex_linenum = n
#define RTNHOOK(n,m)
#endif

/* Old expression evaluation */
#define RTE_OT { \
					RTE_OTD; \
					if (!setjmp(exenv_o)) {
#define RTE_O	\
					RTE_OP; \
					} else {
#define RTE_OE	\
					} \
				}

#define RTE_OTD \
					jmp_buf exenv_o; \
					struct ex_vect * EIF_VOLATILE exvect_o; \
					exvect_o = exold (); \
					exvect_o->ex_jbuf = &exenv_o
#define RTE_OP \
					expop(&eif_stack)

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
#ifdef ISE_GC
#define RTHP(x) hrecord(x)
#define RTHF(x) epop(&hec_stack, x)
#define RTXH \
	EIF_REFERENCE * volatile ht = hec_stack.st_top; \
	struct stchunk * volatile hc = hec_stack.st_cur
#define RTHS \
	if (ht){ \
		hec_stack.st_cur = hc; \
		if (hc) hec_stack.st_end = hc->sk_end; \
		hec_stack.st_top = ht; \
	}else if (hec_stack.st_top) { \
		hec_stack.st_cur = hec_stack.st_hd; \
		hec_stack.st_top = hec_stack.st_cur->sk_arena; \
		hec_stack.st_end = hec_stack.st_cur->sk_end; \
	}
#else
#define RTHP(x) (x)
#define RTHF(x)
#define RTXH \
	EIF_REFERENCE ht
#define RTHS
#endif

/* Loc stack protection:
 * RTXLS saves loc_stack context in case an exception occurs
 * RTLS resynchronizes the loc_stack by restoring saved context
 */
#ifdef ISE_GC
#define RTXLS \
	EIF_REFERENCE * volatile lst = loc_stack.st_top; \
	struct stchunk * volatile lsc = loc_stack.st_cur
#define RTLS \
	if (lst){ \
		loc_stack.st_cur = lsc; \
		if (lsc) loc_stack.st_end = lsc->sk_end; \
		loc_stack.st_top = lst; \
	}else if (loc_stack.st_top) { \
		loc_stack.st_cur = loc_stack.st_hd; \
		loc_stack.st_top = loc_stack.st_cur->sk_arena; \
		loc_stack.st_end = loc_stack.st_cur->sk_end; \
	}
#else
#define RTXLS \
	EIF_REFERENCE lst
#define RTLS
#endif



/* Other macros used to handle specific needs:
 *  RTMS(s) creates an Eiffel string from a C manifest string s.
 *  RTMS_EX(s,c) creates an Eiffel string from a C manifest string s of length c.
 *  RTMS_EX_H(s,c,h) creates an Eiffel string from a C manifest string s of length c and hash-code h.
 *  RTMS_EX_O(s,c,h) creates an Eiffel string in heap for old objects from a C manifest string s of length c and hash-code h.
 *  RTOMS(b,n) a value of a once manifest string object for routine body index `b' and number `n'.
 *  RTDOMS(b,m) declares a field to store once manifest string objects for routine body index `b' and number `n' of such objects.
 *  RTEOMS(b,m) "extern" reference to the field declared by RTDOMS.
 *  RTAOMS(b,m) allocates memory to store at least `m' once manifest strings for routine body index `b'.
 *  RTPOMS(b,n,s,c,h) stores a new once manifest string object of value `s', length `c' and has-code `h' for body index `b' and number `n' if such object is not already created.
 *  RTCOMS(r,b,n,s,c,h) does the same as RTPOMS, but also puts the corresponding object into `r'.
 *  RTPOF(p,o) returns the C pointer of the address p + o where p represents a C pointer.
 *  RTST(c,d,i,n) creates an Eiffel ARRAY[ANY] (for strip).
 *  RTXA(x,y) copies 'x' into expanded 'y' with exception if 'x' is void.
 *  RTEQ(x,y) returns true if 'x' = 'y'
 *  RTIE(x) returns true if 'x' is an expanded object
 *  RTOF(x) returns the offset of expanded 'x' within enclosing object
 *  RTEO(x) returns the address of the enclosing object for expanded 'x'
 */
#define	RTMS(s)			makestr_with_hash(s,strlen(s),0)
#define	RTMS_EX(s,c)	makestr_with_hash(s,c,0)
#define	RTMS_EX_H(s,c,h)	makestr_with_hash(s,c,h)
#define RTMS_EX_O(s,c,h)	makestr_with_hash_as_old(s,c,h)

#if defined(WORKBENCH) || defined(EIF_THREADS)
#define RTOMS(b,n)	(EIF_oms[(b)][(n)])
#define RTAOMS(b,m) \
		{ \
			EIF_REFERENCE ** p; \
			p = &(EIF_oms[(b)]); \
			if (!(*p)) { \
				EIF_REFERENCE * pm; \
				pm = (EIF_REFERENCE *) eif_calloc (m, sizeof (EIF_REFERENCE *)); \
				if (!pm) { \
					enomem(); \
				} \
				*p = pm; \
			} \
		}
#define RTCOMS(r,b,n,s,c,h) \
		{ \
			EIF_REFERENCE * rsp; \
			EIF_REFERENCE rs; \
			rsp = &RTOMS(b,n); \
			rs = *rsp; \
			if (!rs) { \
				register_oms (rsp); \
				rs = RTMS_EX_O(s,c,h); \
				*rsp = rs; \
			} \
			r = rs; \
		}
#else
#define RTOMS(b,n)	CAT2(EIF_oms_,b) [n]
#define RTDOMS(b,m)	EIF_REFERENCE RTOMS(b,m)
#define RTEOMS(b,m)	extern RTDOMS(b,m)
#define RTPOMS(b,n,s,c,h) \
		{ \
			EIF_REFERENCE * rsp; \
			rsp = &RTOMS(b,n); \
			if (!(*rsp)) { \
				register_oms (rsp); \
				*rsp = RTMS_EX_O(s,c,h); \
			} \
		}
#endif

#define RTPOF(p,o)		(EIF_POINTER)((EIF_POINTER *)(((char *)(p))+(o)))
#define	RTST(c,d,i,n)	striparr(c,d,i,n);
#define RTXA(x,y)		eif_xcopy(x, y)
#define RTEQ(x,y)		eif_xequal((x),(y))
#define RTCEQ(x,y)		(((x) && eif_is_boxed_expanded(HEADER(x)->ov_flags) && (y) && eif_is_boxed_expanded(HEADER(y)->ov_flags) && eif_gen_conf(Dftype(x), Dftype(y)))? eif_xequal((x),(y)): (x)==(y))
#define RTIE(x)			((x) != (EIF_REFERENCE) 0 ? eif_is_nested_expanded(HEADER(x)->ov_flags) : 0)
#define RTOF(x)			(HEADER(x)->ov_size & B_SIZE)
#define RTEO(x)			((x) - RTOF(x))


/* Old Macros for invariant check.
 *  RTIV(x,y) checks invariant before call on object 'x' if good flags 'y'
 *  RTVI(x,y) checks invariant after call on object 'x' if good flags 'y'
 *  RTCI(x) checks invariant after creation call on object 'x'
 */
#ifdef WORKBENCH
#define RTIV(x,y)		if (is_nested && ((y) & CK_INVARIANT)) chkinv(MTC x,0)
#define RTVI(x,y)		if (is_nested && ((y) & CK_INVARIANT)) chkinv(MTC x,1)
#define RTCI(x)			chkcinv(MTC x)
#else
#define RTIV(x)			if (~in_assertion && is_nested) chkinv(MTC x,0)
#define RTVI(x)			if (~in_assertion && is_nested) chkinv(MTC x,1)
#define RTCI(x)			if (~in_assertion) chkinv(MTC x,1)
#endif

/* New Macros for invariant check.
 *  RTSN saves global variable 'nstcall' within C stack
 *  RTIV(x,y) checks invariant before call on object 'x' if good flags 'y'
 *  RTVI(x,y) checks invariant after call on object 'x' if good flags 'y'
 *  RTCI(x) checks invariant after creation call on object 'x'
 */
#define RTSN int EIF_VOLATILE is_nested = nstcall
#define RTIV2(x,y)		if (is_nested && ((y) & CK_INVARIANT)) chkinv(MTC x,0)
#define RTVI2(x,y)		if (is_nested && ((y) & CK_INVARIANT)) chkinv(MTC x,1)
#define RTCI2(x)			chkcinv(MTC x)


/* Generic conformance
 *  RTCID(tp,x,y,z) converts a type array into a single id
 *  RTFCID(ct,x,y,z) fetches the creation type of a generic feature in final mode
*/

#define RTCID(tp,x,y,z)	\
		((x) ? eif_compound_id((tp), Dftype(x),(y),(z)) : \
		 eif_compound_id ((tp), 0, (y), (z)))
#define RTCID2(tp,x,y,z)	\
		eif_compound_id((tp), (x),(y),(z))
#define RTFCID(ct,x,y,z,u)	eif_final_id((x),(y), Dftype(z),(u))
#define RTFCID2(ct,x,y,z,u)	eif_final_id((x),(y),(z),(u))
#define RTGPTID(st,x,y)		eif_gen_param_id ((st), Dftype(x),(y))
#ifdef WORKBENCH
#define RTID(x)	eif_id_for_typarr(x)
#else
#define RTID(x) (x)
#endif



#ifndef EIF_THREADS
	RT_LNK int16 caller_assertion_level;	/*Saves information about the assertionlevel of the caller*/
#endif


/* Macros to cache assertion level in generated C routine.
 * RTDA declares integer used to save the assertion level
 * RTAL is the access to the saved assertion level variable.
 * RTAC Checks the assertion level of the caller.
 * RTSC saves assertion level of the current feature.
 * RTRS restores the caller_assertion_level.
 * WASC(x) Assertion level.
 * RTSA(x) saves assertion level for dynamic type 'x'
 */

#define RTDA		struct eif_opt * EIF_VOLATILE opt; \
		int16 saved_caller_assertion_level = caller_assertion_level
#define RTAL		(~in_assertion & opt->assert_level)
#define RTAC		(~in_assertion & saved_caller_assertion_level)
#define RTSC		caller_assertion_level = RTAL & CK_SUP_REQUIRE
#define RTRS		caller_assertion_level = saved_caller_assertion_level
#define WASC(x)		eoption[x].assert_level	
#ifdef WORKBENCH
#define RTSA(x)		opt = eoption + x; check_options(opt, x)
#else
#define RTSA(x)		opt = eoption + x
#endif


 /*
 * Macros for workbench
 */

#ifdef WORKBENCH

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
 *  RTWPP(x) returns the feature address ($ or agent operator) of id x. The ids are assigned int ADDRESS_TABLE.
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
#define RTWPP(x)			(egc_address_table[x])
#define RTWO(x)

#define WDBG(x,y)			is_debug(x,y)				/* Debug option */

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
	RTAR(ptr_current, val); \
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
		RTAR(CAT2(x,_area), val); \
		}

#define RTAP_BASIC(cast,x,val,i) \
	*(cast*)(CAT2(x,_area_minus_lower)+(i)*sizeof(cast)) = val;

#ifdef __cplusplus
}
#endif

#endif



