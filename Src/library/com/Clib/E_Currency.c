//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_Currency.h
//
//  Contents:	Declaration of E_Currency macros.
//
//
//--------------------------------------------------------------------------
//

#include "E_Currency.h"

void ccom_currency_value_zero (CY * a_value)
{
	long zero = 0;
	VarCyFromI4 (zero, a_value);
}

// One value
void ccom_currency_value_one (CY * a_value)
{
	long one = 1;
	VarCyFromI4 (one, a_value);
}

EIF_REFERENCE ccom_currency_convert_to_eiffel_currency (CY * a_value)
{
	EIF_OBJECT currency_object;
	EIF_TYPE_ID currency_tid;
	EIF_PROCEDURE make_currency;

	currency_tid = eif_type_id ("ECOM_CURRENCY");
	if (currency_tid == EIF_NO_TYPE)
		return NULL;

	currency_object = eif_create (currency_tid);
	make_currency = eif_procedure ("make_by_pointer", currency_tid);
	make_currency ( eif_access (currency_object), a_value);

	return eif_wean (currency_object);
}
