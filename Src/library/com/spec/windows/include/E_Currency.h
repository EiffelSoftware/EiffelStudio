//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_Currency.h
//
//  Contents: Declaration of E_Currency macros.
//
//
//--------------------------------------------------------------------------
//
#ifndef __ECOM_E_CURRENCY_H_INC__
#define __ECOM_E_CURRENCY_H_INC__

#include <objbase.h>
#include <oleauto.h>
#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#define ccom_currency_round(_ptr_,_value_,_ptr_2) VarCyRound((*_ptr_), _value_,_ptr_2)
#define ccom_currency_negative(_ptr_, _ptr_2) VarCyNeg( (*_ptr_),_ptr_2)
#define ccom_currency_integer(_ptr_, _ptr_2) VarCyInt( (*_ptr_),_ptr_2)
#define ccom_currency_fix(_ptr_, _ptr_2) VarCyFix( (*_ptr_),_ptr_2)
#define ccom_currency_absolute(_ptr_, _ptr_2) VarCyAbs( (*_ptr_),_ptr_2)
#define ccom_currency_set_high_bits(_ptr_, _value_) ((_ptr_)->Hi=(unsigned long)_value_)
#define ccom_currency_set_low_bits(_ptr_, _value_) ((_ptr_)->Lo=(long)_value_)
#define ccom_currency_high_bits(_ptr_) ((EIF_INTEGER) (_ptr_)->Hi)
#define ccom_currency_low_bits(_ptr_) ((EIF_INTEGER) (_ptr_)->Lo)
#define ccom_currency_add(_ptr_, _ptr_2,_ptr_3) VarCyAdd( (*_ptr_), (*_ptr_2),_ptr_3)
#define ccom_currency_multiply(_ptr_, _ptr_2,_ptr_3) VarCyMul( (*_ptr_), (*_ptr_2),_ptr_3)
#define ccom_currency_multiply_by_4bytes_integer(_ptr_, _ptr_2,_ptr_3) VarCyMulI4((*_ptr_),_ptr_2,_ptr_3)
#define ccom_currency_subtract(_ptr_, _ptr_2,_ptr_3) VarCySub((*_ptr_), (*_ptr_2),_ptr_3)


// Zero value
void ccom_currency_value_zero (CY * a_value);

// convert to double value
EIF_DOUBLE ccom_currency_to_double (CY * a_value);

// One value
void ccom_currency_value_one (CY * a_value);

EIF_REFERENCE ccom_currency_convert_to_eiffel_currency (CY * a_value);

#ifdef __cplusplus
  }
#endif

#endif // !__ECOM_E_CURRENCY_H_INC__
