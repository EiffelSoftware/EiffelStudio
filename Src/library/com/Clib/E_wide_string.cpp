//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_wide_string.cpp
//
//  Contents:	Implementation of E_wide_string class.
//
//
//--------------------------------------------------------------------------


#include "E_wide_string.h"

E_wide_string::~E_wide_string()
{
	free (wide_string);
};
void E_wide_string::ccom_create_from_string (char * string)
{
	size_t size, str_size;
	str_size = strlen(string);
	size = mbstowcs(NULL, string, str_size + 1);
	wide_string = (WCHAR *) malloc ((size+1) *(sizeof(WCHAR)));
	mbstowcs(wide_string, string, str_size + 1);
};
//--------------------------------------------------------------------------
void E_wide_string::ccom_initialize_wide_string (EIF_POINTER other_wide_string)
{
	size_t size;
	size = wcslen((WCHAR *)other_wide_string);
	wide_string = (WCHAR *)malloc((size+1) *(sizeof(WCHAR)));
	memcpy (wide_string, (WCHAR *)other_wide_string, (size+1) *(sizeof(WCHAR)));
};
//---------------------------------------------------------------------------
EIF_OBJ E_wide_string::ccom_wide_str_to_string ()
{
	EIF_OBJ local_obj;
	char * string;
	size_t size, size_wide;

	size_wide = wcslen(wide_string);
	size = wcstombs (NULL, wide_string, size_wide + 1);
	string = (char *)malloc(size + 1);

	wcstombs (string, wide_string, size_wide + 1);
	local_obj = RTMS(string);
	free (string);
	return local_obj;
}
//--------------------------------------------------------------------------

WCHAR * E_wide_string::ccom_wide_str_pointer()
{
	return wide_string;
}
