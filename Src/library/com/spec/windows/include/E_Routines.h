//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_Routines.h
//
//  Contents:	Declaration of storage routines.
//
//
//--------------------------------------------------------------------------
  
#ifndef __ECOM_E_ROUTINES_H_INC__
#define __ECOM_E_ROUTINES_H_INC__

#include <objbase.h>
#include <winbase.h>
#include "eif_except.h"
#include "ecom_rt_globals.h"

class E_Routines
{
public:
	E_Routines(){};
	~E_Routines(){};
	int ccom_is_compound_file (WCHAR * pwcsName);
};

#endif // !__ECOM_E_ROUTINES_H_INC__

