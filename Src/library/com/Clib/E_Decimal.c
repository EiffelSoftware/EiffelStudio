//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_Decimal.c
//
//  Contents: Declaration of E_Decimal macros.
//
//
//--------------------------------------------------------------------------
//
#include "E_Decimal.h"

#ifdef __cplusplus
  extern "C" {
#endif

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

EIF_DOUBLE ccom_decimal_to_double (DECIMAL * a_value)
{
  EIF_DOUBLE a_double = 0;
  HRESULT hr = VarR8FromDec (a_value, (double *)&a_double);
  if (FAILED(hr))
    a_double = 0;

  return a_double;
};

#ifdef __cplusplus
  }
#endif
