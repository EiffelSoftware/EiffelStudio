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
#ifdef EIF_BORLAND
   (*li).u.HighPart = ((long)((DWORD)i)) < 0 ? -1 : 0;
   (*li).u.LowPart = ((DWORD)i);
#else
   LISet32(*li, (DWORD)i);
#endif /* EIF_BORLAND */
};

void E_Large_Integer::ccom_set_from_large_integer(LARGE_INTEGER * large)
{
	*li = *large;
};

LARGE_INTEGER * E_Large_Integer::ccom_large_integer()
{
	return li;
};
