//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_safe_array.cpp
//
//  Contents:	SAFEARRAY qwrapper class implementation. 
//
//
//--------------------------------------------------------------------------

#include "E_safe_array.h"

// Commands
//-------------------------------------------------------------------------
E_safe_array::E_safe_array (EIF_POINTER p_safearray)

// Constuctor
// Make from pointer
{
	p_struct = (SAFEARRAY *)p_safearray;
};
//-------------------------------------------------------------------------
E_safe_array::E_safe_array (EIF_INTEGER vt, EIF_INTEGER cDims, EIF_POINTER rgsabound)

// Constructor
// Create new structure by specifications
// 	Arguments:
// vt - type of safearray argument. See VARENUM enumeration for possible values
// cDims - count of array dimensions
// rgsabound - array of SAFEARRAYBOUND structures specifying bounds for each domension
{
	p_struct = SafeArrayCreate ((VARTYPE)vt, (UINT) cDims, (SAFEARRAYBOUND *) rgsabound);
};
//-------------------------------------------------------------------------
E_safe_array::E_safe_array (EIF_INTEGER vt, EIF_INTEGER lLbound, EIF_INTEGER cElements)

// Constructor
// Create one-dimentional array
// 	Arguments:
// vt - type of safearray argument. See VARENUM enumeration for possible values
// lLbound - The lower bound for the array. Can be negative. 
// cElements - The number of elements in the array. 
{
	p_struct = SafeArrayCreateVector((VARTYPE) vt, (LONG) lLbound, (ULONG) cElements);
};
//-------------------------------------------------------------------------
void E_safe_array::ccom_put_element (EIF_INTEGER * rgIndices, EIF_POINTER an_element)

// Put element into array
{
	HRESULT hr;
	hr = SafeArrayPutElement (p_struct, (LONG *) rgIndices, (void *) an_element);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
};
//-------------------------------------------------------------------------
void E_safe_array::ccom_destroy_struct ()

// Desctroy SAFEARRAY structure
{
	HRESULT hr;
	hr = SafeArrayDestroy (p_struct);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
};
//-------------------------------------------------------------------------

// Queries

//-------------------------------------------------------------------------
EIF_INTEGER E_safe_array::ccom_dim_count ()

// Number of dimensions of SAFEARRAY
{
	return (EIF_INTEGER) SafeArrayGetDim (p_struct);
};
//--------------------------------------------------------------------------
EIF_INTEGER E_safe_array::ccom_lower_bound (EIF_INTEGER dimension)

// Lower bound in `dimension'
{
	LONG l_bound;
	HRESULT hr;
	hr = SafeArrayGetLBound(p_struct, (UINT) (dimension - 1), &l_bound);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return (EIF_INTEGER)l_bound;
};
//----------------------------------------------------------------------------
EIF_INTEGER E_safe_array::ccom_upper_bound (EIF_INTEGER dimension)

// Upper bound in `dimension'
{
	LONG u_bound;
	HRESULT hr;
	hr = SafeArrayGetUBound(p_struct, (UINT) (dimension - 1), &u_bound);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return (EIF_INTEGER)u_bound;
};
//----------------------------------------------------------------------------
void E_safe_array::ccom_element (EIF_INTEGER * rgIndices, EIF_POINTER pv)

// Get element
// 	Arguments:
// rgIndices - Pointer to vector of indexes for each dimension of array. 
//	The right-most (least significant) dimension is rgIndices[0]. 
//	The left-most dimension is stored at rgIndices[psa->cDims - 1]. 
// pv - Pointer to location to place element of array.
//	The caller must provide storage area of correct size to receive data.
{	
	HRESULT hr;
	hr = SafeArrayGetElement(p_struct, (LONG *) rgIndices, (void *) pv);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
};
//----------------------------------------------------------------------------
EIF_POINTER E_safe_array::ccom_item ()

// Pointer to SAFEARRAY structure
{
	return (EIF_POINTER) p_struct;
};
//----------------------------------------------------------------------------

