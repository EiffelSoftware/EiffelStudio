//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_guid.h
//
//  Contents:	Accessors of GUID structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_GUID_H_INC__
#define __ECOM_E_GUID_H_INC__

#include <oaidl.h>
#include <objbase.h>
#include <stdio.h>
#include "eif_eiffel.h"

#define ccom_string_to_guid(_pwchar_,_p_guid_) (CLSIDFromString ((LPOLESTR)_pwchar_, (LPCLSID)_p_guid_))

#ifdef __cplusplus
#define ccom_is_equal_guid(_guid1_,_guid2_) ((IsEqualGUID((REFGUID)*(_guid1_),(REFGUID)*(_guid2_)) == FALSE)? EIF_FALSE : EIF_TRUE)
#else
#define ccom_is_equal_guid(_guid1_,_guid2_) ((IsEqualGUID((REFGUID)(_guid1_),(REFGUID)(_guid2_)) == FALSE)? EIF_FALSE : EIF_TRUE)
#endif

EIF_POINTER ccom_guid_to_wide_string (GUID * guid);
EIF_REFERENCE ccom_guid_to_defstring (GUID * guid);

#endif // !__ECOM_E_GUID_H_INC__
