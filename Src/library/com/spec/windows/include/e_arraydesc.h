//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_arraydesc.h
//
//  Contents:	Accessors of ARRAYDESC structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_ARRAY_DESC_H_INC__
#define __ECOM_E_ARRAY_DESC_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"

#define ccom_arraydesc_typedesc(_ptr_) ((EIF_POINTER) &(((ARRAYDESC *)_ptr_)->tdescElem))
#define ccom_arraydesc_dim_count(_ptr_) ((EIF_INTEGER) (((ARRAYDESC *)_ptr_)->cDims))

EIF_REFERENCE ccom_arraydesc_bounds (EIF_POINTER ptr);

#endif // !__ECOM_E_ARRAY_DESC_H_INC__
