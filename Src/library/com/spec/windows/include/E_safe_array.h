//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_safe_array.h
//
//  Contents:	SAFEARRAY wrapper class declaration.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_SAFE_ARRAY_H_INC__
#define __ECOM_E_SAFE_ARRAY_H_INC__

#include <objbase.h>
#include <oleauto.h>
#include "eif_eiffel.h"
#include "eif_except.h"
#include "ecom_exception.h"

class E_safe_array
{
public:
	// Commands
	E_safe_array (EIF_POINTER p_safearray);
	E_safe_array (EIF_INTEGER vt, EIF_INTEGER cDims, EIF_POINTER rgsabound);
	E_safe_array (EIF_INTEGER vt, EIF_INTEGER lLbound, EIF_INTEGER cElements);
	~E_safe_array (){};
	void ccom_put_element (EIF_INTEGER * rgIndices, EIF_POINTER an_element);	
	void ccom_destroy_struct ();
	// Queries
	EIF_INTEGER ccom_dim_count ();
	EIF_INTEGER ccom_lower_bound (EIF_INTEGER dimension);
	EIF_INTEGER ccom_upper_bound (EIF_INTEGER dimension);
	void ccom_element (EIF_INTEGER * rgIndices, EIF_POINTER pv);
	EIF_POINTER ccom_item ();
private:
	SAFEARRAY * p_struct;
};

#endif // !__ECOM_E_SAFE_ARRAY_H_INC__

