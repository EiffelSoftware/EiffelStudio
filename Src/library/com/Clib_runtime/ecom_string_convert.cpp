//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File: string_convert.cpp
//
//  Contents: String convertion functions
//
//
//--------------------------------------------------------------------------

#include <stdio.h>
#include "ecom_string_convert.h"

#include "eif_cecil.h"

////////////////////////////////////////////////////////////////////////////
// Wide strings to Eiffel strings
////////////////////////////////////////////////////////////////////////////

extern "C" EIF_REFERENCE OleString2EiffelString( LPCOLESTR oleString )
{
    char *loc = OleString2CString( oleString);
	return CString2EiffelString( loc );
}

////////////////////////////////////////////////////////////////////////////
// Wide strings to C strings
////////////////////////////////////////////////////////////////////////////

extern "C" char* OleString2CString( LPCOLESTR oleString )
{
    static char* space = " ";
    BOOL flag = FALSE;
    int len;
    int i;
	char *result;

    // Calculate the length of the UNICODE string
    i = 0;
    while( oleString[i] != 0 )
    {
        i++;
    }

    len = i;
	result = (char*)(malloc ((len + 1)* sizeof (char)));
    memset( result, 0, len + 1 );
    // Convert UNICODE string to ANSI string
    WideCharToMultiByte( CP_ACP, 0, oleString,
            len, result, len + 1, space, &flag );
	return result;
}

////////////////////////////////////////////////////////////////////////////
// C strings to Wide strings
////////////////////////////////////////////////////////////////////////////

extern "C" LPOLESTR CString2OleString( EIF_POINTER EString )
{
    LPOLESTR result;
    int len, wlen;

    // Calculate the length of ANSI string
    len = strlen( EString );
    // Calculate the appropriate length of corresponding UNICODE str
    wlen = ( len + 1 ) * 2;
    // Allocate the space for the UNICODE string
    result = (LPOLESTR)calloc( 1, wlen );
    // Zeroize it
    memset( result, 0, wlen );
    // Convert ANSI string to UNICODE string
    MultiByteToWideChar( CP_ACP, MB_PRECOMPOSED, EString,
            len, result, wlen );
    // return the UNICODE string
    return result;
}

////////////////////////////////////////////////////////////////////////////
// C strings to GUIDs
////////////////////////////////////////////////////////////////////////////

extern "C" GUID CString2Guid( EIF_POINTER str )
{
	GUID *result = (GUID *)malloc (sizeof (GUID));
	
	CLSIDFromString (CString2OleString (str), result);
	return *result;
}

////////////////////////////////////////////////////////////////////////////
// C strings to Eiffel strings
////////////////////////////////////////////////////////////////////////////

extern "C" EIF_REFERENCE CString2EiffelString( char* cstring )
{
	return makestr (cstring, strlen (cstring));
}

////////////////////////////////////////////////////////////////////////////
// GUIDs to Eiffel strings
////////////////////////////////////////////////////////////////////////////

extern "C" EIF_REFERENCE Guid2EiffelString( REFIID guid )
{
    return CString2EiffelString (Guid2CString (guid));
}

////////////////////////////////////////////////////////////////////////////
// GUIDs to C strings
////////////////////////////////////////////////////////////////////////////

extern "C" char* Guid2CString( REFGUID refguid )
{
   char *result;
   HRESULT res;
   LPOLESTR poleStr;

   res = StringFromCLSID (refguid, &poleStr);
   result = OleString2CString (poleStr);
   return result;
}





