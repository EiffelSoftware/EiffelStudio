//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_custdata.h
//
//  Contents:	Accessors of CUSTDATA structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_CUSTDATA_H_INC__
#define __ECOM_E_CUSTDADTA_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"

#define ccom_custdata_items(_ptr_) ((EIF_INTEGER) (((CUSTDATA *)_ptr_)->cCustData))

EIF_REFERENCE ccom_custdata_array (EIF_POINTER ptr);

#endif // !__ECOM_E_CUSTDATA_H_INC__
