//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_ULarge_Integer.h
//
//  Contents:	Declaration of E_ULarge_Integer class.
//
//
//--------------------------------------------------------------------------
//
#ifndef __ECOM_E_ULARGE_INTEGER_H_INC__
#define __ECOM_E_ULARGE_INTEGER_H_INC__

#include <objbase.h>

#include "eif_cecil.h"


class E_ULarge_Integer
{
public:
	// Commands
	E_ULarge_Integer (){};
	E_ULarge_Integer (ULARGE_INTEGER * ularge);
	~E_ULarge_Integer (){};
	void ccom_set_from_integer(EIF_INTEGER i);

	// Queries
	ULARGE_INTEGER * ccom_ularge_integer();
	
private:
	ULARGE_INTEGER * puli;
	ULARGE_INTEGER uli;
};

#endif // !__ECOM_E_ULARGE_INTEGER_H_INC__
