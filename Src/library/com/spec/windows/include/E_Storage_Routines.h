//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_Storage_Routines.h
//
//  Contents:	Declaration of storage routines.
//
//
//--------------------------------------------------------------------------
  
#ifndef __ECOM_E_STORAGE_ROUTINES_H_INC__
#define __ECOM_E_STORAGE_ROUTINES_H_INC__

#include <objbase.h>
#include "eif_except.h"
#include "ecom_exception.h"

class E_Storage_Routines
{
public:
	E_Storage_Routines(){};
	~E_Storage_Routines(){};
	int ccom_is_compound_file (WCHAR * pwcsName);
};

#endif // !__ECOM_E_STORAGE_ROUTINES_H_INC__

