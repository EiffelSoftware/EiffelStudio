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
