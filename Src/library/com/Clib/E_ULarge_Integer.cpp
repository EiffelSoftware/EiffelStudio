//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_ULarge_Integer.cpp
//
//  Contents:	Implementation of E_Large_Integer class.
//
//
//--------------------------------------------------------------------------
//

#include "E_ULarge_Integer.h"

void E_ULarge_Integer::ccom_set_from_integer (EIF_INTEGER i)
{
	
#ifdef EIF_BORLAND
	(uli).u.HighPart = 0;
	(uli).u.LowPart = ((DWORD)i);
#else
	ULISet32(uli, (DWORD)i);
#endif /* EIF_BORLAND */
	puli = &uli;
};

E_ULarge_Integer::E_ULarge_Integer(ULARGE_INTEGER * large)
{
	puli = large;
};

ULARGE_INTEGER * E_ULarge_Integer::ccom_ularge_integer()
{
	return puli;
};
