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

#ifndef __ECOM_GENERATED_RUNTIME_GLOBALS_H_INC__
#define __ECOM_GENERATED_RUNTIME_GLOBALS_H_INC__

#include <setjmp.h>
#include "ecom_rt_globals.h"
#include "ecom_generated_ec.h"
#include "ecom_generated_ce.h"
#include "objbase.h"

extern ecom_generated_ec rt_generated_ec;
extern ecom_generated_ce rt_generated_ce;

int return_hr_value;
jmp_buf exenv;

#define ECATCH if (return_hr_value = setjmp (exenv)) \
				return (HRESULT)(return_hr_value)

#endif // !__ECOM_GENERATED_RUNTIME_GLOBALS_H_INC__
