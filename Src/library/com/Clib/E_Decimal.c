//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_Decimal.c
//
//  Contents:	Declaration of E_Decimal macros.
//
//
//--------------------------------------------------------------------------
//
#include "E_Decimal.h"

void ccom_decimal_value_zero (DECIMAL * a_value)
{
	long zero = 0;
	VarDecFromI4(zero, a_value);
};
//--------------------------------------------------------------------------

void ccom_decimal_value_one (DECIMAL * a_value)
{
	long one = 1;
	VarDecFromI4(one, a_value);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ccom_decimal_convert_to_eiffel_decimal (DECIMAL * a_value)
{
	EIF_OBJECT decimal_object;
	EIF_TYPE_ID decimal_tid;
	EIF_PROCEDURE make_decimal;
			
	decimal_tid = eif_type_id ("ECOM_DECIMAL");
	if (decimal_tid == EIF_NO_TYPE)
		return NULL;
	
	decimal_object = eif_create (decimal_tid);
	make_decimal = eif_procedure ("make_by_pointer", decimal_tid);
	make_decimal ( eif_access (decimal_object), a_value);
									
	return eif_wean (decimal_object);
};
//------------------------------------------------------------------------
