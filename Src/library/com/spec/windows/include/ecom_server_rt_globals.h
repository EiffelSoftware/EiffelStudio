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

extern int return_hr_value;
extern jmp_buf exenv;

#define ECATCH if (return_hr_value = setjmp (exenv)) \
				return (HRESULT)(return_hr_value)

#endif // !__ECOM_SERVER_RUNTIME_GLOBALS_H_INC__
