//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_Large_Integer.h
//
//  Contents:	Declaration of E_Large_Integer class.
//
//
//--------------------------------------------------------------------------
//
#ifndef __ECOM_E_LARGE_INTEGER_H_INC__
#define __ECOM_E_LARGE_INTEGER_H_INC__

#include <objbase.h>
#include "eif_cecil.h"


class E_Large_Integer
{
public:
	// Commands
	E_Large_Integer (){};
	E_Large_Integer (LARGE_INTEGER * large);
	~E_Large_Integer (){};
	void ccom_set_from_integer(EIF_INTEGER i);

	// Queries
	LARGE_INTEGER * ccom_large_integer();
	
private:
	LARGE_INTEGER * pli;
	LARGE_INTEGER li;
};

#endif // !__ECOM_E_LARGE_INTEGER_H_INC__
