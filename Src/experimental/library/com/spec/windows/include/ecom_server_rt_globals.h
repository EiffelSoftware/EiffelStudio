/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef __ECOM_SERVER_RUNTIME_GLOBALS_H_INC__
#define __ECOM_SERVER_RUNTIME_GLOBALS_H_INC__

#include <setjmp.h>
#include "eif_eiffel.h"
#include "eif_except.h"
#include "ecom_rt_globals.h"
#include "eif_macros.h"
#include "eif_cecil.h"


#ifdef __cplusplus
extern "C" {
#endif


// Enter Eiffel COM stub code
#define ECOM_ENTER_STUB \
	unsigned char is_eif_visible_is_off = eif_visible_is_off; \
	int entered_in_eiffel_code = EIF_IS_IN_EIFFEL_CODE; \
	if (0 == entered_in_eiffel_code){ \
		EIF_ENTER_EIFFEL; \
	} \
	ECOM_CATCH(entered_in_eiffel_code);\
	eif_enable_visible_exception();

// Exit Eiffel COM stub code
#define ECOM_EXIT_STUB \
	if (is_eif_visible_is_off) { \
		eif_disable_visible_exception(); \
	} \
	if (0 == entered_in_eiffel_code) { \
		EIF_EXIT_EIFFEL; \
	}\
	ECOM_END_CATCH(entered_in_eiffel_code);

// Enter Eiffel COM procedure stub code
#define ECOM_ENTER_PROC_STUB \
	unsigned char is_eif_visible_is_off = eif_visible_is_off; \
	int entered_in_eiffel_code = EIF_IS_IN_EIFFEL_CODE; \
	if (0 == entered_in_eiffel_code){ \
		EIF_ENTER_EIFFEL; \
	} \
	eif_enable_visible_exception();

// Exit Eiffel COM procedure stub code
#define ECOM_EXIT_PROC_STUB \
	if (is_eif_visible_is_off) { \
		eif_disable_visible_exception(); \
	} \
	if (0 == entered_in_eiffel_code) { \
		EIF_EXIT_EIFFEL; \
	}

#define ECOM_CATCH(in_eiffel_code)  struct ex_vect *exvect;\
  jmp_buf exenv;\
  int return_hr_value; \
  RTEA ((char *)0,0, (char *)0);\
  exvect->ex_jbuf = &exenv;\
  if (return_hr_value = setjmp (exenv)) { \
	if (0 == in_eiffel_code) { \
		EIF_EXIT_EIFFEL; \
	} \
    return (HRESULT)(f.hresult (return_hr_value)); \
  }

#ifdef RTEOK 
	#define ECOM_END_CATCH(in_eiffel_code) \
		if (0 == in_eiffel_code) { \
			EIF_EXIT_EIFFEL; \
		} \
		exok();
#else 
	extern struct xstack eif_stack;
	#define ECOM_END_CATCH(in_eiffel_code) \
		if (0 == in_eiffel_code) { \
			EIF_EXIT_EIFFEL; \
		} \
		expop (&eif_stack);\
        exok();
#endif
	
//
// 5.7 Implementation
//
	
#define ECATCH  struct ex_vect *exvect;\
  jmp_buf exenv;\
  int return_hr_value; \
  RTEA ((char *)0,0, (char *)0);\
  exvect->ex_jbuf = &exenv;\
  if (return_hr_value = setjmp (exenv)) { \
    return (HRESULT)(f.hresult (return_hr_value)); \
  }

 
#ifdef RTEOK 
  #define END_ECATCH exok()
#else 
extern struct xstack eif_stack;
  #define END_ECATCH expop (&eif_stack);\
            exok() 
#endif

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_SERVER_RUNTIME_GLOBALS_H_INC__
