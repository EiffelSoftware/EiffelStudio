//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_wide_string.h
//
//  Contents:	Declaration of E_wide_string class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_WIDE_STRING_H_INC__
#define __ECOM_E_WIDE_STRING_H_INC__

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "eif_eiffel.h"

WCHAR * ccom_create_from_string (char * string);	
EIF_REFERENCE ccom_wide_str_to_string ();
	
#endif // !__ECOM_E_WIDE_STRING_H_INC__
