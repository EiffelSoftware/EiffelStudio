//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		ecom_generated_rt_globals.h
//
//  Contents: 	Global variables used by EiffelCOM wizard
//
//--------------------------------------------------------------------------

#ifndef __ECOM_SERVER_RUNTIME_GLOBALS_H_INC__
#define __ECOM_SERVER_RUNTIME_GLOBALS_H_INC__

#include <setjmp.h>
#include "ecom_generated_rt_globals.h"
#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int return_hr_value;
extern jmp_buf exenv;

#define ECATCH	struct ex_vect *exvect;\
	jmp_buf exenv;\
	exvect = exset((char *) 0, 0, (char *) 0);\
	exvect->ex_jbuf = (char *) exenv;\
	if (return_hr_value = setjmp (exenv)) \
		return (HRESULT)(MAKE_HRESULT (1, FACILITY_ITF, 1024 + return_hr_value))

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_SERVER_RUNTIME_GLOBALS_H_INC__
