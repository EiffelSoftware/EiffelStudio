//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_variant.h
//
//  Contents:	Accessors of VARIANT structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_VARIANT_H_INC__
#define __ECOM_E_VARIANT_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"

#define ccom_variant_variable_type(_ptr_) ((EIF_INTEGER) (((VARIANT *)_ptr_)->vt))

#define ccom_variant_char(_ptr_) ((EIF_CHARACTER) (((VARIANT *)_ptr_)->bVal))
#define ccom_variant_char_byref(_ptr_) ((EIF_CHARACTER) *(((VARIANT *)_ptr_)->pbVal))

#define ccom_variant_integer2(_ptr_) ((EIF_INTEGER) (((VARIANT *)_ptr_)->iVal))
#define ccom_variant_integer2_byref(_ptr_) ((EIF_INTEGER) *(((VARIANT *)_ptr_)->piVal))

#define ccom_variant_integer4(_ptr_) ((EIF_INTEGER) (((VARIANT *)_ptr_)->lVal))
#define ccom_variant_integer4_byref(_ptr_) ((EIF_INTEGER) *(((VARIANT *)_ptr_)->plVal))

#define ccom_variant_real4(_ptr_) ((EIF_REAL) (((VARIANT *)_ptr_)->fltVal))
#define ccom_variant_real4_byref(_ptr_) ((EIF_REAL) *(((VARIANT *)_ptr_)->pfltVal))

#define ccom_variant_real8(_ptr_) ((EIF_DOUBLE) (((VARIANT *)_ptr_)->dblVal))
#define ccom_variant_real8_byref(_ptr_) ((EIF_DOUBLE) *(((VARIANT *)_ptr_)->pdblVal))

#define ccom_variant_bool(_ptr_) ((EIF_INTEGER) (((VARIANT *)_ptr_)->boolVal))
#define ccom_variant_bool_byref(_ptr_) ((EIF_INTEGER) *(((VARIANT *)_ptr_)->pboolVal))

#define ccom_variant_date(_ptr_) ((EIF_DOUBLE) (((VARIANT *)_ptr_)->date))
#define ccom_variant_date_byref(_ptr_) ((EIF_DOUBLE) *(((VARIANT *)_ptr_)->pdate))

#define ccom_variant_error(_ptr_) ((EIF_INTEGER) (((VARIANT *)_ptr_)->scode))
#define ccom_variant_error_byref(_ptr_) ((EIF_INTEGER) *(((VARIANT *)_ptr_)->pscode))

#define ccom_variant_safearray(_ptr_) ((EIF_POINTER)(((VARIANT *)_ptr_)->parray))
#define ccom_variant_safearray_byref(_ptr_) ((EIF_POINTER) *(((VARIANT *)_ptr_)->pparray))

#define ccom_variant_variant(_ptr_) ((EIF_POINTER) (((VARIANT *)_ptr_)->pvarVal))

#endif // !__ECOM_E_VARIANT_H_INC__
