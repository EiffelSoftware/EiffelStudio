//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_Large_Integer.cpp
//
//  Contents:	Implementation of E_Large_Integer class.
//
//
//--------------------------------------------------------------------------
//

#include "E_Large_Integer.h"

void E_Large_Integer::ccom_set_from_integer (EIF_INTEGER i)
{
	pli = &li;
#ifdef EIF_BORLAND
   (*pli).u.HighPart = ((long)((DWORD)i)) < 0 ? -1 : 0;
   (*pli).u.LowPart = ((DWORD)i);
#else
   LISet32(*pli, (DWORD)i);
#endif /* EIF_BORLAND */
};

E_Large_Integer::E_Large_Integer (LARGE_INTEGER * large)
{
	pli = large;
};

LARGE_INTEGER * E_Large_Integer::ccom_large_integer()
{
	return pli;
};
