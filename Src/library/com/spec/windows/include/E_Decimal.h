//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_Decimal.h
//
//  Contents:	Declaration of E_Decimal macros.
//
//
//--------------------------------------------------------------------------
//
#ifndef __ECOM_E_DECIMAL_H_INC__
#define __ECOM_E_DECIMAL_H_INC__

#include <objbase.h>
#include <oleauto.h>
#include "eif_eiffel.h"

#define ccom_decimal_round(_ptr_, _value_, _ptr_2) VarDecRound( (DECIMAL*)_ptr_, _value_, (DECIMAL*)_ptr_2)
#define ccom_decimal_negative(_ptr_, _ptr_2) VarDecNeg( (DECIMAL*)_ptr_, (DECIMAL*)_ptr_2)
#define ccom_decimal_integer(_ptr_, _ptr_2) VarDecInt( (DECIMAL*)_ptr_, (DECIMAL*)_ptr_2)
#define ccom_decimal_fix(_ptr_, _ptr_2) VarDecFix( (DECIMAL*)_ptr_, (DECIMAL*)_ptr_2)
#define ccom_decimal_absolute(_ptr_, _ptr_2) VarDecAbs( (DECIMAL*)_ptr_, (DECIMAL*)_ptr_2)
#define ccom_decimal_subtract(_ptr_, _ptr_2,_ptr_3) VarDecSub((DECIMAL*)_ptr_, (DECIMAL*)_ptr_2, (DECIMAL*)_ptr_3)
#define ccom_decimal_multiply(_ptr_, _ptr_2,_ptr_3) VarDecMul((DECIMAL*)_ptr_, (DECIMAL*)_ptr_2, (DECIMAL*)_ptr_3)
#define ccom_decimal_add(_ptr_, _ptr_2,_ptr_3) VarDecAdd((DECIMAL*)_ptr_, (DECIMAL*)_ptr_2, (DECIMAL*)_ptr_3)
#define ccom_decimal_divide(_ptr_, _ptr_2, _ptr_3) VarDecDiv((DECIMAL *)_ptr_, (DECIMAL *)_ptr_2, (DECIMAL *)_ptr_3) 

void ccom_decimal_value_zero (DECIMAL * a_value);

void ccom_decimal_value_one (DECIMAL * a_value);

EIF_REFERENCE ccom_decimal_convert_to_eiffel_decimal (DECIMAL * a_value);

#endif // !__ECOM_E_DECIMAL_H_INC__
