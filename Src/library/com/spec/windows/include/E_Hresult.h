//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_Hresult.h
//
//  Contents: Declaration of E_Hresult functions 
//
//--------------------------------------------------------------------------
//
#ifndef __ECOM_E_HRESULT_H_INC__
#define __ECOM_E_HRESULT_H_INC__

#include <winerror.h>
#include "eif_eiffel.h"

#define ccom_hresult_error_code(a_ptr) HRESULT_ERROR_CODE(*((HRESULT *)a_ptr))
#define ccom_hresult_facility_code(a_ptr) HRESULT_FACILITY(*((HRESULT *)a_ptr))
#define ccom_hresult_succeeded(a_ptr) (SUCCEEDED(*((HRESULT *)a_ptr))? return EIF_TRUE: return EIF_FALSE)
#define ccom_hresult_make_hresult(a_int, b_int, c_int) (MAKE_HRESULT((unsigned long)a_int, (unsigned long)b_int, (unsigned long)c_int))

#endif // !__ECOM_E_HRESULT_H_INC__
