//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_Decimal.h
//
//  Contents: Declaration of E_Decimal macros.
//
//
//--------------------------------------------------------------------------
//
#ifndef __ECOM_E_DECIMAL_H_INC__
#define __ECOM_E_DECIMAL_H_INC__

#include <objbase.h>
#include <oleauto.h>
#include "eif_eiffel.h"

#define ccom_decimal_round(_ptr_, _value_, _ptr_2) VarDecRound(_ptr_,_value_,_ptr_2)
#define ccom_decimal_negative(_ptr_, _ptr_2) VarDecNeg(_ptr_,_ptr_2)
#define ccom_decimal_integer(_ptr_, _ptr_2) VarDecInt(_ptr_,_ptr_2)
#define ccom_decimal_fix(_ptr_, _ptr_2) VarDecFix(_ptr_,_ptr_2)
#define ccom_decimal_absolute(_ptr_, _ptr_2) VarDecAbs(_ptr_,_ptr_2)
#define ccom_decimal_subtract(_ptr_, _ptr_2,_ptr_3) VarDecSub(_ptr_,_ptr_2,_ptr_3)
#define ccom_decimal_multiply(_ptr_, _ptr_2,_ptr_3) VarDecMul(_ptr_,_ptr_2,_ptr_3)
#define ccom_decimal_add(_ptr_, _ptr_2,_ptr_3) VarDecAdd(_ptr_,_ptr_2,_ptr_3)
#define ccom_decimal_divide(_ptr_, _ptr_2, _ptr_3) VarDecDiv(_ptr_, _ptr_2, _ptr_3)
#define ccom_decimal_scale(_ptr_) ((EIF_INTEGER) (_ptr_)->scale)

#ifdef __cplusplus
  extern "C" {
#endif

void ccom_decimal_value_zero (DECIMAL * a_value);

void ccom_decimal_value_one (DECIMAL * a_value);

EIF_DOUBLE ccom_decimal_to_double (DECIMAL * a_value);

#ifdef __cplusplus
  }
#endif

#endif // !__ECOM_E_DECIMAL_H_INC__
