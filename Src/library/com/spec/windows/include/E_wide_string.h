//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_wide_string.h
//
//  Contents: Declaration of E_wide_string class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_WIDE_STRING_H_INC__
#define __ECOM_E_WIDE_STRING_H_INC__

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "eif_eiffel.h"

#ifdef __cplusplus
  extern "C" {
#endif

WCHAR * ccom_create_from_string (char * string);
EIF_REFERENCE ccom_wide_str_to_string (WCHAR * wide_string);

#ifdef __cplusplus
  }
#endif

#endif // !__ECOM_E_WIDE_STRING_H_INC__
