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


#ifdef __cplusplus
extern "C" {
#endif

extern int return_hr_value;
extern jmp_buf exenv;
extern struct xstack eif_stack;

#define ECATCH  struct ex_vect *exvect;\
  jmp_buf exenv;\
  RTEA ((char *)0,0, (char *)0);\
  exvect->ex_jbuf = &exenv;\
  if (return_hr_value = setjmp (exenv)) \
    return (HRESULT)(f.hresult (return_hr_value))

 
#ifdef RTEOK 
  #define END_ECATCH exok()
#else 
  #define END_ECATCH expop (&eif_stack);\
            exok() 
#endif

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_SERVER_RUNTIME_GLOBALS_H_INC__
