//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_guid.c
//
//  Contents:	
//
//
//--------------------------------------------------------------------------


#include "E_guid.h"
  
//------------------------------------------------------------------
  
EIF_POINTER ccom_guid_to_wide_string (GUID * guid)

{
	WCHAR * wide_string;
	
	wide_string = (WCHAR *) malloc ((39) *(sizeof(WCHAR)));
	StringFromGUID2 (guid, wide_string, 39);
	return (EIF_POINTER)wide_string;
};
//------------------------------------------------------------------


