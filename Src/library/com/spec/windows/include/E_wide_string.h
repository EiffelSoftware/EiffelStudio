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
#include "eif_macros.h"


class E_wide_string
{
public:
	// Commands
	E_wide_string(){};
	~E_wide_string();
	void ccom_create_from_string (char * string);
	void ccom_initialize_wide_string (EIF_POINTER other_wide_string);
	EIF_OBJ ccom_wide_str_to_string ();
	
	
	// Queries
	WCHAR * ccom_wide_str_pointer();
private:
	WCHAR * wide_string;
};

#endif // !__ECOM_E_WIDE_STRING_H_INC__
