//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   ecom_rt_globals.h
//
//  Contents:   Global variables used by EiffelCOM wizard
//
//--------------------------------------------------------------------------

#ifndef __ECOM_RUNTIME_GLOBALS_H_INC__
#define __ECOM_RUNTIME_GLOBALS_H_INC__

#include "ecom_exception.h"
#include "ecom_runtime_c_e.h"
#include "ecom_runtime_e_c.h"

#ifdef __cplusplus

extern "C" Formatter  f;

extern "C" ecom_runtime_ce rt_ce;

extern "C" ecom_runtime_ec rt_ec;

#endif // __cplusplus

#endif // !__ECOM_RUNTIME_GLOBALS_H_INC__
